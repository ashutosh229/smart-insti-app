import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:smart_insti_app/provider/timetable_provider.dart';

class TimetableEditor extends ConsumerStatefulWidget {
  const TimetableEditor({super.key});

  @override
  ConsumerState<TimetableEditor> createState() => _TimetableEditorState();
}

class _TimetableEditorState extends ConsumerState<TimetableEditor> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    });
    return ResponsiveScaledBox(
      width: 411,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          floatingActionButton: SizedBox(
            width: 30,
            height: 30,
            child: FittedBox(
              child: FloatingActionButton(
                onPressed: () async {
                  await ref.read(timetableProvider.notifier).addTimetable();
                  if (context.mounted) {
                    context.pop();
                  }
                },
                child: const Icon(Icons.add),
              ),
            ),
          ),
          body: SizedBox(
            height: height,
            width: width,
            child: InteractiveViewer(
              boundaryMargin: const EdgeInsets.all(20),
              constrained: true,
              child: Container(
                width: 90,
                padding: const EdgeInsets.all(10),
                child: Consumer(
                  builder: (_, ref, __) => ref.read(timetableProvider.notifier).buildTimetableTiles(context),
                ),
              ),
            ),
          ),
        ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
}
