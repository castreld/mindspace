import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mindspace_app/models/appointment.dart';
import 'package:mindspace_app/models/conversation.dart';
import 'package:mindspace_app/services/booking_service.dart';
import 'package:mindspace_app/models/user.dart';
import 'package:mindspace_app/services/auth_service.dart';
import 'package:mindspace_app/services/chat_service.dart';
import 'package:mindspace_app/config.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:mindspace_app/user/dashboard/widgets/history_detail_dialog.dart';
import 'package:mindspace_app/user/dashboard/widgets/therapist_notes_dialog.dart';
import 'websocket_setup/websocket_channel_stub.dart'
    if (dart.library.html) 'websocket_setup/websocket_channel_html.dart'
    if (dart.library.io) 'websocket_setup/websocket_channel_io.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  Timer? _sessionTimer;
  Duration? _timeRemaining;
  String _sessionStatus = 'pending';
  bool _isConsultation = false;
  bool _isChatLocked = false;
  Appointment? _appointmentDetails;
  bool _isLoadingDetails = false;
  String? _detailsError;
  bool _postSessionActionShown = false;

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

      final details = await context.read<ChatService>().getMessagesByConversationId(
          token,
          widget.conversation.id
      );
      if (mounted) {
        setState(() {
          _messages = details.messages;
          _isLoading = false;

          _isConsultation = details.conversation.appointmentId != null;
          _sessionStatus = details.conversation.sessionStatus;

          if (_isConsultation && details.conversation.sessionStartedAt != null && _sessionStatus != 'ended') {
            String utcTimestamp = details.conversation.sessionStartedAt!;
            if (!utcTimestamp.endsWith('Z')) {
              utcTimestamp = '${utcTimestamp}Z';
            }

            _startSessionTimer(
                DateTime.parse(utcTimestamp),
                details.conversation.sessionDurationMinutes ?? 60
            );
          } else if (_isConsultation && _sessionStatus == 'ended' && !_postSessionActionShown) {
             _fetchAppointmentDetailsAfterSessionEnd();
             _updateChatLock();
          } else {
             _updateChatLock();
          }
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

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal membuka link: $url')),
        );
      }
    }
  }

  Future<void> _fetchAppointmentDetailsAfterSessionEnd() async {
     if (!mounted || !_isConsultation || widget.conversation.appointmentId == null) return;

     _postSessionActionShown = true;

     setState(() {
       _isLoadingDetails = true;
       _detailsError = null;
     });

     try {
       final details = await context.read<BookingService>().getAppointmentDetails(widget.conversation.appointmentId!);
       if (mounted) {
         setState(() {
           _appointmentDetails = details;
           _isLoadingDetails = false;
         });
       }
     } on ApiException catch (e) {
       if (mounted) {
         setState(() {
           _detailsError = 'Gagal memuat detail sesi: ${e.statusCode}';
           _isLoadingDetails = false;
         });
       }
     } catch (e) {
       if (mounted) {
         setState(() {
           _detailsError = 'Error: $e';
           _isLoadingDetails = false;
         });
       }
     }
   }

  void _refreshAppointmentDetails() {
     _postSessionActionShown = false;
     _fetchAppointmentDetailsAfterSessionEnd();
  }

  void _initWebSocket() async {
    final token = context.read<AuthService>().token;
    final conversationId = widget.conversation.id;

    if (token == null) {
      debugPrint('✗ WebSocket setup failed: Auth token is null.');
      return;
    }

    try {
      String wsUrl = AppConfig.getWebSocketUrl();

      debugPrint('🔌 Connecting to WebSocket: $wsUrl');

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
        if (e.toString().contains('Sesi telah berakhir')) {
          _showConversationDeletedDialog(
            title: 'Sesi Berakhir',
            content: 'Waktu konsultasi Anda telah berakhir. Anda tidak dapat mengirim pesan lagi.'
          );
          setState(() {
            _sessionStatus = 'ended';
            _updateChatLock();
          });
        } else if (e.toString().contains('No accepted conversation found')) {
          _showConversationDeletedDialog();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal mengirim pesan: $e'), backgroundColor: Colors.red)
          );
        }
      }
    }
  }

  void _pickAndSendFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'mp4', 'mov', 'pdf', 'doc', 'docx', 'txt'],
    );

    if (result != null) {
      const int maxFileSize = 10 * 1024 * 1024;
      final int fileSizeInBytes = result.files.single.size;

      if (fileSizeInBytes > maxFileSize) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('File terlalu besar. Maksimal ukuran file adalah 10MB. Ukuran file Anda: ${(fileSizeInBytes / (1024 * 1024)).toStringAsFixed(2)}MB'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }

      try {
        final token = context.read<AuthService>().token!;
        await context.read<ChatService>().sendFileMessage(
          token,
          _otherUserId!,
          result,
        );
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal mengirim file: $e'), backgroundColor: Colors.red),
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

  void _showConversationDeletedDialog({
    String title = 'Gagal Mengirim Pesan',
    String content = 'Percakapan tidak ditemukan, mungkin telah dihapus oleh orang yang kamu hubungi.'
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          icon: Icon(Icons.forum_outlined, color: Colors.orange.shade700, size: 48),
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(
            content,
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

  Future<void> _showReportDialog() async {
    await showDialog(
      context: context,
      builder: (dialogContext) {
        return SimpleDialog(
          title: const Text('Laporkan'),
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(dialogContext).pop(); 
                _showReportConversationDialog();
              },
              child: const ListTile(
                leading: Icon(Icons.chat_bubble_outline),
                title: Text('Laporkan Percakapan Ini'),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(dialogContext).pop(); 
                _showReportUserDialog();
              },
              child: const ListTile(
                leading: Icon(Icons.person_outline),
                title: Text('Laporkan Pengguna Ini'),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showReportConversationDialog() async {
    final reportController = TextEditingController();
    bool isSendingReport = false;

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, dialogSetState) {
            return AlertDialog(
              title: const Text('Laporkan Percakapan'),
              content: isSendingReport
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : TextField(
                      controller: reportController,
                      decoration: const InputDecoration(
                        hintText: 'Alasan Anda melaporkan...',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 4,
                    ),
              actions: [
                TextButton(
                  onPressed: isSendingReport ? null : () => Navigator.of(context).pop(),
                  child: const Text('Batal'),
                ),
                ElevatedButton(
                  onPressed: isSendingReport
                      ? null
                      : () async {
                          final reason = reportController.text.trim();
                          if (reason.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Alasan tidak boleh kosong.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          dialogSetState(() {
                            isSendingReport = true;
                          });

                          try {
                            final chatService = context.read<ChatService>();
                            final token = context.read<AuthService>().token;
                            await chatService.reportConversation(
                              token!,
                              widget.conversation.id,
                              reason,
                            );

                            if (mounted) {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Laporan percakapan berhasil dikirim.'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          } catch (e) {
                            dialogSetState(() {
                              isSendingReport = false;
                            });
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Gagal mengirim laporan: $e'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                  child: const Text('Kirim'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _showReportUserDialog() async {
    final reportController = TextEditingController();
    bool isSendingReport = false;
    final otherUserName = widget.conversation.name;

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, dialogSetState) {
            return AlertDialog(
              title: Text('Laporkan $otherUserName?'),
              content: isSendingReport
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : TextField(
                      controller: reportController,
                      decoration: const InputDecoration(
                        hintText: 'Alasan Anda melaporkan...',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 4,
                    ),
              actions: [
                TextButton(
                  onPressed: isSendingReport ? null : () => Navigator.of(context).pop(),
                  child: const Text('Batal'),
                ),
                ElevatedButton(
                  onPressed: isSendingReport
                      ? null
                      : () async {
                          final reason = reportController.text.trim();
                          if (reason.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Alasan tidak boleh kosong.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          dialogSetState(() {
                            isSendingReport = true;
                          });

                          try {
                            final chatService = context.read<ChatService>();
                            final token = context.read<AuthService>().token;
                            await chatService.reportUser(
                              token!,
                              _otherUserId!,
                              reason,
                            );

                            if (mounted) {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Laporan pengguna berhasil dikirim.'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          } catch (e) {
                            dialogSetState(() {
                              isSendingReport = false;
                            });
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Gagal mengirim laporan: $e'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                  child: const Text('Kirim'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _sessionTimer?.cancel();
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
              IconButton(
                icon: const Icon(Icons.report_problem_outlined, color: Colors.white),
                onPressed: _showReportDialog,
                tooltip: 'Laporkan...',
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
        _buildTimerBar(),
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
        if (_isConsultation && _sessionStatus == 'ended')
           _buildPostSessionActions(),
        _buildMessageComposer(),
      ],
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    bool isMe = message.senderId == _currentUser?.id;
    bool isSelected = _selectedMessage?.id == message.id;

    return GestureDetector(
      onLongPress: () {
        if (isMe && message.messageType == 'text') {
          setState(() {
            _selectedMessage = message;
          });
        }
      },
      onTap: () {
        if (isMe && message.messageType == 'text') {
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
            if (isMe && isSelected && message.messageType == 'text')
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
                    child: _buildMessageContent(message, isMe),
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

  Widget _buildMessageContent(ChatMessage message, bool isMe) {
    Color textColor = isMe ? Colors.white : Colors.black87;
    Color linkColor = isMe ? Colors.blue.shade200 : Colors.blue.shade800;

    switch (message.messageType) {
      case 'image':
        if (message.filePath == null || message.filePath!.isEmpty) {
          return Text('Gambar tidak tersedia', style: TextStyle(color: textColor));
        }
        String imageUrl = message.filePath!;
        return GestureDetector(
          onTap: () => _launchUrl(imageUrl),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 100.0,
              minHeight: 100.0,
              maxWidth: MediaQuery.of(context).size.width * 0.6,
              maxHeight: MediaQuery.of(context).size.height * 0.4,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return SizedBox(
                    width: 100,
                    height: 100,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: progress.expectedTotalBytes != null
                            ? progress.cumulativeBytesLoaded /
                                progress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stack) {
                  debugPrint('Error loading image: $error');
                  return SizedBox(
                    width: 100,
                    height: 100,
                    child: Center(
                      child: Icon(Icons.broken_image, size: 50, color: textColor),
                    ),
                  );
                },
              ),
            ),
          ),
        );

      case 'video':
      case 'file':
        if (message.filePath == null || message.filePath!.isEmpty) {
          return Text('File tidak tersedia', style: TextStyle(color: textColor));
        }
        String fileUrl = message.filePath!;
        IconData fileIcon = message.messageType == 'video'
            ? FontAwesomeIcons.solidFileVideo
            : FontAwesomeIcons.solidFilePdf;

        return GestureDetector(
          onTap: () => _launchUrl(fileUrl),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(fileIcon, color: textColor, size: 20),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  message.originalFileName ?? 'File',
                  style: TextStyle(
                    color: linkColor,
                    decoration: TextDecoration.underline,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );

      case 'text':
      default:
        return Text(
          message.message ?? '',
          style: TextStyle(color: textColor),
        );
    }
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
          IconButton(
            icon: const Icon(Icons.attach_file),
            onPressed: _isChatLocked ? null : _pickAndSendFile,
            color: Colors.grey.shade700,
          ),
          Expanded(
            child: CallbackShortcuts(
              bindings: <ShortcutActivator, VoidCallback>{
                const SingleActivator(LogicalKeyboardKey.enter, shift: false): () {
                  if (!_isChatLocked) {
                    _sendMessage();
                  }
                },
              },
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 120,
                ),
                child: TextField(
                  controller: _messageController,
                  enabled: !_isChatLocked,
                  maxLines: null,
                  maxLength: 1000,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    hintText: _isChatLocked
                        ? 'Sesi telah berakhir'
                        : 'Ketik pesan...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, 
                      vertical: 12
                    ),
                    counterText: '',
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: _isChatLocked ? null : _sendMessage,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange.shade300,
              foregroundColor: Colors.black87,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 24, 
                vertical: 16
              ),
            ),
            child: const Text('Kirim'),
          ),
        ],
      ),
    );
  }

  void _startSessionTimer(DateTime startTimeUtc, int durationMinutes) {
    final int overtimeMinutes = 10;
    final endTimeUtc = startTimeUtc.add(Duration(minutes: durationMinutes));
    final overtimeEndTimeUtc = endTimeUtc.add(Duration(minutes: overtimeMinutes));

    _sessionTimer?.cancel();
    _sessionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final nowUtc = DateTime.now().toUtc();
      String newStatus = _sessionStatus;
      Duration newTimeRemaining = Duration.zero;

      if (nowUtc.isAfter(overtimeEndTimeUtc)) {
        if (_sessionStatus != 'ended') {
          newStatus = 'ended';
          timer.cancel();
          if (!_postSessionActionShown) _fetchAppointmentDetailsAfterSessionEnd();
        }
        newTimeRemaining = Duration.zero;

      } else if (nowUtc.isAfter(endTimeUtc)) {
        if (_sessionStatus != 'overtime' && _sessionStatus != 'ended') newStatus = 'overtime';
        newTimeRemaining = overtimeEndTimeUtc.difference(nowUtc);

      } else {
        if (_sessionStatus != 'active' && _sessionStatus != 'ended') newStatus = 'active';
        newTimeRemaining = endTimeUtc.difference(nowUtc);
      }

      if (mounted) {
        setState(() {
          _timeRemaining = newTimeRemaining;
          if (_sessionStatus != newStatus) {
            _sessionStatus = newStatus;
            _updateChatLock();
          }
        });

        if (newStatus == 'ended' && timer.isActive) {
          timer.cancel();
        }
      }
    });
  }

  void _updateChatLock() {
    setState(() {
      _isChatLocked = _isConsultation &&
                          _currentUser?.role == 'klien' &&
                          _sessionStatus == 'ended';
    });
  }

  String _formatDuration(Duration d) {
    if (d.isNegative) return "00:00";
    return "${d.inMinutes.remainder(60).toString().padLeft(2, '0')}:${d.inSeconds.remainder(60).toString().padLeft(2, '0')}";
  }

  void _handleStopSesi() async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hentikan Sesi?'),
        content: const Text('Apakah Anda yakin ingin menghentikan sesi konsultasi ini?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Batal')),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Hentikan', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        final token = context.read<AuthService>().token!;
        await context.read<ChatService>().stopSession(token, widget.conversation.id);
        if (mounted) {
          setState(() {
            _sessionStatus = 'ended';
            _timeRemaining = Duration.zero;
            _sessionTimer?.cancel();
            _updateChatLock();
          });
        }
      } catch (e) {
         if (mounted) {
           ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text('Gagal menghentikan sesi: $e'), backgroundColor: Colors.red),
           );
         }
       }
    }
  }

  Widget _buildTimerBar() {
    if (!_isConsultation || _sessionStatus == 'pending' || _timeRemaining == null) {
      return const SizedBox.shrink();
    }

    String text;
    Color color;
    Color bgColor;

    if (_sessionStatus == 'ended') {
      text = "Sesi telah berakhir";
      color = Colors.grey.shade700;
      bgColor = Colors.grey.shade200;
    } else if (_sessionStatus == 'overtime') {
      text = "Waktu Tambahan: ${_formatDuration(_timeRemaining!)}";
      color = Colors.red.shade900;
      bgColor = Colors.red.shade100;
    } else {
      text = "Sisa Waktu: ${_formatDuration(_timeRemaining!)}";
      color = Colors.green.shade900;
      bgColor = Colors.green.shade100;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: bgColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.timer, color: color, size: 18),
          const SizedBox(width: 8),
          Text(text, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          const Spacer(),
          if (_currentUser?.role == 'klien' && (_sessionStatus == 'active' || _sessionStatus == 'overtime'))
           TextButton(
              onPressed: _handleStopSesi,
              child: const Text('Stop Sesi', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            ),
        ],
      ),
    );
  }

  Widget _buildPostSessionActions() {
    if (_isLoadingDetails) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Center(child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))),
        );
    }
    if (_detailsError != null) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Text(_detailsError!, style: const TextStyle(color: Colors.red)),
        );
    }
    if (_appointmentDetails == null) {
        return const SizedBox.shrink();
    }

    Widget? actionButton;
    bool alreadyReviewed = _appointmentDetails!.rating != null;
    bool therapistHasNoted = _appointmentDetails!.therapistNotes != null && _appointmentDetails!.therapistNotes!.isNotEmpty;


    if (_currentUser?.role == 'klien' && !alreadyReviewed) {
        actionButton = ElevatedButton.icon(
           icon: const Icon(Icons.rate_review_outlined),
           label: const Text('Berikan Review'),
           onPressed: () {
             showDialog(
               context: context,
               builder: (context) => HistoryDetailDialog(
                  appointment: _appointmentDetails!,
                  onReviewSubmitted: _refreshAppointmentDetails,
                  currentUserRole: _currentUser?.role ?? 'klien',
               ),
             );
           },
           style: ElevatedButton.styleFrom(
             backgroundColor: Colors.amber.shade700,
             foregroundColor: Colors.white,
           ),
        );
    } else if (_currentUser?.role == 'psikolog' && !therapistHasNoted) {
      actionButton = ElevatedButton.icon(
           icon: const Icon(Icons.note_add_outlined),
           label: const Text('Berikan Catatan'),
           onPressed: () {
             showDialog(
                context: context,
                builder: (context) => TherapistNotesDialog(
                   appointment: _appointmentDetails!,
                   onNotesSubmitted: _refreshAppointmentDetails,
                ),
             );
           },
           style: ElevatedButton.styleFrom(
             backgroundColor: Colors.blue.shade700,
             foregroundColor: Colors.white,
           ),
        );
    }

    return actionButton != null
        ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: Colors.grey.shade200,
            child: Center(child: actionButton),
          )
        : const SizedBox.shrink();
  }
}