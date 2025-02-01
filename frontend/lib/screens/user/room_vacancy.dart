import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:smart_insti_app/components/borderless_button.dart';
import 'package:smart_insti_app/components/menu_tile.dart';
import 'package:smart_insti_app/constants/constants.dart';
import 'package:smart_insti_app/provider/room_provider.dart';
import '../../models/admin.dart';
import '../../models/faculty.dart';
import '../../models/room.dart';
import '../../models/student.dart';
import '../../provider/auth_provider.dart';

class RoomVacancy extends ConsumerWidget {
  const RoomVacancy({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ref.read(authProvider.notifier).tokenCheckProgress != LoadingState.progress) {
        ref.read(authProvider.notifier).verifyAuthTokenExistence(context, AuthConstants.generalAuthLabel.toLowerCase());
      }
    });
    if (ref.read(roomProvider).loadingState == LoadingState.progress) ref.read(roomProvider.notifier).loadRooms();
    return ResponsiveScaledBox(
      width: 411,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Room Vacancy'),
        ),
        body: ref.watch(roomProvider).loadingState == LoadingState.success
            ? ref.read(roomProvider).roomList.isNotEmpty
                ? GridView.count(
                    crossAxisCount: 2,
                    children: [
                      for (Room room in ref.read(roomProvider).roomList)
                        MenuTile(
                          title: room.name,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => Dialog(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("${room.name} : ${room.vacant ? 'Vacant' : 'Occupied'}",
                                          style: const TextStyle(fontSize: 20)),
                                      room.vacant
                                          ? const SizedBox.shrink()
                                          : Text(
                                              "by : ${room.occupantName}",
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              style: const TextStyle(overflow: TextOverflow.ellipsis),
                                            ),
                                      const SizedBox(height: 20),
                                      room.vacant
                                          ? Row(
                                              children: [
                                                BorderlessButton(
                                                  onPressed: () => context.pop(),
                                                  label: const Text('Cancel'),
                                                  backgroundColor: Colors.red.shade100,
                                                  splashColor: Colors.redAccent,
                                                ),
                                                const Spacer(),
                                                BorderlessButton(
                                                  onPressed: () {
                                                    ref.read(roomProvider.notifier).reserveRoom(room);
                                                    context.pop();
                                                  },
                                                  label: const Text('Reserve'),
                                                  backgroundColor: Colors.blue.shade100,
                                                  splashColor: Colors.blueAccent,
                                                ),
                                              ],
                                            )
                                          : Consumer(
                                              builder: (_, ref, __) {
                                                String userId;
                                                final authState = ref.watch(authProvider);
                                                if (authState.currentUserRole == 'student') {
                                                  userId = (authState.currentUser as Student).id;
                                                } else if (authState.currentUserRole == 'faculty') {
                                                  userId = (authState.currentUser as Faculty).id;
                                                } else if (authState.currentUserRole == 'admin') {
                                                  userId = (authState.currentUser as Admin).id;
                                                } else {
                                                  return const SizedBox.shrink();
                                                }
                                                if (userId == room.occupantId) {
                                                  return BorderlessButton(
                                                    onPressed: () {
                                                      ref.read(roomProvider.notifier).vacateRoom(room);
                                                      context.pop();
                                                    },
                                                    label: const Text('Vacate'),
                                                    backgroundColor: Colors.red.shade100,
                                                    splashColor: Colors.redAccent,
                                                  );
                                                } else {
                                                  return const SizedBox.shrink();
                                                }
                                              },
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          body: [
                            const SizedBox(height: 5),
                            Text(
                              room.vacant ? 'Vacant' : 'Occupied',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 10),
                            room.vacant
                                ? Container()
                                : Text(
                                    "by : ${room.occupantName}",
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    style: const TextStyle(overflow: TextOverflow.ellipsis),
                                  ),
                          ],
                          icon: Icons.class_,
                          primaryColor: room.vacant ? Colors.greenAccent.shade100 : Colors.redAccent.shade100,
                          secondaryColor: room.vacant ? Colors.greenAccent.shade200 : Colors.redAccent.shade200,
                        ),
                    ],
                  )
                : const Center(
                    child: Text(
                      'No Rooms to go to',
                      style: TextStyle(fontSize: 30, color: Colors.black38),
                    ),
                  )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
