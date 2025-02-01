import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = "Smart Insti App";
  static const Color seedColor = Colors.lightBlueAccent;
}

enum LoadingState { idle, progress, success, error }

class AuthConstants {
  static const String facultyAuthLabel = "Faculty";
  static const String studentAuthLabel = "Student";
  static const String adminAuthLabel = "Admin";
  static const String generalAuthLabel = "General";
}

class Branches {
  static List<DropdownMenuItem<String>> branchList = const [
    DropdownMenuItem<String>(
        value: "Computer Science and Engineering",
        child: Text("Computer Science and Engineering")),
    DropdownMenuItem<String>(
        value: "Computer Science", child: Text("Computer Science")),
    DropdownMenuItem<String>(
        value: "Electrical Engineering", child: Text("Electrical Engineering")),
    DropdownMenuItem<String>(
        value: "Mechanical Engineering", child: Text("Mechanical Engineering")),
    DropdownMenuItem<String>(
        value: "Civil Engineering", child: Text("Civil Engineering")),
    DropdownMenuItem<String>(
        value: "Chemical Engineering", child: Text("Chemical Engineering")),
    DropdownMenuItem<String>(
        value: "AerosRpace Engineering", child: Text("Aerospace Engineering")),
    DropdownMenuItem<String>(
        value: "Metallurgical Engineering",
        child: Text("Metallurgical Engineering")),
    DropdownMenuItem<String>(
        value: "Ocean Engineering", child: Text("Ocean Engineering")),
    DropdownMenuItem<String>(
        value: "Biotechnology", child: Text("Biotechnology")),
    DropdownMenuItem<String>(value: "Physics", child: Text("Physics")),
    DropdownMenuItem<String>(value: "Chemistry", child: Text("Chemistry")),
    DropdownMenuItem<String>(value: "Mathematics", child: Text("Mathematics")),
    DropdownMenuItem<String>(
        value: "Humanities and Social Sciences",
        child: Text("Humanities and Social Sciences")),
    DropdownMenuItem<String>(
        value: "Management Studies", child: Text("Management Studies")),
    DropdownMenuItem<String>(
        value: "Nanotechnology", child: Text("Nanotechnology")),
    DropdownMenuItem<String>(
        value: "Energy Engineering", child: Text("Energy Engineering")),
    DropdownMenuItem<String>(
        value: "Environmental Engineering",
        child: Text("Environmental Engineering")),
    DropdownMenuItem<String>(
        value: "Industrial Engineering and Operations Research",
        child: Text("Industrial Engineering and Operations Research")),
    DropdownMenuItem<String>(
        value: "Systems and Control Engineering",
        child: Text("Systems and Control Engineering")),
    DropdownMenuItem<String>(
        value: "Materials Science and Engineering",
        child: Text("Materials Science and Engineering")),
  ];
}

class LayoutConstants {}

class StudentRoles {
  static List<DropdownMenuItem<String>> studentRoleList = const [
    DropdownMenuItem<String>(value: "Student", child: Text("Student")),
    DropdownMenuItem<String>(
        value: "Class Representative", child: Text("Class Representative")),
    DropdownMenuItem<String>(
        value: "Cultural Secretary", child: Text("Cultural Secretary")),
    DropdownMenuItem<String>(
        value: "Teaching Assistant", child: Text("Teaching Assistant")),
    DropdownMenuItem<String>(
        value: "Vice President", child: Text("Vice President")),
    DropdownMenuItem<String>(value: "Monitor", child: Text("Monitor")),
    DropdownMenuItem<String>(value: "President", child: Text("President")),
    DropdownMenuItem<String>(value: "Instructor", child: Text("Instructor")),
  ];
}

class LostAndFoundConstants {
  static const String lostState = 'Lost';
  static const String foundState = 'Found';
}

