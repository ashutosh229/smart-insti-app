import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/dummy_entries.dart';
import '../models/achievement.dart';

final achievementRepositoryProvider =
    Provider<AchievementRepository>((_) => AchievementRepository());

class AchievementRepository {
  final _client = Dio(
    BaseOptions(
      baseUrl: dotenv.env['BACKEND_DOMAIN']!,
    ),
  );

  Future<List<Achievement>> Achievements() async {
    try {
      final response = await _client.get('/achievements');
      return response.data.map((e) => Achievement.fromJson(e)).toList();
    } catch (e) {
      return DummyAchievements.achievements;
    }
  }

  Future<Achievement> addAchievement(Achievement achievement) async {
    try {
      final response =
          await _client.post('/achievements', data: achievement.toJson());
      return Achievement.fromJson(response.data);
    } catch (e) {
      return achievement;
    }
  }

  Future<Achievement> updateAchievement(Achievement achievement) async {
    try {
      final response = await _client.put('/achievements/${achievement.id}',
          data: achievement.toJson());
      return Achievement.fromJson(response.data);
    } catch (e) {
      return achievement;
    }
  }

  Future<Achievement> deleteAchievement(Achievement achievement) async {
    try {
      final response = await _client.delete('/achievements/${achievement.id}');
      return Achievement.fromJson(response.data);
    } catch (e) {
      return achievement;
    }
  }

  Future<Achievement> getAchievement(Achievement achievement) async {
    try {
      final response = await _client.get('/achievements/$achievement.id');
      return Achievement.fromJson(response.data);
    } catch (e) {
      return achievement;
    }
  }
}
