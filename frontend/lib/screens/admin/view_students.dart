import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:smart_insti_app/provider/student_provider.dart';
import '../../constants/constants.dart';
import '../../models/student.dart';
import '../../provider/auth_provider.dart';
import '../../provider/student_provider.dart';

class ViewStudents extends ConsumerWidget {
  const ViewStudents({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(studentProvider.notifier).searchStudents();
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
                  controller: ref.read(studentProvider).searchStudentController,
                  hintText: 'Enter student name',
                  onChanged: (value) {
                    ref.watch(studentProvider.notifier).searchStudents();
                  },
                  onSubmitted: (value) {
                    ref.watch(studentProvider.notifier).searchStudents();
                  },
                  leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        ref
                            .read(studentProvider)
                            .searchStudentController
                            .clear();
                        context.pop();
                      }),
                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                ),
              ),
            )
          ],
        ),
        body: Consumer(
          builder: (_, ref, ___) {
            if (ref.watch(studentProvider).filteredStudents.isEmpty) {
              return const Center(
                child: Text(
                  'No students so far',
                  style: TextStyle(fontSize: 30, color: Colors.black38),
                ),
              );
            }
            return ListView.builder(
                itemBuilder: (_, index) {
                  List<Student> students =
                      ref.read(studentProvider).filteredStudents;
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
                      title: Text('Name ${students[index].name}'),
                      subtitle:
                          Text('Roll Number : ${students[index].rollNumber}'),
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
                                  title: Text('Edit Student'),
                                  content: Text(
                                      "Student editing will be added in future"),
                                ),
                              ),
                            ),
                            IconButton(
                              iconSize: 20,
                              icon: const Icon(Icons.delete),
                              onPressed: () => ref
                                  .read(studentProvider.notifier)
                                  .removeStudent(students[index]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: ref.read(studentProvider).filteredStudents.length);
          },
        ),
      ),
    );
  }
}
