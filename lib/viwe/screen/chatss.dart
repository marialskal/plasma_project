// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/viwe/screen/chatadmin.dart';

class EmployeeChatsScreen extends StatelessWidget {
  final String employeeId;

  const EmployeeChatsScreen({
    Key? key,
    required this.employeeId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('محادثات العملاء')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .where('participants', arrayContains: employeeId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          final chats = snapshot.data!.docs;

          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final data = chats[index].data() as Map<String, dynamic>;
              final chatId = chats[index].id;
              final participants = data['participants'] as List<dynamic>;

              // استخراج customerId
              final customerId = participants.firstWhere((id) => id != employeeId);

              return ListTile(
                title: Text('العميل: $customerId'),
                subtitle: Text('معرف المحادثة: $chatId'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EmployeeChatScreen(
                        chatId: chatId,
                        employeeId: employeeId,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
