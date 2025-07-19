import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scholar_chat/core/constant/color.dart';

class ChatScreen extends StatefulWidget {
  final String customerId;
  final String employeeId;

  const ChatScreen({
    Key? key,
    required this.customerId,
    required this.employeeId,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late String chatId;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    chatId = '${widget.customerId}_${widget.employeeId}';
  }

  Future<void> sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final chatRef = FirebaseFirestore.instance.collection('chats').doc(chatId);

    final chatSnapshot = await chatRef.get();

    if (!chatSnapshot.exists) {
      await chatRef.set({
        'participants': [widget.customerId, widget.employeeId],
        'created_at': FieldValue.serverTimestamp(),
      });
    }

    await chatRef.collection('messages').add({
      'senderId': widget.customerId,
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
    });

    _controller.clear();
  }

  Widget _buildMessageBubble(Map<String, dynamic> data, bool isMe) {
    String time = '';
    if (data['timestamp'] != null) {
      final ts = (data['timestamp'] as Timestamp).toDate();
      time = DateFormat('hh:mm a').format(ts);
    }

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isMe
              ? AppColor.back.withOpacity(0.85)
              : AppColor.back.withOpacity(0.55),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isMe ? 20 : 6),
            bottomRight: Radius.circular(isMe ? 6 : 20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              data['text'] ?? '',
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              time,
              style: TextStyle(
                color: isMe
                    ? Colors.white.withOpacity(0.7)
                    : Colors.black54,
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 237, 220),
      appBar: AppBar(
        title: const Text('استشارتك'),
        backgroundColor: AppColor.back,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(chatId)
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data!.docs;

                if (messages.isEmpty) {
                  return const Center(
                    child: Text(
                      'لا توجد رسائل بعد، ابدأ المحادثة الآن!',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }

                return ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.only(top: 12, bottom: 12),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final data =
                        messages[index].data()! as Map<String, dynamic>;
                    final isMe = data['senderId'] == widget.customerId;

                    return _buildMessageBubble(data, isMe);
                  },
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => sendMessage(),
                      decoration: InputDecoration(
                        hintText: 'اكتب رسالتك...',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: AppColor.back,
                    radius: 26,
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: sendMessage,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
