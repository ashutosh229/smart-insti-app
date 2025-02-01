import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:smart_insti_app/provider/chat_room_provider.dart';

import '../../components/material_textformfield.dart';
import '../../constants/constants.dart';
import '../../models/student.dart';
import '../../provider/auth_provider.dart';

class ChatRoom extends ConsumerWidget {
  ChatRoom({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ref.read(authProvider.notifier).tokenCheckProgress !=
          LoadingState.progress) {
        ref.read(authProvider.notifier).verifyAuthTokenExistence(
            context, AuthConstants.generalAuthLabel.toLowerCase());
      }
    });

    ref.watch(chatRoomProvider.notifier).loadMessages();
    final Student currentStudent =
        ref.read(authProvider).currentUser as Student;
    return ResponsiveScaledBox(
      width: 411,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              context.pop();
            },
          ),
          backgroundColor: Color(0xFF128c7e),
          title:
              Text('Common Room', style: const TextStyle(color: Colors.white)),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/chatroom_bg.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: ListView.builder(
                        controller: ref
                            .read(chatRoomProvider.notifier)
                            .scrollController,
                        itemCount:
                            ref.read(chatRoomProvider).messageList.length,
                        itemBuilder: (context, index) {
                          final message =
                              ref.read(chatRoomProvider).messageList[index];
                          final isMe = message.sender == currentStudent.name;
                          final messages =
                              ref.watch(chatRoomProvider).messageList;
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2.0, horizontal: 10.0),
                            child: Column(
                              crossAxisAlignment: isMe
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '~${message.sender}',
                                  style: const TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.black,
                                      fontFamily: 'Arial',
                                      fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  onLongPress: isMe
                                      ? () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text('Delete Message'),
                                              content: Text(
                                                  'Are you sure you want to delete this message?'),
                                              actions: [
                                                TextButton(
                                                  child: Text('Cancel'),
                                                  onPressed: () {
                                                    context.pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text('Delete'),
                                                  onPressed: () {
                                                    ref
                                                        .read(chatRoomProvider
                                                            .notifier)
                                                        .deleteMessage(index);
                                                    context.pop();
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      : null,
                                  child: Material(
                                    elevation: 5.0,
                                    borderRadius: BorderRadius.only(
                                      topLeft: isMe
                                          ? const Radius.circular(15.0)
                                          : const Radius.circular(0),
                                      topRight: isMe
                                          ? const Radius.circular(0.0)
                                          : const Radius.circular(15.0),
                                      bottomLeft: const Radius.circular(15.0),
                                      bottomRight: const Radius.circular(15.0),
                                    ),
                                    color: isMe
                                        ? Colors.greenAccent.shade100
                                        : Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        '${message.content}',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontFamily: 'Arial'),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  '${message.timestamp!.toLocal().toString().split(' ')[1].substring(0, 5)}',
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: MaterialTextFormField(
                        onTap: () async {
                          await Future.delayed(const Duration(seconds: 1));
                          ref
                              .read(chatRoomProvider.notifier)
                              .scrollController
                              .jumpTo(
                                ref
                                    .read(chatRoomProvider.notifier)
                                    .scrollController
                                    .position
                                    .maxScrollExtent,
                              );
                        },
                        controller:
                            ref.read(chatRoomProvider).messageController,
                        hintText: 'Enter your message here...',
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.send,
                          color: Colors.teal, size: 30.0),
                      onPressed: () {
                        ref
                            .watch(chatRoomProvider.notifier)
                            .addMessage(currentStudent.name);
                        ref.watch(chatRoomProvider.notifier).loadMessages();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
