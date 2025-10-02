import 'package:flutter/material.dart';

class MessageDashboard extends StatefulWidget {
  const MessageDashboard({super.key});

  @override
  State<MessageDashboard> createState() => _MessageDashboardState();
}

class _MessageDashboardState extends State<MessageDashboard> {
  int _selectedConversationIndex = 0; 
  final TextEditingController _messageController = TextEditingController();

  // (Mock data remains the same...)
  final List<Map<String, String>> _conversations = [
    { 'name': 'Dr. Rani Sari, M.Psi', 'lastMessage': 'Saya memahami perasaan Anda. Terima kasih...', 'avatarInitials': 'RS', },
    { 'name': 'Dr. Budi Santoso, S.Psi', 'lastMessage': 'Tentu, saya akan kirimkan beberapa materi...', 'avatarInitials': 'BS', },
    { 'name': 'Admin MINDSPACE', 'lastMessage': 'Jadwal konseling Anda telah disetujui.', 'avatarInitials': 'A', }
  ];
  final List<Map<String, String>> _messages = [
    { 'sender': 'Dr. Rani', 'text': 'Selamat pagi Sarah! ...', 'time': '09:02', },
    { 'sender': 'me', 'text': 'Pagi dok. Saya masih merasa cemas ...', 'time': '09:04', },
    { 'sender': 'Dr. Rani', 'text': 'Saya memahami perasaan Anda. ...', 'time': '09:06', },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isTwoPaneView = MediaQuery.of(context).size.width >= 800;

    return Card(
      color: const Color(0xFFFFF8F0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: isTwoPaneView
          ? Row( // WIDE SCREEN LAYOUT
              children: [
                SizedBox(
                  width: 300,
                  child: _buildConversationList(isTwoPaneView: true),
                ),
                const VerticalDivider(width: 1, color: Color(0xFFF9EBC8)),
                Expanded(
                  child: _buildChatView(isTwoPaneView: true),
                ),
              ],
            )
          : _buildConversationList(isTwoPaneView: false), // NARROW SCREEN LAYOUT
    );
  }

  Widget _buildConversationList({required bool isTwoPaneView}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Cari Kontak...',
              prefixIcon: const Icon(Icons.search, size: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            ),
          ),
        ),
        const Divider(height: 1, color: Color(0xFFF9EBC8)),
        Expanded(
          child: ListView.builder(
            itemCount: _conversations.length,
            itemBuilder: (context, index) {
              final conversation = _conversations[index];
              return ListTile(
                selected: isTwoPaneView && index == _selectedConversationIndex,
                selectedTileColor: const Color(0xFFF9EBC8),
                leading: CircleAvatar(child: Text(conversation['avatarInitials']!)),
                title: Text(conversation['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(conversation['lastMessage']!, maxLines: 1, overflow: TextOverflow.ellipsis),
                onTap: () {
                  if (isTwoPaneView) {
                    setState(() { _selectedConversationIndex = index; });
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          backgroundColor: const Color(0xFFFFF8F0),
                          body: _buildChatView(isTwoPaneView: false),
                        ),
                      ),
                    );
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildChatView({required bool isTwoPaneView}) {
    if (_selectedConversationIndex < 0 && isTwoPaneView) {
      return const Center(child: Text("Select a conversation to start chatting."));
    }
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          color: const Color(0xFF5B3F5B),
          child: Row(
            children: [
              if (!isTwoPaneView)
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              const Expanded(
                child: Text('Sarah Wijaya • Sesi: 09:00 WIB',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _messages.length,
            itemBuilder: (context, index) { return _buildMessageBubble(_messages[index]); },
          ),
        ),
        _buildMessageComposer(),
      ],
    );
  }

  Widget _buildMessageBubble(Map<String, String> message) {
    bool isMe = message['sender'] == 'me';
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isMe
                        ? const Color(0xFF5B3F5B)
                        : Colors.orange.shade300,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft:
                          isMe ? const Radius.circular(16) : Radius.zero,
                      bottomRight:
                          isMe ? Radius.zero : const Radius.circular(16),
                    ),
                  ),
                  child: Text(
                    message['text']!,
                    style:
                        TextStyle(color: isMe ? Colors.white : Colors.black87),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    "${isMe ? 'Sarah' : message['sender']} - ${message['time']!}",
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
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange.shade300,
              foregroundColor: Colors.black87,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            ),
            child: const Text('Kirim'),
          ),
        ],
      ),
    );
  }
}