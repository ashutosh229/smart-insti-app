import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:smart_insti_app/components/borderless_button.dart';
import 'package:smart_insti_app/components/collapsing_app_bar.dart';
import 'package:smart_insti_app/components/material_textformfield.dart';
import 'package:smart_insti_app/provider/room_provider.dart';
import '../../components/text_divider.dart';
import '../../constants/constants.dart';
import '../../provider/auth_provider.dart';

class ManageRooms extends ConsumerWidget {
  const ManageRooms({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(roomProvider.notifier).buildRoomTiles(context);
      if (ref.read(authProvider.notifier).tokenCheckProgress != LoadingState.progress) {
        ref.read(authProvider.notifier).verifyAuthTokenExistence(context, AuthConstants.adminAuthLabel.toLowerCase());
      }
    });

    return ResponsiveScaledBox(
      width: 411,
      child: Scaffold(
        floatingActionButton: Container(
          margin: const EdgeInsets.only(bottom: 15, right: 10),
          width: 75,
          height: 75,
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: () => showDialog(
                context: context,
                builder: (_) => Dialog(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Add Room',
                          style: TextStyle(fontSize: 30),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 300,
                          child: MaterialTextFormField(
                            controller: ref.read(roomProvider).roomNameController,
                            hintText: 'Enter room name',
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BorderlessButton(
                              onPressed: () => context.pop(),
                              splashColor: Colors.redAccent,
                              backgroundColor: Colors.redAccent.shade100.withOpacity(0.2),
                              label: const Text('Cancel'),
                            ),
                            BorderlessButton(
                              onPressed: () {
                                Logger().i("Adding room");
                                ref.read(roomProvider.notifier).addRoom();
                                ref.read(roomProvider.notifier).buildRoomTiles(context);
                                context.pop();
                              },
                              splashColor: Colors.blueAccent,
                              backgroundColor: Colors.blueAccent.shade100.withOpacity(0.2),
                              label: const Text('Add'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              child: const Icon(Icons.add),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            CollapsingAppBar(
              title: const Text(
                'Manage Rooms',
                style: TextStyle(color: Colors.black),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
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
                          onPressed: () => ref.read(roomProvider.notifier).pickSpreadsheet(),
                          style: ButtonStyle(minimumSize: MaterialStateProperty.all(const Size(200, 60))),
                          child: const Text("Upload Spreadsheet"),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const TextDivider(text: "OR"),
                  const SizedBox(height: 30),
                ],
              ),
              height: 370,
              bottom: Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    SizedBox(
                      width: 390,
                      child: SearchBar(
                        controller: ref.read(roomProvider).searchRoomController,
                        hintText: 'Enter room name',
                        onChanged: (value) {
                          ref.watch(roomProvider.notifier).buildRoomTiles(context);
                        },
                        onSubmitted: (value) {
                          ref.watch(roomProvider.notifier).buildRoomTiles(context);
                        },
                        padding: MaterialStateProperty.all(const EdgeInsets.only(left: 15)),
                        shadowColor: MaterialStateProperty.all(Colors.transparent),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
          body: Container(
            color: Colors.white,
            child: Consumer(
              builder: (_, ref, ___) {
                return GridView.count(
                  padding: const EdgeInsets.all(10),
                  crossAxisCount: 2,
                  children: ref.watch(roomProvider).roomTiles,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
