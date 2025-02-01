import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_insti_app/screens/admin/add_courses.dart';
import 'package:smart_insti_app/screens/admin/add_students.dart';
import 'package:smart_insti_app/screens/admin/admin_home.dart';
import 'package:smart_insti_app/screens/admin/manage_rooms.dart';
import 'package:smart_insti_app/screens/admin/view_students.dart';
import 'package:smart_insti_app/screens/auth/login_general.dart';
import 'package:smart_insti_app/screens/loading_page.dart';
import 'package:smart_insti_app/screens/user/lost_and_found.dart';
import 'package:smart_insti_app/screens/user/user_mess_menu.dart';
import 'package:smart_insti_app/screens/user/timetable_editor.dart';
import '../screens/admin/add_faculty.dart';
import '../screens/admin/add_menu.dart';
import '../screens/admin/admin_profile.dart';
import '../screens/admin/view_courses.dart';
import '../screens/admin/view_faculty.dart';
import '../screens/admin/view_menu.dart';
import '../screens/auth/admin_login.dart';
import '../screens/user/chat_room.dart';
import '../screens/user/room_vacancy.dart';
import '../screens/user/timetables.dart';
import '../screens/user/student_profile.dart';
import '../screens/user/user_home.dart';
import '../screens/user/faculty_profile.dart';
import '../screens/user/broadcast.dart';

final GoRouter routes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => const MaterialPage(child: LoadingPage()),
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => MaterialPage(child: GeneralLogin()),
      routes: [
        GoRoute(
          path: 'admin_login',
          pageBuilder: (context, state) => MaterialPage(child: AdminLogin()),
        ),
      ],
    ),
    GoRoute(
      path: '/admin',
      pageBuilder: (context, state) => const MaterialPage(child: AdminHome()),
      routes: [
        GoRoute(
          path: 'profile',
          pageBuilder: (context, state) => const MaterialPage(child: AdminProfile()),
        ),
        GoRoute(
          path: 'add_students',
          pageBuilder: (context, state) => MaterialPage(child: AddStudents()),
        ),
        GoRoute(
          path: 'add_faculty',
          pageBuilder: (context, state) => MaterialPage(child: AddFaculty()),
        ),
        GoRoute(
          path: 'add_courses',
          pageBuilder: (context, state) => MaterialPage(child: AddCourses()),
        ),
        GoRoute(
          path: 'view_students',
          pageBuilder: (context, state) => MaterialPage(child: ViewStudents()),
        ),
        GoRoute(
          path: 'view_faculty',
          pageBuilder: (context, state) => MaterialPage(child: ViewFaculty()),
        ),
        GoRoute(
          path: 'view_courses',
          pageBuilder: (context, state) => MaterialPage(child: ViewCourses()),
        ),
        GoRoute(
          path: 'add_menu',
          pageBuilder: (context, state) => MaterialPage(child: AddMessMenu()),
        ),
        GoRoute(
          path: 'view_menu',
          pageBuilder: (context, state) => MaterialPage(child: ViewMessMenu()),
        ),
        GoRoute(
          path: 'manage_rooms',
          pageBuilder: (context, state) => MaterialPage(child: ManageRooms()),
        )
      ],
    ),
    GoRoute(
      path: '/user_home',
      pageBuilder: (context, state) => const MaterialPage(child: UserHome()),
      routes: [
        GoRoute(
          path: 'faculty_profile',
          pageBuilder: (context, state) => const MaterialPage(child: FacultyProfile()),
        ),
        GoRoute(
          path: 'student_profile',
          pageBuilder: (context, state) => const MaterialPage(child: StudentProfile()),
        ),
        GoRoute(
          path: 'room_vacancy',
          pageBuilder: (context, state) => const MaterialPage(child: RoomVacancy()),
        ),
        GoRoute(
          path: 'lost_and_found',
          pageBuilder: (context, state) => MaterialPage(child: LostAndFound()),
        ),
        GoRoute(
          path: 'timetables',
          pageBuilder: (context, state) => MaterialPage(child: Timetables()),
          routes: [
            GoRoute(
              path: 'editor',
              pageBuilder: (context, state) => const MaterialPage(child: TimetableEditor()),
            ),
          ],
        ),
        GoRoute(
          path: 'broadcast',
          pageBuilder: (context, state) => MaterialPage(child: BroadcastPage()),
        ),
        GoRoute(
          path: 'chat_room',
          pageBuilder: (context, state) => MaterialPage(child: ChatRoom()),
        ),
        GoRoute(path: 'mess_menu', pageBuilder: (context, state) => MaterialPage(child: UserMessMenu()) ),
      ],
    ),
  ],
);
