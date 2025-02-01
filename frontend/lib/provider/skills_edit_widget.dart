import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../models/skills.dart';

final skillsProvider = Provider<List<Skill>>((ref) {
  return ref.watch(skillsControllerProvider);
});

final skillsControllerProvider =
    StateNotifierProvider<SkillsController, List<Skill>>((ref) {
  return SkillsController();
});

class SkillsController extends StateNotifier<List<Skill>> {
  SkillsController() : super([]);

  void addSkill(Skill skill) {
    state = [...state, skill];
  }

  void updateSkill(int index, Skill skill) {
    state = [...state];
    state[index] = skill;
  }

  void removeSkill(int index) {
    state = [...state]..removeAt(index);
  }
}

class SkillsEditWidget extends ConsumerWidget {
  final TextEditingController skillsController;

  const SkillsEditWidget({required this.skillsController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skills = ref.watch(skillsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Skills',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: skills.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: skills[index].name,
                    onChanged: (value) {
                      ref.read(skillsControllerProvider.notifier).updateSkill(
                            index,
                            Skill(
                                id: skills[index].id,
                                name: value,
                                level: skills[index].level),
                          );
                    },
                    decoration: const InputDecoration(labelText: 'Skill'),
                  ),
                ),
                Expanded(
                  child: Slider(
                    min: 0.0,
                    max: 100.0,
                    value: skills[index].level.toDouble(),
                    onChanged: (dynamic value) {
                      ref.read(skillsControllerProvider.notifier).updateSkill(
                            index,
                            Skill(
                                id: skills[index].id,
                                name: skills[index].name,
                                level: value.toInt()),
                          );
                    },
                    divisions: 5, // Add divisions
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    ref
                        .read(skillsControllerProvider.notifier)
                        .removeSkill(index);
                  },
                ),
              ],
            );
          },
        ),
        ElevatedButton(
          onPressed: () {
            ref.read(skillsControllerProvider.notifier).addSkill(
                  Skill(id: UniqueKey().toString(), name: "", level: 0),
                );
          },
          child: const Text("Add Skill"),
        ),
      ],
    );
  }
}
