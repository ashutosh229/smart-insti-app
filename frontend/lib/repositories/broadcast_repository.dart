import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:smart_insti_app/models/broadcast_schema.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final broadcastRepositoryProvider =
    Provider<BroadcastRepository>((_) => BroadcastRepository());

class BroadcastRepository {
  final _client = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:3000',
    ),
  );

  Future<List<Broadcast>> fetchBroadcasts() async {
    try {
      final response = await _client.get('/broadcasts');
      final List<Broadcast> broadcasts = List<Broadcast>.from(
        response.data.map((broadcastJson) => Broadcast.fromJson(broadcastJson)),
      );
      return broadcasts;
    } catch (e) {
      Logger().e(e);
      throw Exception('Failed to fetch broadcasts');
    }
  }
}
