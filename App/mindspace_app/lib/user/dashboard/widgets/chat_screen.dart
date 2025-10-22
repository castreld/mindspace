import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mindspace_app/models/appointment.dart';
import 'package:mindspace_app/models/conversation.dart';
import 'package:mindspace_app/models/user.dart';
import 'package:mindspace_app/services/auth_service.dart';
import 'package:mindspace_app/services/chat_service.dart';
import 'package:mindspace_app/config.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'websocket_setup/websocket_channel_stub.dart'
    if (dart.library.html) 'websocket_setup/websocket_channel_html.dart'
    if (dart.library.io) 'websocket_setup/websocket_channel_io.dart';

class ChatScreen extends StatefulWidget {
  final Conversation conversation;
  final bool isTwoPane;

  const ChatScreen({super.key, required this.conversation, required this.isTwoPane});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  ChatMessage? _selectedMessage;
  List<ChatMessage> _messages = [];
  bool _isLoading = true;
  User? _currentUser;
  int? _otherUserId;

  WebSocketChannel? _channel;
  bool _isWebSocketConnected = false;

  @override
  void initState() {
    super.initState();
    _currentUser = context.read<AuthService>().currentUser;
    _otherUserId = _getOtherUserId();
    _fetchInitialMessages();
    _initWebSocket();
  }

  int _getOtherUserId() {
    return widget.conversation.otherUserId;
  }

