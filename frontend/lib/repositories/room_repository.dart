import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:smart_insti_app/constants/dummy_entries.dart';
import '../models/room.dart';

final roomRepositoryProvider = Provider<RoomRepository>((_) => RoomRepository());

class RoomRepository {
  final _client = Dio(
    BaseOptions(
      baseUrl: dotenv.env['BACKEND_DOMAIN']!,
    ),
  );

  Future<List<Room>> getRooms() async {
    try {
      final response = await _client.get('/rooms');
      List<Room> rooms = [];
      for (var room in response.data) {
        rooms.add(Room.fromJson(room));
      }
      return rooms;
    } catch (e) {
      return DummyRooms.rooms;
    }
  }

  Future<bool> reserveRoom(String roomId, String occupantId, String userName) async {
    try {
      final response = await _client.put('/room/$roomId', data: {'occupantName' : userName ,'occupantId': occupantId, 'vacant': false });
      Logger().i(response.data);
      return true;
    } catch (e) {
      Logger().e(e);
      return false;
    }
  }

  Future<bool> vacateRoom(String roomId) async {
    try {
      final response = await _client.put('/room/$roomId', data: {'occupantId': null, 'vacant': true });
      Logger().i(response.data);
      return true;
    } catch (e) {
      Logger().e(e);
      return false;
    }
  }

  void addRoom(Room room) async {
    try {
      final response = await _client.post('/rooms', data: room.toJson());
      Logger().i(response.data);
    } catch (e) {
      Logger().e(e);
    }
  }
}
