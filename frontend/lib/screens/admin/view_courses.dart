import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import "package:responsive_framework/src/responsive_scaled_box.dart";
import 'package:smart_insti_app/provider/courses_provider.dart';
import '../../constants/constants.dart';
import '../../models/course.dart';
import '../../provider/auth_provider.dart';

class ViewCourses extends ConsumerWidget {
  const ViewCourses({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(coursesProvider.notifier).searchCourses();
      if (ref.read(authProvider.notifier).tokenCheckProgress !=
          LoadingState.progress) {
        ref.read(authProvider.notifier).verifyAuthTokenExistence(
            context, AuthConstants.adminAuthLabel.toLowerCase());
      }
    });

    return ResponsiveScaledBox(
      width: 411,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                width: 390,
                child: SearchBar(
                  controller: ref.read(coursesProvider).searchCourseController,
                  hintText: 'Enter course name',
                  onChanged: (value) {
                    ref.watch(coursesProvider.notifier).searchCourses();
                  },
                  onSubmitted: (value) {
                    ref.watch(coursesProvider.notifier).searchCourses();
                  },
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      ref.read(coursesProvider).searchCourseController.clear();
                      context.pop();
                    },
                  ),
                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                ),
              ),
            )
          ],
        ),
        body: Consumer(
          builder: (_, ref, ___) {
            if (ref.watch(coursesProvider).filteredCourses.isEmpty) {
              return const Center(
                child: Text(
                  'No Courses so far',
                  style: TextStyle(fontSize: 30, color: Colors.black38),
                ),
              );
            }
            return ListView.builder(
                itemBuilder: (_, index) {
                  List<Course> courses =
                      ref.read(coursesProvider).filteredCourses;
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: ListTile(
                      tileColor: Colors.grey.shade200,
                      selectedTileColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      title: Text('Course ${courses[index].courseName}'),
                      subtitle:
                          Text('Course Code : ${courses[index].courseCode}'),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              iconSize: 20,
                              icon: const Icon(Icons.edit),
                              onPressed: () => showDialog(
                                context: context,
                                builder: (_) => const AlertDialog(
                                  title: Text('Edit Course'),
                                  content: Text(
                                      "Course editing will be added in future"),
                                ),
                              ),
                            ),
                            IconButton(
                              iconSize: 20,
                              icon: const Icon(Icons.delete),
                              onPressed: () => ref
                                  .read(coursesProvider.notifier)
                                  .removeCourse(courses[index]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: ref.read(coursesProvider).filteredCourses.length);
          },
        ),
      ),
    );
  }
}
