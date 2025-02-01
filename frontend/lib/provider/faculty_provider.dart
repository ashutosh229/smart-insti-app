import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'dart:io';
import '../models/course.dart';
import '../models/faculty.dart';

final facultyProvider =
    StateNotifierProvider<FacultyStateNotifier, FacultyState>(
        (ref) => FacultyStateNotifier());

class FacultyState {
  final List<Faculty> faculties;
  final List<Faculty> filteredFaculties;
  final List<Course> selectedCourses;
  final TextEditingController facultyNameController;
  final TextEditingController facultyEmailController;
  final TextEditingController facultyDepartmentController;
  final TextEditingController facultyCabinNumberController;
  final TextEditingController searchFacultyController;

  FacultyState({
    required this.faculties,
    required this.filteredFaculties,
    required this.selectedCourses,
    required this.facultyNameController,
    required this.facultyEmailController,
    required this.searchFacultyController,
    required this.facultyDepartmentController,
    required this.facultyCabinNumberController,
  });

  FacultyState copyWith({
    List<Faculty>? faculties,
    List<Faculty>? filteredFaculties,
    List<Course>? selectedCourses,
    TextEditingController? facultyNameController,
    TextEditingController? facultyEmailController,
    TextEditingController? searchFacultyController,
    TextEditingController? facultyDepartmentController,
    TextEditingController? facultyCabinNumberController,
  }) {
    return FacultyState(
      faculties: faculties ?? this.faculties,
      filteredFaculties: filteredFaculties ?? this.filteredFaculties,
      selectedCourses: selectedCourses ?? this.selectedCourses,
      facultyNameController:
          facultyNameController ?? this.facultyNameController,
      facultyEmailController:
          facultyEmailController ?? this.facultyEmailController,
      facultyCabinNumberController:
          facultyCabinNumberController ?? this.facultyCabinNumberController,
      facultyDepartmentController:
          facultyDepartmentController ?? this.facultyDepartmentController,
      searchFacultyController:
          searchFacultyController ?? this.searchFacultyController,
    );
  }
}

class FacultyStateNotifier extends StateNotifier<FacultyState> {
  FacultyStateNotifier()
      : super(FacultyState(
          faculties: [],
          filteredFaculties: [],
          selectedCourses: [],
          facultyNameController: TextEditingController(),
          facultyEmailController: TextEditingController(),
          facultyCabinNumberController: TextEditingController(),
          facultyDepartmentController: TextEditingController(),
          searchFacultyController: TextEditingController(),
        ));

  final Logger _logger = Logger();

  get facultyNameController => state.facultyNameController;

  get facultyEmailController => state.facultyEmailController;

  get searchFacultyController => state.searchFacultyController;

  get facultyCabinNumberController => state.facultyCabinNumberController;

  get facultyDepartmentController => state.facultyDepartmentController;

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

  void addFaculty() {
    Faculty faculty = Faculty(
      id: (state.faculties.length + 1).toString(),
      name: state.facultyNameController.text,
      email: state.facultyEmailController.text,
      courses: state.selectedCourses,
      cabinNumber: state.facultyCabinNumberController.text,
      department: state.facultyDepartmentController.text,
    );
    state = state.copyWith(
      faculties: [faculty, ...state.faculties],
      selectedCourses: [],
      facultyNameController: TextEditingController(),
      facultyEmailController: TextEditingController(),
      facultyCabinNumberController: TextEditingController(),
      facultyDepartmentController: TextEditingController(),
    );
    _logger.i("Added faculty: ${faculty.name}");
  }

  void updateSelectedCourses(List<Course> courses) {
    state = state.copyWith(
      selectedCourses: courses,
    );
  }

  void searchFaculties() {
    String query = state.searchFacultyController.text;
    _logger.i("Searching for faculty: $query");
    state = state.copyWith(
      filteredFaculties: state.faculties
          .where((faculty) =>
              faculty.name.toLowerCase().contains(query.toLowerCase()))
          .toList(),
    );
  }

  void removeFaculty(Faculty faculty) {
    state = state.copyWith(
      faculties: state.faculties..remove(faculty),
      filteredFaculties: state.filteredFaculties..remove(faculty),
    );
    _logger.i("Removed faculty: ${faculty.name}");
  }
}
