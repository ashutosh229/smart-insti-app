import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import '../constants/dummy_entries.dart';
import '../models/message.dart';

final chatRoomRepositoryProvider =
    Provider<ChatRoomRepository>((_) => ChatRoomRepository());

class ChatRoomRepository {
  final _client = Dio(
    BaseOptions(
      baseUrl: dotenv.env['BACKEND_DOMAIN']!,
    ),
  );

  var logger = Logger();

  Future<List<Message>> getMessages() async {
    try {
      final response = await _client.get('/messages');
      List<Message> messages = [];
      for (var message in response.data) {
        messages.add(Message.fromJson(message));
      }
      return messages;
    } catch (e) {
      Logger().e(e);
      return DummyMessages.messages;
    }
  }

  Future<void> addMessage(Message message) async {
    try {
      await _client.post('/messages', data: {
        'sender': message.sender,
        'content': message.content,
        'timestamp': message.timestamp.toString(),
      });
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<void> deleteMessage(String id) async {
    try {
      await _client.delete('/messages/$id');
    } catch (e) {
      Logger().e(e);
    }
  }
}
