import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final aboutProvider = Provider<String?>((ref) {
  return ref.watch(aboutControllerProvider);
});

final aboutControllerProvider =
    StateNotifierProvider<AboutController, String?>((ref) {
  return AboutController();
});

class AboutController extends StateNotifier<String?> {
  AboutController() : super("");

  void updateAbout(String about) {
    state = about;
  }
}

class AboutEditWidget extends ConsumerWidget {
  final TextEditingController aboutController;

  const AboutEditWidget({required this.aboutController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final about = ref.watch(aboutProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        TextField(
          controller: aboutController,
          onChanged: (newAbout) {
            ref.read(aboutControllerProvider.notifier).updateAbout(newAbout);
          },
          decoration: const InputDecoration(
            hintText: 'Write something about yourself...',
          ),
          maxLines: 5,
        ),
      ],
    );
  }
}
