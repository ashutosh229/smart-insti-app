import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/achievement.dart';

final achievementsProvider = Provider<List<Achievement>>((ref) {
  return ref.watch(achievementsControllerProvider);
});

final achievementsControllerProvider =
    StateNotifierProvider<AchievementsController, List<Achievement>>((ref) {
  return AchievementsController();
});

class AchievementsController extends StateNotifier<List<Achievement>> {
  AchievementsController() : super([]);

  void addAchievement(Achievement achievement) {
    state = [...state, achievement];
  }

  void updateAchievement(int index, Achievement achievement) {
    state = [...state];
    state[index] = achievement;
  }

  void removeAchievement(int index) {
    state = [...state]..removeAt(index);
  }
}

class AchievementsEditWidget extends ConsumerWidget {
  final TextEditingController achievementsController;

  const AchievementsEditWidget({required this.achievementsController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final achievements = ref.watch(achievementsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Achievements',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: achievements.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  initialValue: achievements[index].name,
                  onChanged: (value) {
                    ref
                        .read(achievementsControllerProvider.notifier)
                        .updateAchievement(
                          index,
                          Achievement(
                            id: achievements[index].id,
                            name: value,
                            date: achievements[index].date,
                            description: achievements[index].description,
                          ),
                        );
                  },
                  decoration: const InputDecoration(labelText: 'Achievement'),
                ),
                CalendarDatePicker2(
                  config: CalendarDatePicker2Config(),
                  value: [achievements[index].date],
                  onValueChanged: (List<DateTime?> dates) {
                    if (dates.isNotEmpty && dates[0] != null) {
                      ref
                          .read(achievementsControllerProvider.notifier)
                          .updateAchievement(
                            index,
                            Achievement(
                              id: achievements[index].id,
                              name: achievements[index].name,
                              date: dates[0]!,
                              description: achievements[index].description,
                            ),
                          );
                    }
                  },
                ),
                TextFormField(
                  initialValue: achievements[index].description,
                  onChanged: (value) {
                    ref
                        .read(achievementsControllerProvider.notifier)
                        .updateAchievement(
                          index,
                          Achievement(
                            id: achievements[index].id,
                            name: achievements[index].name,
                            date: achievements[index].date,
                            description: value,
                          ),
                        );
                  },
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    ref
                        .read(achievementsControllerProvider.notifier)
                        .removeAchievement(index);
                  },
                ),
              ],
            );
          },
        ),
        ElevatedButton(
          onPressed: () {
            ref.read(achievementsControllerProvider.notifier).addAchievement(
                  Achievement(
                    id: UniqueKey().toString(),
                    name: "",
                    date: DateTime.now(),
                    description: "",
                  ),
                );
          },
          child: const Text("Add Achievement"),
        ),
      ],
    );
  }
}
