import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import '../models/admin.dart';

final adminRepositoryProvider = Provider<AdminRepository>((_) => AdminRepository());

class AdminRepository {
  final _client = Dio(
    BaseOptions(
      baseUrl: dotenv.env['BACKEND_DOMAIN']!,
      validateStatus: (status) {
        return status! < 500;
      },
    ),
  );

  final Logger _logger = Logger();

  Future<Admin?> getAdminById(String id, String token) async {
    _client.options.headers['authorization'] = token;
    try {
      final response = await _client.get('/admin/$id');
      return Admin.fromJson(response.data);
    } catch (e) {
      _logger.e(e);
      return null;
    }
  }
}
