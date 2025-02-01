import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:smart_insti_app/components/collapsing_app_bar.dart';
import 'package:smart_insti_app/provider/admin_provider.dart';
import 'package:smart_insti_app/provider/auth_provider.dart';
import 'package:smart_insti_app/services/auth/auth_service.dart';
import '../../constants/constants.dart';
import '../../models/admin.dart';

class AdminHome extends ConsumerWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(adminProvider.notifier).buildMenuTiles(context);
      if (ref.read(authProvider.notifier).tokenCheckProgress != LoadingState.progress) {
        ref.read(authProvider.notifier).verifyAuthTokenExistence(context, AuthConstants.adminAuthLabel.toLowerCase());
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
                        fontFamily: "RobotoFlex",
                      ),
                    ),
                    Consumer(
                      builder: (_, ref, __) {
                        if (ref.read(authProvider).currentUser != null) {
                          Admin admin = ref.read(authProvider).currentUser as Admin;
                          return AnimatedTextKit(
                            repeatForever: true,
                            pause: const Duration(milliseconds: 1500),
                            animatedTexts: [
                              TyperAnimatedText(
                                'Admin',
                                textStyle: const TextStyle(fontSize: 45),
                                speed: const Duration(milliseconds: 300),
                              ),
                              TyperAnimatedText(
                                admin.name,
                                textStyle: const TextStyle(fontSize: 45, overflow: TextOverflow.ellipsis),
                                speed: const Duration(milliseconds: 300),
                              ),
                            ],
                          );
                        } else {
                          return const Text('Admin', style: TextStyle(fontSize: 45, fontFamily: "Jost"));
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
                    if (ref.watch(adminProvider).toggleSearch) {
                      return SearchBar(
                        controller: ref.read(adminProvider).searchController,
                        onChanged: (value) => ref.read(adminProvider.notifier).buildMenuTiles(context),
                        leading: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            ref.read(adminProvider).searchController.clear();
                            ref.read(adminProvider.notifier).toggleSearchBar();
                            ref.read(adminProvider.notifier).buildMenuTiles(context);
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
                              onPressed: () => ref.read(adminProvider.notifier).toggleSearchBar(),
                              icon: const Icon(Icons.search)),
                          PopupMenuButton(
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  value: "profile",
                                  child: const Text("Profile"),
                                  onTap: () => context.push('/admin/profile'),
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
                  children: ref.watch(adminProvider).menuTiles,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
