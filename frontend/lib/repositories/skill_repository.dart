import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/dummy_entries.dart';
import '../models/skills.dart';

final skillRepositoryProvider =
    Provider<SkillRepository>((_) => SkillRepository());

class SkillRepository {
  final _client = Dio(
    BaseOptions(
      baseUrl: dotenv.env['BACKEND_DOMAIN']!,
    ),
  );

  Future<List<dynamic>> Skills() async {
    try {
      final response = await _client.get('/skills');
      return response.data.map((e) => Skill.fromJson(e)).toList();
    } catch (e) {
      return DummySkills.skills;
    }
  }

  Future<Skill> addSkill(Skill skill) async {
    try {
      final response = await _client.post('/skills', data: skill.toJson());
      return Skill.fromJson(response.data);
    } catch (e) {
      return skill;
    }
  }

  Future<Skill> updateSkill(Skill skill) async {
    try {
      final response =
          await _client.put('/skills/${skill.id}', data: skill.toJson());
      return Skill.fromJson(response.data);
    } catch (e) {
      return skill;
    }
  }

  Future<Skill> deleteSkill(Skill skill) async {
    try {
      final response = await _client.delete('/skills/${skill.id}');
      return Skill.fromJson(response.data);
    } catch (e) {
      return skill;
    }
  }

  Future<Skill> getSkill(Skill skill) async {
    try {
      final response = await _client.get('/skills/$skill.id');
      return Skill.fromJson(response.data);
    } catch (e) {
      return skill;
    }
  }
}
