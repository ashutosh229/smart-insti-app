import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:smart_insti_app/models/message.dart';
import 'package:smart_insti_app/repositories/chat_room_repository.dart';

import '../constants/constants.dart';
import '../constants/dummy_entries.dart';

final chatRoomProvider =
    StateNotifierProvider<ChatRoomStateNotifier, ChatRoomState>(
        (ref) => ChatRoomStateNotifier(ref));

class ChatRoomState {
  final List<Message> messageList;
  final TextEditingController messageController;
  final LoadingState loadingState;

  ChatRoomState({
    required this.messageList,
    required this.messageController,
    required this.loadingState,
  });

  ChatRoomState copyWith({
    List<Message>? messageList,
    TextEditingController? messageController,
    LoadingState? loadingState,
  }) {
    return ChatRoomState(
      messageList: messageList ?? this.messageList,
      messageController: messageController ?? this.messageController,
      loadingState: loadingState ?? this.loadingState,
    );
  }
}

class ChatRoomStateNotifier extends StateNotifier<ChatRoomState> {
  ChatRoomStateNotifier(Ref ref)
      : _api = ref.read(chatRoomRepositoryProvider),
        super(
          ChatRoomState(
            messageList: DummyMessages.messages,
            messageController: TextEditingController(),
            loadingState: LoadingState.progress,
          ),
        ) {
    loadMessages();
  }
  final ChatRoomRepository _api;
  final Logger _logger = Logger();
  final ScrollController scrollController = ScrollController();

  void loadMessages() async {
    final messages = await _api.getMessages();
    state = state.copyWith(
      messageList: messages,
      loadingState: LoadingState.success,
    );
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  void addMessage(String sender) async {
    final message = Message(
      sender: sender,
      content: state.messageController.text,
      timestamp: DateTime.now(),
    );
    await _api.addMessage(message);
    state.messageController.clear();
    loadMessages();
  }

  // void editMessage(int index, String newContent) {
  //   final messages = state.messageList;
  //   Message message = messages[index];
  //   deleteMessage(index);
  //   addMessage()
  // }

  void deleteMessage(int index) {
    final messages = state.messageList;
    Message message = messages[index];
    _api.deleteMessage(message.id!);
    messages.removeAt(index);
    state = state.copyWith(messageList: messages);
    for (var message in messages) {
      _logger.i(message.content);
    }
  }
}
