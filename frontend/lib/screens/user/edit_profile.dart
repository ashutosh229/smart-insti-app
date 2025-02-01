import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/skills_edit_widget.dart';
import '../../provider/achievements_edit_widget.dart';
import '../../provider/about_Edit_widget.dart';
import 'dart:convert';

class EditProfileScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aboutController = ref.watch(aboutControllerProvider);
    final skills = ref.watch(skillsProvider);
    final achievements = ref.watch(achievementsProvider);

    String skillsJson = jsonEncode(skills);
    String achievementsJson = jsonEncode(achievements);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AboutEditWidget(
                aboutController: TextEditingController(text: aboutController),
              ),
              SkillsEditWidget(
                skillsController: TextEditingController(text: skillsJson),
              ),
              AchievementsEditWidget(
                achievementsController:
                    TextEditingController(text: achievementsJson),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
