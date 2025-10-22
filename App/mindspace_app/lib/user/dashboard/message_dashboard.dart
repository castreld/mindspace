import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mindspace_app/config.dart';
import 'package:mindspace_app/models/conversation.dart';
import 'package:mindspace_app/models/message_request.dart';
import 'package:mindspace_app/models/user.dart';
import 'package:mindspace_app/services/auth_service.dart';
import 'package:mindspace_app/services/chat_service.dart';
import 'package:mindspace_app/user/dashboard/widgets/chat_screen.dart';
import 'package:provider/provider.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class MessageDashboard extends StatefulWidget {
  const MessageDashboard({super.key});

  @override
  State<MessageDashboard> createState() => _MessageDashboardState();
}

class _MessageDashboardState extends State<MessageDashboard> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<Conversation>> _conversationsFuture;
  late Future<List<MessageRequest>> _requestsFuture;
  int _selectedConversationIndex = -1;
  Conversation? _selectedConversationForDeletion;
  
  final TextEditingController _searchController = TextEditingController();
  List<User> _searchResults = [];
  bool _isSearching = false;
  bool _isLoadingSearch = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _refreshData();
    _searchController.addListener(_performSearch);
  }

  void _refreshData() {
    final token = context.read<AuthService>().token;
    if (token != null && mounted) {
      setState(() {
        _conversationsFuture = context.read<ChatService>().getConversations(token);
        _requestsFuture = context.read<ChatService>().getMessageRequests(token);
      });
    } else {
      setState(() {
        _conversationsFuture = Future.error('Not authenticated');
        _requestsFuture = Future.error('Not authenticated');
      });
    }
  }

  Future<void> _performSearch() async {
    final query = _searchController.text.trim();
    
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    final token = context.read<AuthService>().token;
    if (token == null) return;

    setState(() {
      _isSearching = true;
      _isLoadingSearch = true;
    });

    try {
      final results = await context.read<ChatService>().searchClients(token, query);
      setState(() {
        _searchResults = results;
        _isLoadingSearch = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error searching clients: $e'), backgroundColor: Colors.red),
      );
      setState(() {
        _isLoadingSearch = false;
        _searchResults = [];
      });
    }
  }

  Future<void> _sendMessageRequest(User user) async {
    final token = context.read<AuthService>().token;
    if (token == null) return;

    try {
      await context.read<ChatService>().sendMessageRequest(
        token,
        user.id,
        'Halo, saya ingin memulai percakapan dengan Anda.',
      );
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Permintaan pesan terkirim ke ${user.fullName}!'),
          backgroundColor: Colors.green,
        ),
      );
      
      _searchController.clear();
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal mengirim permintaan: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _handleAccept(int conversationId) async {
    final token = context.read<AuthService>().token;
    if (token == null) return;
    try {
      await context.read<ChatService>().acceptRequest(token, conversationId);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permintaan diterima!'), backgroundColor: Colors.green),
      );
      _refreshData();
      _tabController.animateTo(0);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menerima permintaan: $e'), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> _handleReject(int conversationId) async {
    final token = context.read<AuthService>().token;
    if (token == null) return;
    try {
      await context.read<ChatService>().rejectRequest(token, conversationId);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permintaan ditolak.'), backgroundColor: Colors.blueGrey),
      );
      _refreshData();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menolak permintaan: $e'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 700,
          child: Card(
            color: const Color(0xFFFFF8F0),
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  labelColor: Colors.deepPurple,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.deepPurple,
                  tabs: const [
                    Tab(icon: Icon(Icons.chat_bubble), text: "Pesan"),
                    Tab(icon: Icon(Icons.person_add), text: "Permintaan"),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildConversationsTab(),
                      _buildRequestsTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            onPressed: _refreshData,
            tooltip: 'Refresh Lists',
            backgroundColor: Colors.deepPurple,
            child: const Icon(Icons.refresh, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildConversationsTab() {
    return FutureBuilder<List<Conversation>>(
      future: _conversationsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Gagal memuat percakapan: ${snapshot.error}"));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("Tidak ada percakapan."));
        }

        final conversations = snapshot.data!;
        final isTwoPaneView = MediaQuery.of(context).size.width >= 800;

        return isTwoPaneView
            ? Row(children: [
                SizedBox(width: 300, child: _buildConversationList(conversations, isTwoPaneView: true)),
                const VerticalDivider(width: 1, color: Color(0xFFF9EBC8)),
                Expanded(child: _selectedConversationIndex >= 0
                    ? ChatScreen(conversation: conversations[_selectedConversationIndex], isTwoPane: true)
                    : const Center(child: Text("Pilih percakapan untuk memulai."))),
              ])
            : _buildConversationList(conversations, isTwoPaneView: false);
      },
    );
  }

  Widget _buildConversationList(List<Conversation> conversations, {required bool isTwoPaneView}) {
    return ListView.separated(
      itemCount: conversations.length,
      separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFF9EBC8)),
      itemBuilder: (context, index) {
        final conversation = conversations[index];
        final isSelectedForDeletion = _selectedConversationForDeletion?.id == conversation.id;

        return GestureDetector(
          onLongPress: () {
            setState(() { _selectedConversationForDeletion = conversation; });
          },
          onTap: () async {
            if (isSelectedForDeletion) {
              setState(() {
                _selectedConversationForDeletion = null;
              });
              return;
            }

            if (isTwoPaneView) {
              setState(() => _selectedConversationIndex = index);
            } else {
              final result = await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Scaffold(
                  backgroundColor: const Color(0xFFFFF8F0),
                  body: ChatScreen(conversation: conversation, isTwoPane: false),
                ),
              ));

              if (result == 'deleted' && mounted) {
                _showDeletedConversationDialog();
                _refreshData();
              }
            }
          },
          child: Container(
            color: isSelectedForDeletion ? Colors.red.withOpacity(0.1) : Colors.transparent,
            child: ListTile(
              selected: isTwoPaneView && index == _selectedConversationIndex,
              selectedTileColor: const Color(0xFFF9EBC8),
              leading: CircleAvatar(
                backgroundImage: conversation.profilePicture != null
                    ? NetworkImage('${AppConfig.backendBaseUrl}/api/${conversation.profilePicture!}')
                    : null,
                child: conversation.profilePicture == null
                    ? Text(conversation.name.substring(0, 1).toUpperCase())
                    : null,
              ),
              title: Text(conversation.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(conversation.lastMessage, maxLines: 1, overflow: TextOverflow.ellipsis),
              trailing: isSelectedForDeletion
                  ? Tooltip(
                      message: 'Hapus Percakapan',
                      child: IconButton(
                        icon: const Icon(Icons.delete_forever, color: Colors.red),
                        onPressed: () => _handleDeleteConversation(conversation),
                      ),
                    )
                  : Text(DateFormat('HH:mm').format(conversation.lastMessageTime.toLocal())),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRequestsTab() {
    return FutureBuilder<List<MessageRequest>>(
      future: _requestsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Gagal memuat permintaan: ${snapshot.error}"));
        }

        final requests = snapshot.data ?? [];
        final hasRequests = requests.isNotEmpty;

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Cari klien...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _searchResults = [];
                              _isSearching = false;
                            });
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.deepPurple),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
                  ),
                ),
              ),
            ),
            Expanded(
              child: _isSearching
                  ? _buildSearchResults()
                  : (hasRequests ? _buildRequestsList(requests) : const Center(child: Text("Tidak ada permintaan pesan."))),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSearchResults() {
    if (_isLoadingSearch) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_searchResults.isEmpty && _searchController.text.isNotEmpty) {
      return const Center(child: Text("Tidak ada klien yang ditemukan."));
    }

    return ListView.separated(
      itemCount: _searchResults.length,
      separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFF9EBC8)),
      itemBuilder: (context, index) {
        final user = _searchResults[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: user.profilePicture != null
                ? NetworkImage('${AppConfig.backendBaseUrl}/api/${user.profilePicture!}')
                : null,
            child: user.profilePicture == null
                ? Text(user.fullName.substring(0, 1).toUpperCase())
                : null,
          ),
          title: Text(user.fullName, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(user.email, maxLines: 1, overflow: TextOverflow.ellipsis),
          trailing: ElevatedButton.icon(
            onPressed: () => _sendMessageRequest(user),
            icon: const Icon(Icons.send),
            label: const Text('Kirim'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
            ),
          ),
        );
      },
    );
  }

  Widget _buildRequestsList(List<MessageRequest> requests) {
    return ListView.separated(
      itemCount: requests.length,
      separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFF9EBC8)),
      itemBuilder: (context, index) {
        final request = requests[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: request.initiatorProfilePicture != null
                ? NetworkImage('${AppConfig.backendBaseUrl}/api/${request.initiatorProfilePicture!}')
                : null,
            child: request.initiatorProfilePicture == null
                ? Text(request.initiatorName.substring(0, 1).toUpperCase())
                : null,
          ),
          title: Text(request.initiatorName, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: const Text("Mengirim Anda permintaan pesan."),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () => _handleAccept(request.conversationId),
                child: const Text('Terima', style: TextStyle(color: Colors.green)),
              ),
              TextButton(
                onPressed: () => _handleReject(request.conversationId),
                child: const Text('Tolak', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleDeleteConversation(Conversation conversation) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Percakapan?'),
        content: Text('Anda yakin ingin menghapus percakapan dengan ${conversation.name}? Tindakan ini tidak bisa dibatalkan.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Batal')),
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
        await context.read<ChatService>().deleteConversation(token, conversation.id);
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Percakapan berhasil dihapus.'), backgroundColor: Colors.green)
          );
          _refreshData();
          setState(() {
            _selectedConversationForDeletion = null;
          });
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal menghapus percakapan: $e'), backgroundColor: Colors.red)
          );
        }
      }
    }
  }

  void _showDeletedConversationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          icon: Icon(Icons.info_outline, color: Colors.orange.shade700, size: 48),
          title: const Text(
            'Percakapan Tidak Ditemukan',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Mungkin percakapan ini telah dihapus oleh orang yang kamu hubungi.',
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
                'Saya Mengerti',
                style: TextStyle(color: Colors.orange.shade800, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}