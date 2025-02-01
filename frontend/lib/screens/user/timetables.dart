import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:smart_insti_app/components/borderless_button.dart';
import 'package:smart_insti_app/components/material_textformfield.dart';
import 'package:smart_insti_app/constants/constants.dart';
import 'package:smart_insti_app/provider/timetable_provider.dart';

import '../../provider/auth_provider.dart';

class Timetables extends ConsumerWidget {
  Timetables({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<TooltipState> _toolTipKey = GlobalKey<TooltipState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ref.read(authProvider.notifier).tokenCheckProgress != LoadingState.progress && context.mounted) {
        ref.read(authProvider.notifier).verifyAuthTokenExistence(context, AuthConstants.generalAuthLabel.toLowerCase());
      }
    });

    return ResponsiveScaledBox(
      width: 411,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Time Tables'),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 70,
            height: 70,
            child: FloatingActionButton(
              onPressed: () {
                ref.read(timetableProvider.notifier).clearControllers();
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    content: SizedBox(
                      width: 400,
                      height: 305,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const Text(
                              'Add Time Table',
                              style: TextStyle(fontSize: 28),
                            ),
                            const SizedBox(height: 20),
                            MaterialTextFormField(
                              hintText: "Timetable name",
                              controller: ref.read(timetableProvider).timetableNameController,
                              validator: (value) => Validators.nameValidator(value),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 70,
                                  child: MaterialTextFormField(
                                    controller: ref.read(timetableProvider).rowsController,
                                    textAlign: TextAlign.center,
                                    enabled: false,
                                    hintText: '',
                                  ),
                                ),
                                const SizedBox(width: 15),
                                const Text('X', style: TextStyle(fontSize: 18)),
                                const SizedBox(width: 15),
                                Tooltip(
                                  key: _toolTipKey,
                                  verticalOffset: 40,
                                  showDuration: const Duration(seconds: 1),
                                  message: "Please enter number of columns",
                                  triggerMode: TooltipTriggerMode.manual,
                                  child: SizedBox(
                                    width: 70,
                                    child: MaterialTextFormField(
                                      hintText: "",
                                      textAlign: TextAlign.center,
                                      controller: ref.read(timetableProvider).columnsController,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(1),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Include Saturday?', style: TextStyle(fontSize: 15)),
                                const SizedBox(width: 20),
                                Consumer(
                                  builder: (_, ref, __) => AnimatedToggleSwitch.dual(
                                    height: 45,
                                    spacing: 15,
                                    onTap: (value) {
                                      ref.read(timetableProvider.notifier).toggleIncludeSaturday();
                                    },
                                    current: ref.watch(timetableProvider).includeSaturday,
                                    first: true,
                                    second: false,
                                    styleBuilder: (value) => value
                                        ? ToggleStyle(
                                            indicatorColor: Colors.teal,
                                            backgroundColor: Colors.tealAccent.shade100,
                                            borderColor: Colors.transparent,
                                          )
                                        : ToggleStyle(
                                            indicatorColor: Colors.redAccent,
                                            backgroundColor: Colors.redAccent.shade100,
                                            borderColor: Colors.transparent,
                                          ),
                                    iconBuilder: (value) => value
                                        ? const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                          )
                                        : const Icon(
                                            Icons.not_interested_rounded,
                                            color: Colors.white,
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BorderlessButton(
                            onPressed: () {
                              ref.read(timetableProvider.notifier).clearControllers();
                              context.pop();
                            },
                            label: const Text('Back'),
                            backgroundColor: Colors.red.shade100,
                            splashColor: Colors.red.shade700,
                          ),
                          BorderlessButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (ref.read(timetableProvider).columnsController.text == '') {
                                  _toolTipKey.currentState?.ensureTooltipVisible();
                                } else {
                                  context.pop();
                                  ref.read(timetableProvider.notifier).initTileControllersAndTime();
                                  context.push('/user_home/timetables/editor');
                                }
                              }
                            },
                            label: const Text('Add'),
                            backgroundColor: Colors.green.shade100,
                            splashColor: Colors.green.shade700,
                          ),
                        ],
                      )
                    ],
                    actionsAlignment: MainAxisAlignment.spaceBetween,
                  ),
                );
              },
              child: const Icon(Icons.add),
            ),
          ),
        ),
        body: Consumer(
          builder: (_, ref, __) {
            if (ref.watch(timetableProvider).timetables.isEmpty) {
              return const Center(
                child: Text(
                  'No timetables so far',
                  style: TextStyle(fontSize: 30, color: Colors.black38),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: ref.watch(timetableProvider).timetables.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(ref.watch(timetableProvider).timetables[index].name),
                      tileColor: Colors.grey.shade300,
                      subtitle: Text('Rows: ${ref.watch(timetableProvider).timetables[index].rows} Columns: ${ref.watch(timetableProvider).timetables[index].columns}'),
                      onTap: () {
                        ref.read(timetableProvider.notifier).initTileControllersAndTime(timetable : ref.read(timetableProvider).timetables[index]);
                        context.push('/user_home/timetables/editor');
                      },
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        iconSize: 21,
                        onPressed: () async {
                          await ref.read(timetableProvider.notifier).deleteTimetable(ref.read(timetableProvider).timetables[index]);
                        },
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),

                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
