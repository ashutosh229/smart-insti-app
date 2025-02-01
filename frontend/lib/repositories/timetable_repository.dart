import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import '../models/timtable.dart';

final timetableRepositoryProvider = Provider<TimetableRepository>((ref) => TimetableRepository());

class TimetableRepository {
  final _client = Dio(
    BaseOptions(
      baseUrl: dotenv.env['BACKEND_DOMAIN']!,
      validateStatus: (status) {
        return status! < 500;
      },
    ),
  );

  final Logger _logger = Logger();
  final _secureStorage = const FlutterSecureStorage();

  Future<bool> createTimetable(Timetable timetable) async {
    _client.options.headers['authorization'] = await _secureStorage.read(key: 'token') ?? '';
    try {
      final response = await _client.post('/timetable', data: timetable.toJson());
      _logger.i(response.data);
      return true;
    } catch (e) {
      _logger.e(e);
      return false;
    }
  }

  Future<List<Timetable>?> getTimetablesByCreatorId(String creatorId) async {
    _client.options.headers['authorization'] = await _secureStorage.read(key: 'token') ?? '';
    try {
      final response = await _client.get('/timetables/$creatorId');
      return (response.data as List).map((e) => Timetable.fromJson(e)).toList();
    } catch (e) {
      _logger.e(e);
      return null;
    }
  }

  Future<bool> deleteTimetableById(String id) async {
    _client.options.headers['authorization'] = await _secureStorage.read(key: 'token') ?? '';
    try {
      final response = await _client.delete('/timetables/$id');
      _logger.i(response.data);
      return true;
    } catch (e) {
      _logger.e(e);
      return false;
    }
  }
}
