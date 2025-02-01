import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:smart_insti_app/components/collapsing_app_bar.dart';
import 'package:smart_insti_app/provider/auth_provider.dart';
import 'package:smart_insti_app/provider/home_provider.dart';
import '../../constants/constants.dart';
import '../../models/faculty.dart';
import '../../models/student.dart';
import '../../services/auth/auth_service.dart';

class UserHome extends ConsumerWidget {
  const UserHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeProvider.notifier).buildMenuTiles(context);
      if (ref.read(authProvider.notifier).tokenCheckProgress != LoadingState.progress && context.mounted) {
        ref.read(authProvider.notifier).verifyAuthTokenExistence(context, AuthConstants.generalAuthLabel.toLowerCase());
      }
    });

    return ResponsiveScaledBox(
      width: 411,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            CollapsingAppBar(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Welcome',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 45,
                      ),
                    ),
                    Consumer(
                      builder: (_, ref, __) {
                        if (ref.read(authProvider).currentUser != null) {
                          return AnimatedTextKit(
                            repeatForever: true,
                            pause: const Duration(milliseconds: 1500),
                            animatedTexts: [
                              TyperAnimatedText(
                                ref.read(authProvider).currentUserRole!.replaceFirst(
                                    ref.read(authProvider).currentUserRole![0],
                                    ref.read(authProvider).currentUserRole![0].toUpperCase()),
                                textStyle: const TextStyle(fontSize: 45, fontFamily: "RobotoFlex"),
                                speed: const Duration(milliseconds: 300),
                              ),
                              TyperAnimatedText(
                                ref.read(authProvider).currentUserRole == "student"
                                    ? (ref.read(authProvider).currentUser as Student).name.split(" ").first
                                    : (ref.read(authProvider).currentUser as Faculty).name.split(" ").first,
                                textStyle: const TextStyle(
                                    fontSize: 45, overflow: TextOverflow.ellipsis),
                                speed: const Duration(milliseconds: 300),
                              ),
                            ],
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    )
                  ],
                ),
              ),
              bottom: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Consumer(
                  builder: (_, ref, ___) {
                    if (ref.watch(homeProvider).toggleSearch) {
                      return SearchBar(
                        controller: ref.read(homeProvider.notifier).searchController,
                        onChanged: (value) => ref.read(homeProvider.notifier).buildMenuTiles(context),
                        leading: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            ref.read(homeProvider.notifier).searchController.clear();
                            ref.read(homeProvider.notifier).toggleSearchBar();
                            ref.read(homeProvider.notifier).buildMenuTiles(context);
                          },
                        ),
                        shadowColor: MaterialStateProperty.all(Colors.transparent),
                      );
                    } else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              iconSize: 30,
                              onPressed: () => ref.read(homeProvider.notifier).toggleSearchBar(),
                              icon: const Icon(Icons.search)),
                          PopupMenuButton(
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  value: "profile",
                                  child: const Text("User Profile"),
                                  onTap: () {
                                    if (ref.read(authProvider).currentUserRole == 'student') {
                                      context.go('/user_home/student_profile');
                                    } else if (ref.read(authProvider).currentUserRole == 'faculty') {
                                      context.go('/user_home/faculty_profile');
                                    }
                                  },
                                ),
                                PopupMenuItem(
                                  value: "about",
                                  child: const Text("About"),
                                  onTap: () => showAboutDialog(
                                    context: context,
                                    children: [
                                      const Text("Smart Insti App"),
                                      const Text(
                                          "This app aims to solve the day-to-day problems that students and faculty face in IIT Bhilai and aims to consolidate a lot of useful applications into single app. This could include features like Time Table, Classroom Vacancy, Lost and Found, Chatrooms on various topics like Internet Issues. It could also have a broadcast feature which would be very useful in emergency situations."),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: "logout",
                                  child: const Text("Log Out"),
                                  onTap: () {
                                    ref.read(authServiceProvider).clearCredentials();
                                    ref.read(authProvider.notifier).clearCurrentUser();
                                    context.go('/');
                                  },
                                ),
                              ];
                            },
                          ),
                        ],
                      );
                    }
                  },
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
                    children: ref.watch(homeProvider).menuTiles,
                  );
                },
              )),
        ),
      ),
    );
  }
}
