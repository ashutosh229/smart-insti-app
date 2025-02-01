import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:smart_insti_app/components/choice_selector.dart';
import 'package:smart_insti_app/components/material_textformfield.dart';
import 'package:smart_insti_app/components/text_divider.dart';
import 'package:smart_insti_app/constants/constants.dart';

import '../../provider/student_provider.dart';
import '../../provider/auth_provider.dart';

class AddStudents extends ConsumerWidget {
  AddStudents({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
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
          title: const Text("Add Students"),
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
                            .read(studentProvider.notifier)
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
                              .watch(studentProvider.notifier)
                              .studentNameController,
                          validator: (value) => Validators.nameValidator(value),
                          hintText: "Enter Student Name",
                          hintColor: Colors.teal.shade900.withOpacity(0.5),
                        ),
                        const SizedBox(height: 30),
                        MaterialTextFormField(
                          controller: ref
                              .read(studentProvider.notifier)
                              .studentRollNoController,
                          validator: (value) =>
                              Validators.rollNumberValidator(value),
                          hintText: "Enter Roll Number",
                          hintColor: Colors.teal.shade900.withOpacity(0.5),
                        ),
                        const SizedBox(height: 30),
                        MaterialTextFormField(
                          controller: ref
                              .read(studentProvider.notifier)
                              .studentEmailController,
                          validator: (value) =>
                              Validators.emailValidator(value),
                          hintText: "Enter Student Mail",
                          hintColor: Colors.teal.shade900.withOpacity(0.5),
                        ),
                        const SizedBox(height: 30),
                        ChoiceSelector(
                          onChanged: (value) => ref
                              .read(studentProvider.notifier)
                              .updateBranch(value!),
                          value: ref.watch(studentProvider).branch,
                          items: Branches.branchList,
                          hint: "Select Branch",
                        ),
                        const SizedBox(height: 30),
                        ChoiceSelector(
                          onChanged: (value) => ref
                              .read(studentProvider.notifier)
                              .updateRole(value!),
                          value: ref.watch(studentProvider).role,
                          items: StudentRoles.studentRoleList,
                          hint: "Select student role",
                        ),
                        const SizedBox(height: 30),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ref.read(studentProvider.notifier).addStudent();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Added Student')),
                                );
                              }
                            },
                            style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                    const Size(200, 60))),
                            child: const Text("Add Student"),
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
