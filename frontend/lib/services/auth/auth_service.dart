import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:smart_insti_app/constants/constants.dart';

final authServiceProvider = Provider<AuthService>((_) => AuthService());

class AuthService {
  final _client = Dio(
    BaseOptions(
      baseUrl: dotenv.env['BACKEND_DOMAIN']!,
      validateStatus: (status) {
        return status! < 500;
      },
    ),
  );

  final _secureStorage = const FlutterSecureStorage();
  final Logger _logger = Logger();

  Future<void> saveCredentials(Map response) async {
    Map<String, String> credentials = {};
    try {
      credentials = {
        'token': response['token'],
        '_id': response['_id'],
        'name': response['name'],
        'email': response['email'],
        'role': response['role'],
      };
      await _secureStorage.write(key: 'token', value: credentials['token']);
      await _secureStorage.write(key: '_id', value: credentials['_id']);
      await _secureStorage.write(key: 'name', value: credentials['name']);
      await _secureStorage.write(key: 'email', value: credentials['email']);
      await _secureStorage.write(key: 'role', value: credentials['role']);
    } catch (e) {
      _logger.e(e);
    }
  }

  Future<Map<String, String>> checkCredentials() async {
    Map<String, String> credentials = {};
    try {
      credentials = {
        'token': await _secureStorage.read(key: 'token') ?? '',
        '_id': await _secureStorage.read(key: '_id') ?? '',
        'name': await _secureStorage.read(key: 'name') ?? '',
        'email': await _secureStorage.read(key: 'email') ?? '',
        'role': await _secureStorage.read(key: 'role') ?? '',
      };
      await Future.delayed(const Duration(seconds: 2));
      return credentials;
    } catch (e) {
      _logger.e(e);
      return credentials;
    }
  }

  Future<bool> clearCredentials() async {
    try {
      await _secureStorage.delete(key: 'token');
      await _secureStorage.delete(key: '_id');
      await _secureStorage.delete(key: 'name');
      await _secureStorage.delete(key: 'email');
      await _secureStorage.delete(key: 'role');
      return true;
    } catch (e) {
      _logger.e(e);
      return false;
    }
  }

  Future<({int statusCode, String message})> sendOtp(
      String email, String loginForRole) async {
    try {
      final response = await _client.post(
        '/otp/send-otp',
        data: {
          'email': email,
          'loginForRole': loginForRole,
        },
      );
      _logger.i(response.data);
      return (
        statusCode: response.statusCode!,
        message: response.data['message'] as String
      );
    } catch (e) {
      _logger.e(e);
      return (statusCode: 500, message: 'Internal Server Error');
    }
  }

  Future<({int statusCode, String message})> verifyOtp(
      String email, String otp) async {
    try {
      final response = await _client.post(
        '/otp/verify-otp',
        data: {
          'email': email,
          'otp': otp,
        },
      );
      _logger.i(response.data);
      return (
        statusCode: response.statusCode!,
        message: response.data['message'] as String
      );
    } catch (e) {
      _logger.e(e);
      return (statusCode: 500, message: 'Internal Server Error');
    }
  }

  Future<Map<String, dynamic>> loginAdmin(String email, String password) async {
    try {
      final response = await _client.post(
        '/admin-auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      return response.data;
    } catch (e) {
      _logger.e(e);
      return {};
    }
  }

  Future<Map<String, dynamic>> loginFacultyOrStudent(
      String email, String loginForRole) async {
    try {
      final response = await _client.post(
        '/general-auth/login',
        data: {
          'email': email,
          'loginForRole': loginForRole,
        },
      );
      return response.data;
    } catch (e) {
      _logger.e(e);
      return {};
    }
  }
}
