import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:smart_insti_app/constants/dummy_entries.dart';
import '../models/faculty.dart';

final facultyRepositoryProvider =
    Provider<FacultyRepository>((ref) => FacultyRepository());

class FacultyRepository {
  final _client = Dio(
    BaseOptions(
      baseUrl: dotenv.env['BACKEND_DOMAIN']!,
      validateStatus: (status) {
        return status! < 500;
      },
    ),
  );

  final Logger _logger = Logger();

  Future<Faculty?> getFacultyById(String id, String token) async {
    _client.options.headers['authorization'] = token;
    try {
      final response = await _client.get('/faculty/$id');
      return Faculty.fromJson(response.data);
    } catch (e) {
      _logger.e(e);
      return null;
    }
  }

  Future<List<Faculty>> getFaculties() async {
    try {
      final response = await _client.get('/faculties');
      return (response.data as List).map((e) => Faculty.fromJson(e)).toList();
    } catch (e) {
      return DummyFaculties.faculties;
    }
  }

  Future<Faculty> addFaculty(String email) async {
    try {
      final response = await _client.post(
        '/faculties',
        data: {
          'email': email,
        },
      );

      return Faculty.fromJson(response.data['user']);
    } catch (e) {
      return DummyFaculties.faculties[0];
    }
  }

  Future<Faculty> updateFaculty(Faculty faculty) async {
    try {
      final response =
          await _client.put('/faculties/${faculty.id}', data: faculty.toJson());
      return Faculty.fromJson(response.data['user']);
    } catch (e) {
      return DummyFaculties.faculties[0];
    }
  }

  Future<void> deleteFaculty(String id) async {
    try {
      await _client.delete('/faculties/$id');
    } catch (e) {
      return;
    }
  }
}
