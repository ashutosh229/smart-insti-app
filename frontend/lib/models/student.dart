import 'package:smart_insti_app/models/achievement.dart';
import 'package:smart_insti_app/models/skills.dart';

class Student {
  final String id;
  final String name;
  final String email;
  final String rollNumber;
  final String? about;
  final String? profilePicURI;
  final String? branch;
  final int? graduationYear;
  final List<Skill>? skills;
  final List<Achievement>? achievements;
  final List<String>? roles;

  Student({
    required this.id,
    required this.name,
    required this.email,
    required this.rollNumber,
    this.about,
    this.profilePicURI,
    this.branch,
    this.graduationYear,
    this.skills,
    this.achievements,
    this.roles,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['_id'],
      name: json['name'] ?? 'Smart Insti User',
      email: json['email'],
      rollNumber: json['rollNumber'],
      about: json['about'],
      profilePicURI: json['profilePicURI'],
      branch: json['branch'],
      graduationYear: json['graduationYear'],
      skills: json['skills'] != null
          ? (json['skills'] as List<dynamic>).map((item) => Skill.fromJson(item as Map<String, dynamic>)).toList()
          : [],
      achievements: json['achievements'] != null
          ? (json['achievements'] as List<dynamic>)
              .map((item) => Achievement.fromJson(item as Map<String, dynamic>))
              .toList()
          : null,
      roles: json['roles'] != null ? (json['roles'] as List?)?.map((item) => item as String).toList() : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'rollNumber': rollNumber,
      'about': about,
      'profilePicURI': profilePicURI,
      'branch': branch,
      'graduationYear': graduationYear,
      'skills': skills != null ? skills!.map((skill) => skill.toJson()).toList() : [],
      'achievements': achievements != null ? achievements!.map((achievement) => achievement.toJson()).toList() : [],
      'roles': roles,
    };
  }
}
