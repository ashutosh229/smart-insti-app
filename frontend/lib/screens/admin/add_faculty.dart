import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:search_choices/search_choices.dart';
import 'package:smart_insti_app/components/material_textformfield.dart';
import 'package:smart_insti_app/provider/courses_provider.dart';
import '../../components/text_divider.dart';
import '../../constants/constants.dart';
import '../../models/course.dart';
import '../../provider/auth_provider.dart';
import '../../provider/faculty_provider.dart';

class AddFaculty extends ConsumerWidget {
  AddFaculty({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ref.read(authProvider.notifier).tokenCheckProgress != LoadingState.progress) {
        ref.read(authProvider.notifier).verifyAuthTokenExistence(context, AuthConstants.adminAuthLabel.toLowerCase());
      }
    });
    return ResponsiveScaledBox(
      width: 411,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Faculty'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 30),
                  child: const Text(
                    "Spreadsheet Entry",
                    style: TextStyle(fontSize: 32, fontFamily: "RobotoFlex"),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Upload file here",
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 30),
                      ElevatedButton(
                        onPressed: () => ref
                            .read(facultyProvider.notifier)
                            .pickSpreadsheet(),
                        style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(const Size(200, 60))),
                        child: const Text("Upload Spreadsheet"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const TextDivider(text: "OR"),
                const SizedBox(height: 30),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 30),
                  child: const Text(
                    "Single Entry",
                    style: TextStyle(fontSize: 32, fontFamily: "RobotoFlex"),
                  ),
                ),
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        MaterialTextFormField(
                          controller: ref
                              .read(facultyProvider.notifier)
                              .facultyNameController,
                          validator: (value) => Validators.nameValidator(value),
                          hintText: 'Faculty Name',
                          hintColor: Colors.teal.shade900.withOpacity(0.5),
                        ),
                        const SizedBox(height: 30),
                        MaterialTextFormField(
                          controller: ref
                              .read(facultyProvider.notifier)
                              .facultyEmailController,
                          validator: (value) =>
                              Validators.emailValidator(value),
                          hintText: 'Faculty Mail',
                          hintColor: Colors.teal.shade900.withOpacity(0.5),
                        ),
                        const SizedBox(height: 30),
                        SearchChoices.multiple(
                          style: TextStyle(
                            color: Colors.teal.shade900,
                            fontSize: 15,
                            fontFamily: "RobotoFlex",
                          ),
                          onChanged: (value) {
                            List<Course> selectedCourses = [];
                            for (int i = 0; i < value.length; i++) {
                              selectedCourses.add(
                                  ref.read(coursesProvider).courses[value[i]]);
                            }
                            ref
                                .read(facultyProvider.notifier)
                                .updateSelectedCourses(selectedCourses);
                          },
                          fieldPresentationFn: (Widget fieldWidget,
                              {bool? selectionIsValid}) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  color: Colors.teal.shade900,
                                  fontSize: 15,
                                  fontFamily: "RobotoFlex",
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                isDense: true,
                                filled: true,
                                fillColor: Colors.tealAccent.withOpacity(0.4),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                              ),
                              child: fieldWidget,
                            );
                          },
                          items: [
                            if (ref.read(coursesProvider).courses.isNotEmpty)
                              for (Course course
                                  in ref.read(coursesProvider).courses)
                                DropdownMenuItem(
                                  value: course.courseCode,
                                  child: Text(course.courseName!),
                                ),
                          ],
                          hint: 'Select Courses',
                          dialogBox: false,
                          isExpanded: true,
                          displayClearIcon: false,
                          menuConstraints:
                              BoxConstraints.tight(const Size.fromHeight(350)),
                          validator: null,
                          menuBackgroundColor: Colors.tealAccent.shade100,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ref.read(facultyProvider.notifier).addFaculty();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Added Faculty')),
                        );
                      }
                    },
                    style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all(const Size(200, 60))),
                    child: const Text("Add Faculty"),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
