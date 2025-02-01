class Course {
  final String id;
  final String courseCode;
  final String courseName;
  final int credits;
  final List<String> branches;
  final String primaryRoom;
  final String professorId;

  Course({
    required this.id,
    required this.courseCode,
    required this.courseName,
    required this.credits,
    required this.branches,
    required this.primaryRoom,
    required this.professorId,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['_id'],
      courseCode: json['courseCode'],
      courseName: json['name'],
      credits: json['credits'],
      branches:
          (json['branches'] as List).map((item) => item as String).toList(),
      primaryRoom: json['primaryRoom'],
      professorId: json['professorId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'courseCode': courseCode,
      'name': courseName,
      'credits': credits,
      'branches': branches,
      'primaryRoom': primaryRoom,
      'professorId': professorId,
    };
  }
}
