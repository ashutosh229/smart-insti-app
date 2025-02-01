import 'package:smart_insti_app/models/course.dart';

class Faculty {
  final String id;
  final String name;
  final String email;
  final String? cabinNumber;
  final String? department;
  final List<Course>? courses;

  Faculty({
    required this.id,
    required this.name,
    required this.email,
    this.cabinNumber,
    this.department,
    this.courses,
  });

  factory Faculty.fromJson(Map<String, dynamic> json) {
    return Faculty(
      id: json['_id'],
      name: json['name'] ?? 'Smart Insti User',
      email: json['email'],
      cabinNumber: json['cabinNumber'],
      department: json['department'],
      courses: json['courses'] != null
          ? (json['courses'] as List)
              .map((item) => Course.fromJson(item))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'cabinNumber': cabinNumber,
      'department': department,
      'courses': courses != null
          ? courses!.map((course) => course.toJson()).toList()
          : [],
    };
  }
}
