import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import "package:responsive_framework/src/responsive_scaled_box.dart";
import 'package:smart_insti_app/provider/faculty_provider.dart';

import '../../constants/constants.dart';
import '../../models/faculty.dart';
import '../../provider/auth_provider.dart';

class ViewFaculty extends ConsumerWidget {
  const ViewFaculty({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(facultyProvider.notifier).searchFaculties();
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
                  controller: ref
                      .read(facultyProvider.notifier)
                      .searchFacultyController,
                  hintText: 'Enter faculty name',
                  onChanged: (value) {
                    ref.read(facultyProvider.notifier).searchFaculties();
                  },
                  onSubmitted: (value) {
                    ref.read(facultyProvider.notifier).searchFaculties();
                  },
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      ref.read(facultyProvider).searchFacultyController.clear();
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
            if (ref.watch(facultyProvider).filteredFaculties.isEmpty) {
              return const Center(
                child: Text(
                  'No Faculties so far',
                  style: TextStyle(fontSize: 30, color: Colors.black38),
                ),
              );
            }
            return ListView.builder(
                itemBuilder: (_, index) {
                  List<Faculty> faculties =
                      ref.read(facultyProvider).filteredFaculties;
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
                      title: Text('Faculty : ${faculties[index].name}'),
                      subtitle:
                          Text('Faculty Email : ${faculties[index].email}'),
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
                                  title: Text('Edit Faculty'),
                                  content: Text(
                                      "Faculty editing will be added in future"),
                                ),
                              ),
                            ),
                            IconButton(
                              iconSize: 20,
                              icon: const Icon(Icons.delete),
                              onPressed: () => ref
                                  .read(facultyProvider.notifier)
                                  .removeFaculty(faculties[index]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: ref.read(facultyProvider).filteredFaculties.length);
          },
        ),
      ),
    );
  }
}
