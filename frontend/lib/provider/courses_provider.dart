import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:logger/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import '../constants/constants.dart';
import '../models/course.dart';

final coursesProvider = StateNotifierProvider<CoursesNotifier, CoursesState>(
    (ref) => CoursesNotifier());

class CoursesState {
  final List<Course> courses;
  final List<Course> filteredCourses;
  final TextEditingController courseCodeController;
  final TextEditingController courseNameController;
  final TextEditingController courseCreditController;
  final TextEditingController searchCourseController;
  final List<String> branches;

  CoursesState({
    required this.courses,
    required this.filteredCourses,
    required this.courseCodeController,
    required this.courseNameController,
    required this.courseCreditController,
    required this.searchCourseController,
    required this.branches,
  });

  CoursesState copyWith({
    List<Course>? courses,
    List<Course>? filteredCourses,
    List<String>? branches,
    TextEditingController? courseCodeController,
    TextEditingController? courseNameController,
    TextEditingController? courseCreditController,
    TextEditingController? searchCourseController,
  }) {
    return CoursesState(
      courses: courses ?? this.courses,
      filteredCourses: filteredCourses ?? this.filteredCourses,
      courseCodeController: courseCodeController ?? this.courseCodeController,
      courseNameController: courseNameController ?? this.courseNameController,
      courseCreditController:
          courseCreditController ?? this.courseCreditController,
      searchCourseController:
          searchCourseController ?? this.searchCourseController,
      branches: branches ?? this.branches,
    );
  }
}

class CoursesNotifier extends StateNotifier<CoursesState> {
  CoursesNotifier() : super(_initialState());

  static CoursesState _initialState() {
    return CoursesState(
      courses: [],
      filteredCourses: [],
      courseCodeController: TextEditingController(),
      courseNameController: TextEditingController(),
      courseCreditController: TextEditingController(),
      searchCourseController: TextEditingController(),
      branches: Branches.branchList.map((branch) => branch.value!).toList(),
    );
  }

  get courseNameController => state.courseNameController;

  get courseCodeController => state.courseCodeController;

  get courseCreditController => state.courseCreditController;

  get searchCourseController => state.searchCourseController;

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

  void searchCourses() {
    String query = state.searchCourseController.text;
    _logger.i("Searching for courses with query $query");
    state = state.copyWith(
        filteredCourses: state.courses
            .where((course) =>
                course.courseName.toLowerCase().contains(query.toLowerCase()))
            .toList());
  }

  void removeCourse(Course course) {
    _logger.i("Removing course ${course.courseCode}");
    state = state.copyWith(
      courses: state.courses..remove(course),
      filteredCourses: state.filteredCourses..remove(course),
    );
  }

  void addCourse() {
    _logger.i("Adding course ${state.courseCodeController.text}");
    final newCourse = Course(
      id: (state.courses.length + 1).toString(),
      courseCode: state.courseCodeController.text,
      courseName: state.courseNameController.text,
      branches: state.branches,
      credits: state.courseCreditController.text.isEmpty
          ? 0
          : int.parse(state.courseCreditController.text),
      primaryRoom: '',
      professorId: '',
    );
    state = state.copyWith(
      courses: [
        newCourse,
        ...state.courses,
      ],
      courseCodeController: TextEditingController(),
      courseNameController: TextEditingController(),
      branches: Branches.branchList.map((branch) => branch.value!).toList(),
    );
  }

  void updateBranch(List<String> newBranches) {
    state = state.copyWith(branches: newBranches);
  }
}