class MessMenuConstants {
  static Map<String, Map<String, List<String>>> emptyMenu = {
    'Sunday': <String, List<String>>{
      'Breakfast': <String>[],
      'Lunch': <String>[],
      'Snacks': <String>[],
      'Dinner': <String>[],
    },
    'Monday': <String, List<String>>{
      'Breakfast': <String>[],
      'Lunch': <String>[],
      'Snacks': <String>[],
      'Dinner': <String>[],
    },
    'Tuesday': <String, List<String>>{
      'Breakfast': <String>[],
      'Lunch': <String>[],
      'Snacks': <String>[],
      'Dinner': <String>[],
    },
    'Wednesday': <String, List<String>>{
      'Breakfast': <String>[],
      'Lunch': <String>[],
      'Snacks': <String>[],
      'Dinner': <String>[],
    },
    'Thursday': <String, List<String>>{
      'Breakfast': <String>[],
      'Lunch': <String>[],
      'Snacks': <String>[],
      'Dinner': <String>[],
    },
    'Friday': <String, List<String>>{
      'Breakfast': <String>[],
      'Lunch': <String>[],
      'Snacks': <String>[],
      'Dinner': <String>[],
    },
    'Saturday': <String, List<String>>{
      'Breakfast': <String>[],
      'Lunch': <String>[],
      'Snacks': <String>[],
      'Dinner': <String>[],
    },
  };

  static final List<Text> weekdays = [
    Text('Sun', style: TextStyle(color: Colors.teal.shade900, fontSize: 16)),
    Text('Mon', style: TextStyle(color: Colors.teal.shade900, fontSize: 16)),
    Text('Tue', style: TextStyle(color: Colors.teal.shade900, fontSize: 16)),
    Text('Wed', style: TextStyle(color: Colors.teal.shade900, fontSize: 16)),
    Text('Thu', style: TextStyle(color: Colors.teal.shade900, fontSize: 16)),
    Text('Fri', style: TextStyle(color: Colors.teal.shade900, fontSize: 16)),
    Text('Sat', style: TextStyle(color: Colors.teal.shade900, fontSize: 16)),
  ];

  static final List<Text> mealTypes = [
    Text('Breakfast',
        style: TextStyle(color: Colors.teal.shade900, fontSize: 14)),
    Text('Lunch', style: TextStyle(color: Colors.teal.shade900, fontSize: 14)),
    Text('Snacks', style: TextStyle(color: Colors.teal.shade900, fontSize: 14)),
    Text('Dinner', style: TextStyle(color: Colors.teal.shade900, fontSize: 14)),
  ];

  static const Map<String, String> weekdaysShortToLong = {
    "Sun": "Sunday",
    "Mon": "Monday",
    "Tue": "Tuesday",
    "Wed": "Wednesday",
    "Thu": "Thursday",
    "Fri": "Friday",
    "Sat": "Saturday",
  };
}

class Validators {
  static String? descriptionValidator(String? value) {
    if (value != null && value.length > 250) {
      return "Description cannot exceed 250 characters";
    }

    return null;
  }

  static String? contactNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Contact number cannot be empty";
    }

    // Check if the contact number contains only digits
    if (!RegExp(r'^\+?\d+$').hasMatch(value)) {
      return "Invalid contact number format";
    }

    return null;
  }

  static String? nonEmptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Field cannot be empty";
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Email cannot be empty";
    }
    if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$").hasMatch(value)) {
      return "Invalid email";
    }
    return null;
  }

  static String? branchValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Branch cannot be empty";
    }
    return null;
  }

  static String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Name cannot be empty";
    }
    return null;
  }

  static String? rollNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Roll Number cannot be empty";
    }
    if (value.contains(r"!@#%^&*()_+{}||:<>?/.,$")) {
      return "Invalid Roll Number";
    }
    return null;
  }

  static String? courseCodeValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Course Code cannot be empty";
    }
    if (value.contains(r"!@#%^&*()_+{}||:<>?/.,$")) {
      return "Invalid Course Code";
    }
    return null;
  }
}
