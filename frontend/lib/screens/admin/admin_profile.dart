import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:smart_insti_app/components/material_textformfield.dart';
import 'package:smart_insti_app/provider/auth_provider.dart';

import '../../constants/constants.dart';
import '../../models/admin.dart';

class AdminProfile extends ConsumerWidget {
  const AdminProfile({super.key});

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
        body: Consumer(
          builder: (_, ref, __) {
            if (ref.read(authProvider).currentUser == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              Admin admin = ref.read(authProvider).currentUser as Admin;
              return Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Admin Profile', style: TextStyle(fontSize: 35, fontFamily: 'Jost')),
                      const SizedBox(height: 20),
                      MaterialTextFormField(hintText: "Admin Name", enabled: false, controllerLessValue: admin.name),
                      const SizedBox(height: 20),
                      MaterialTextFormField(hintText: "Admin Email", enabled: false, controllerLessValue: admin.email),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
