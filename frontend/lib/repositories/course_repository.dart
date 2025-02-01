import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_insti_app/constants/dummy_entries.dart';
import '../models/course.dart';

final courseRepositoryProvider =
    Provider<CourseRepository>((_) => CourseRepository());

class CourseRepository {
  final _client = Dio(
    BaseOptions(
      baseUrl: dotenv.env['BACKEND_DOMAIN']!,
    ),
  );

  Future<List<dynamic>> getCourses() async {
    try {
      final response = await _client.get('/courses');
      return response.data.map((e) => Course.fromJson(e)).toList();
    } catch (e) {
      return DummyCourses.courses;
    }
  }

  Future<Course> addCourse(Course course) async {
    try {
      final response = await _client.post('/courses', data: course.toJson());
      return Course.fromJson(response.data);
    } catch (e) {
      return course;
    }
  }

  Future<Course> updateCourse(Course course) async {
    try {
      final response =
          await _client.put('/courses/${course.id}', data: course.toJson());
      return Course.fromJson(response.data);
    } catch (e) {
      return course;
    }
  }

  Future<Course> deleteCourse(Course course) async {
    try {
      final response = await _client.delete('/courses/${course.id}');
      return Course.fromJson(response.data);
    } catch (e) {
      return course;
    }
  }

  Future<Course> getCourse(Course course) async {
    try {
      final response = await _client.get('/courses/$course.id');
      return Course.fromJson(response.data);
    } catch (e) {
      return course;
    }
  }
}
