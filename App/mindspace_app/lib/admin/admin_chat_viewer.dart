import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mindspace_app/models/conversation.dart';
import 'package:mindspace_app/models/user.dart';
import 'package:mindspace_app/services/admin_service.dart';
import 'package:mindspace_app/services/chat_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mindspace_app/models/appointment.dart';

class AdminChatViewer extends StatefulWidget {
  final Conversation conversation;
  const AdminChatViewer({super.key, required this.conversation});

  @override
  State<AdminChatViewer> createState() => _AdminChatViewerState();
}

class _AdminChatViewerState extends State<AdminChatViewer> {
  final ScrollController _scrollController = ScrollController();
  List<ChatMessage> _messages = [];
  bool _isLoading = true;
  User? _userOne;
  User? _userTwo;

  @override
  void initState() {
    super.initState();
    _userOne = widget.conversation.userOne;
    _userTwo = widget.conversation.userTwo;
    _fetchMessages();
  }

  Future<void> _fetchMessages() async {
    try {
      final details = await AdminService().getConversationMessages(widget.conversation.id);
      
      if (mounted) {
        setState(() {
          _messages = details.messages;
          _isLoading = false;
        });
        _scrollToBottom();
      }
    } catch (e) {
      if (mounted) {
        setState(() { _isLoading = false; });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memuat pesan: $e')),
        );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.conversation.name),
        backgroundColor: const Color(0xFF5B3F5B),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
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
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.grey.shade200,
            child: const Center(
              child: Text(
                'Mode Admin (Read-Only)',
                style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    bool isUserOne = message.senderId == _userOne?.id;
    String senderName = isUserOne ? _userOne?.fullName ?? 'User 1' : _userTwo?.fullName ?? 'User 2';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: isUserOne ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: isUserOne ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                  child: Text(
                    senderName,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: isUserOne ? const Color(0xFF5B3F5B) : Colors.orange.shade300,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(18),
                      topRight: const Radius.circular(18),
                      bottomLeft: isUserOne ? const Radius.circular(18) : Radius.zero,
                      bottomRight: isUserOne ? Radius.zero : const Radius.circular(18),
                    ),
                  ),
                  child: _buildMessageContent(message, isUserOne),
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
}