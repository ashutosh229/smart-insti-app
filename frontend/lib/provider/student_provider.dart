import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:smart_insti_app/constants/constants.dart';
import 'package:smart_insti_app/constants/dummy_entries.dart';
import '../../models/student.dart';
import 'dart:io';
import '../models/achievement.dart';
import '../models/skills.dart';

final studentProvider = StateNotifierProvider<StudentProvider, StudentState>(
    (ref) => StudentProvider());

class StudentState {
  final List<Student> students;
  final List<Student> filteredStudents;
  final TextEditingController studentNameController;
  final TextEditingController studentEmailController;
  final TextEditingController studentRollNoController;
  final TextEditingController searchStudentController;
  final String branch;
  final String? role;
  final String? profilePicURI;
  final String? about;
  final int? graduationYear;
  final List<Skill>? skills;
  final List<Achievement>? achievements;

  StudentState({
    required this.students,
    required this.filteredStudents,
    required this.studentNameController,
    required this.studentEmailController,
    required this.studentRollNoController,
    required this.searchStudentController,
    required this.branch,
    required this.role,
    this.profilePicURI,
    this.about,
    this.achievements,
    this.graduationYear,
    this.skills,
  });

  StudentState copyWith({
    List<Student>? students,
    List<Student>? filteredStudents,
    TextEditingController? studentNameController,
    TextEditingController? studentEmailController,
    TextEditingController? studentRollNoController,
    TextEditingController? searchStudentController,
    String? branch,
    String? role,
    String? about,
    String? profilePicURI,
    List<Skill>? skills,
    List<Achievement>? achievements,
  }) {
    return StudentState(
      students: students ?? this.students,
      filteredStudents: filteredStudents ?? this.filteredStudents,
      studentNameController:
          studentNameController ?? this.studentNameController,
      studentEmailController:
          studentEmailController ?? this.studentEmailController,
      studentRollNoController:
          studentRollNoController ?? this.studentRollNoController,
      searchStudentController:
          searchStudentController ?? this.searchStudentController,
      branch: branch ?? this.branch,
      role: role ?? this.role,
      profilePicURI: profilePicURI ?? this.profilePicURI,
      about: about ?? this.about,
      graduationYear: graduationYear ?? this.graduationYear,
      skills: skills ?? this.skills,
      achievements: achievements ?? this.achievements,
    );
  }

  Student getStudentById(String studentId) {
    try {
      return students.firstWhere((student) => student.id == studentId);
    } catch (e) {
      return Student(
        id: '1',
        name: 'John Doe',
        email: 'john.doe@example.com',
        rollNumber: 'R001',
        about: 'I am a computer science student.',
        profilePicURI:
            'https://cdn4.sharechat.com/img_907710_35cec5f5_1681916904360_sc.jpg?tenant=sc&referrer=pwa-sharechat-service&f=360_sc.jpg',
        branch: 'Computer Science',
        graduationYear: 2023,
        skills: [DummySkills.skills[1], DummySkills.skills[2]],
        achievements: Dummyachievements.achievements.sublist(0, 5),
        roles: ['Core Member', 'Coordinator'],
      );
    }
  }
}

class StudentProvider extends StateNotifier<StudentState> {
  StudentProvider()
      : super(StudentState(
          students: DummyStudents.students,
          filteredStudents: [],
          studentNameController: TextEditingController(),
          studentEmailController: TextEditingController(),
          studentRollNoController: TextEditingController(),
          searchStudentController: TextEditingController(),
          branch: Branches.branchList[0].value!,
          role: StudentRoles.studentRoleList[0].value!,
        ));

  final Logger _logger = Logger();

  void pickSpreadsheet() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      bool isSpreadsheet = result.files.single.path!.endsWith(".xlsx") ||
          result.files.single.path!.endsWith(".xls") ||
          result.files.single.path!.endsWith(".csv");
      if (isSpreadsheet) {
        File file = File(result.files.single.path!);

        // TODO : Add code to send the spreadsheet to the backend

        _logger.i("Picked file ${file.path}");
      } else {
        _logger.e("Picked file is not a spreadsheet");
      }
    } else {
      _logger.e("No file picked");
    }
  }

  get studentNameController => state.studentNameController;

  get studentEmailController => state.studentEmailController;

  get studentRollNoController => state.studentRollNoController;

  get searchStudentController => state.searchStudentController;

  void searchStudents() {
    String query = state.searchStudentController.text;
    _logger.i("Searching for student: $query");
    final newState = state.copyWith(
      filteredStudents: state.students
          .where((student) =>
              student.name.toLowerCase().contains(query.toLowerCase()))
          .toList(),
    );
    state = newState;
  }

  void updateBranch(String value) {
    final newState = state.copyWith(branch: value);
    state = newState;
  }

  void updateRole(String value) {
    final newState = state.copyWith(role: value);
    state = newState;
  }

  void editAbout(String newAbout) {
    final newState = state.copyWith(about: newAbout);
    state = newState;
  }

  void editSkills(List<Skill> newSkills) {
    final newState = state.copyWith(skills: newSkills);
    state = newState;
  }

  void editAchievements(List<Achievement> newAchievements) {
    final newState = state.copyWith(achievements: newAchievements);
    state = newState;
  }

  void addStudent() {
    final newState = state.copyWith(
      students: [
        Student(
          id: (state.students.length + 1).toString(),
          name: state.studentNameController.text,
          email: state.studentEmailController.text,
          rollNumber: state.studentRollNoController.text,
          branch: state.branch,
        ),
        ...state.students,
      ],
      studentNameController: TextEditingController(),
      studentEmailController: TextEditingController(),
      studentRollNoController: TextEditingController(),
      branch: Branches.branchList[0].value!,
      role: StudentRoles.studentRoleList[0].value!,
    );
    state = newState;
  }

  void removeStudent(Student student) {
    final newStudents = state.students.where((s) => s != student).toList();
    final newFilteredStudents =
        state.filteredStudents.where((s) => s != student).toList();
    final newState = state.copyWith(
      students: newStudents,
      filteredStudents: newFilteredStudents,
    );
    state = newState;
    _logger.i("Removed student: ${student.name}");
  }
}