  Future<void> _fetchInitialMessages() async {
    try {
      final token = context.read<AuthService>().token;
      if (token == null) throw Exception('Authentication token not found.');
      
      final messages = await context.read<ChatService>().getMessagesByConversationId(
        token, 
        widget.conversation.id
      );
      
      if (mounted) {
        setState(() {
          _messages = messages;
          _isLoading = false;
        });
        _scrollToBottom();
      }
    } catch (e) {
      if (mounted) {
        if (e.toString().contains('404')) {
          Navigator.of(context).pop('deleted');
        } else {
          setState(() { _isLoading = false; });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal memuat pesan: $e'))
          );
        }
      }
    }
  }

  void _initWebSocket() async {
    final token = context.read<AuthService>().token;
    final conversationId = widget.conversation.id;

    if (token == null) {
      debugPrint('✗ WebSocket setup failed: Auth token is null.');
      return;
    }

    try {
      String wsUrl = 'ws://${AppConfig.webSocketHost}:8080/app/${AppConfig.webSocketPusherAppKey}';
      
      debugPrint('🔌 Connecting to WebSocket: $wsUrl');

      // Use the platform-specific function from conditional import
      _channel = createWebSocketChannel(wsUrl);

      _channel!.stream.listen(
        (dynamic message) {
          debugPrint('📨 Received: $message');
          try {
            final data = jsonDecode(message);
            
            if (data['event'] == 'pusher:connection_established') {
              debugPrint('✓ WebSocket connected');
              if (mounted) {
                setState(() => _isWebSocketConnected = true);
              }
              final socketId = jsonDecode(data['data'])['socket_id'];
              _subscribeToChannel(conversationId.toString(), socketId, token);

            } else if (data['event'] == 'pusher_internal:subscription_succeeded') {
              debugPrint('✓ Successfully subscribed to channel');
              
            } else if (data['event'] == 'MessageSent') {
              debugPrint('📬 New message received!');
              try {
                final messageData = data['data'] is String 
                    ? jsonDecode(data['data']) 
                    : data['data'];
                final newMessage = ChatMessage.fromJson(messageData['message']);

                final isDuplicate = _messages.any((msg) => msg.id == newMessage.id);
                if (!isDuplicate && mounted) {
                  setState(() => _messages.add(newMessage));
                  _scrollToBottom();
                  debugPrint('✓ Message added to UI');
                } else {
                  debugPrint('⚠ Duplicate message ignored');
                }
              } catch (e) {
                debugPrint('✗ Error processing message: $e');
              }
            } else if (data['event'] == 'MessageDeleted') {
              debugPrint('🗑️ Message deletion event received!');
              try {
                final messageData = data['data'] is String 
                    ? jsonDecode(data['data']) 
                    : data['data'];
                
                final int deletedMessageId = messageData['message_id'];
                
                if (mounted) {
                  setState(() {
                    _messages.removeWhere((msg) => msg.id == deletedMessageId);
                  });
                  debugPrint('✓ Message with ID $deletedMessageId removed from UI');
                }
              } catch (e) {
                debugPrint('✗ Error processing message deletion event: $e');
              }
            } else {
              debugPrint('📨 Other event: ${data['event']}');
            }
          } catch (e) {
            debugPrint('✗ Error parsing message: $e');
          }
        },
        onError: (error) {
          debugPrint('✗ WebSocket error: $error');
          if (mounted) setState(() => _isWebSocketConnected = false);
        },
        onDone: () {
          debugPrint('✗ WebSocket closed');
          if (mounted) setState(() => _isWebSocketConnected = false);
        },
      );
    } catch (e) {
      debugPrint("✗ ERROR initializing WebSocket: $e");
    }
  }

  void _subscribeToChannel(String conversationId, String socketId, String token) async {
    final channelName = 'private-chat.$conversationId';
    try {
      final authResponse = await http.post(
        Uri.parse('${AppConfig.backendBaseUrl}/api/broadcasting/auth'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'socket_id': socketId,
          'channel_name': channelName,
        }),
      );

      debugPrint('Auth response status: ${authResponse.statusCode}');
      debugPrint('Auth response body: ${authResponse.body}');

      if (authResponse.statusCode == 200) {
        final authData = jsonDecode(authResponse.body);
        final authSignature = authData['auth'];

        final subscribeMessage = jsonEncode({
          'event': 'pusher:subscribe',
          'data': {
            'channel': channelName,
            'auth': authSignature,
          },
        });
        _channel?.sink.add(subscribeMessage);
        debugPrint('✓ Subscription request sent for channel: $channelName');
      } else {
         debugPrint('✗ Channel auth failed with status: ${authResponse.statusCode}');
         debugPrint('✗ Response: ${authResponse.body}');
      }
    } catch (e) {
      debugPrint('✗ Error during channel auth/subscription: $e');
    }
  }

  void _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final String messageText = text;
    
    _messageController.clear();
    
    try {
      final token = context.read<AuthService>().token;
      if (token == null) throw Exception('Authentication token not found.');
      
      final sentMessage = await context.read<ChatService>().sendMessage(
        token, 
        _otherUserId!, 
        messageText
      );

      final isDuplicate = _messages.any((msg) => msg.id == sentMessage.id);
      if (mounted && !isDuplicate) {
        setState(() {
          _messages.add(sentMessage);
        });
        _scrollToBottom();
      }
    } catch (e) {
      if (mounted) {
        _messageController.text = messageText;

        if (e.toString().contains('403') && e.toString().contains('No accepted conversation found')) {
          _showConversationDeletedDialog();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal mengirim pesan: $e'), backgroundColor: Colors.red)
          );
        }
      }
    }
  }

  void _handleDeleteMessage(ChatMessage message) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Pesan?'),
        content: const Text('Apakah Anda yakin ingin menghapus pesan ini secara permanen?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        final token = context.read<AuthService>().token!;
        await context.read<ChatService>().deleteMessage(token, message.id);

        if (mounted) {
          setState(() {
            _messages.removeWhere((m) => m.id == message.id);
            _selectedMessage = null;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Pesan berhasil dihapus.'), backgroundColor: Colors.green)
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal menghapus pesan: $e'), backgroundColor: Colors.red)
          );
        }
      }
    }
  }
  
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  void _showConversationDeletedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          icon: Icon(Icons.forum_outlined, color: Colors.orange.shade700, size: 48),
          title: const Text(
            'Gagal Mengirim Pesan',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Percakapan tidak ditemukan, mungkin telah dihapus oleh orang yang kamu hubungi.',
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.orange.shade100,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(
                'OK',
                style: TextStyle(color: Colors.orange.shade800, fontWeight: FontWeight.bold),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _channel?.sink.close();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          color: const Color(0xFF5B3F5B),
          child: Row(
            children: [
              if (!widget.isTwoPane)
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              Expanded(
                child: Text(
                  widget.conversation.name,
                  style: const TextStyle(
                    fontSize: 16, 
                    fontWeight: FontWeight.bold, 
                    color: Colors.white
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (_isWebSocketConnected)
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Tooltip(
                    message: 'Connected',
                    child: CircleAvatar(
                      radius: 4,
                      backgroundColor: Colors.green,
                    ),
                  ),
                )
              else
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Tooltip(
                    message: 'Disconnected',
                    child: CircleAvatar(
                      radius: 4,
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return _buildMessageBubble(_messages[index]);
                  },
                ),
        ),
        _buildMessageComposer(),
      ],
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    bool isMe = message.senderId == _currentUser?.id;
    bool isSelected = _selectedMessage?.id == message.id;

    return GestureDetector(
      onLongPress: () {
        if (isMe) {
          setState(() {
            _selectedMessage = message;
          });
        }
      },
      onTap: () {
        if (isMe) {
          setState(() {
            _selectedMessage = isSelected ? null : message;
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (isMe && isSelected)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () => _handleDeleteMessage(message),
                  tooltip: 'Hapus Pesan',
                ),
              ),
            
            Flexible(
              child: Column(
                crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: isMe ? const Color(0xFF5B3F5B) : Colors.orange.shade300,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(18),
                        topRight: const Radius.circular(18),
                        bottomLeft: isMe ? const Radius.circular(18) : Radius.zero,
                        bottomRight: isMe ? Radius.zero : const Radius.circular(18),
                      ),
                    ),
                    child: Text(
                      message.message,
                      style: TextStyle(color: isMe ? Colors.white : Colors.black87),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      DateFormat('HH:mm').format(message.createdAt.toLocal()),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Color(0xFFFFF8F0),
        border: Border(top: BorderSide(color: Color(0xFFF9EBC8))),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Ketik pesan...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: _sendMessage,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange.shade300,
              foregroundColor: Colors.black87,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            ),
            child: const Text('Kirim'),
          ),
        ],
      ),
    );
  }
}