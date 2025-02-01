import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:slide_switcher/slide_switcher.dart';
import 'package:smart_insti_app/components/choice_selector.dart';
import 'package:smart_insti_app/models/mess_menu.dart';
import 'package:smart_insti_app/provider/menu_provider.dart';
import '../../constants/constants.dart';
import '../../provider/auth_provider.dart';

class UserMessMenu extends ConsumerWidget {
  const UserMessMenu({super.key});

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
          title: const Text('Mess Menu'),
        ),
        body: SingleChildScrollView(
          child: Consumer(
            builder: (_, ref, __) {
              if (ref.watch(menuProvider).loadingState == LoadingState.progress) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Column(
                  children: [
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: ChoiceSelector(
                        onChanged: (value) {
                          ref.read(menuProvider.notifier).setSelectViewMenu(value);
                        },
                        value: ref.read(menuProvider).selectedViewMenu,
                        items: [
                          for (String i in ref.read(menuProvider).messMenus.keys)
                            DropdownMenuItem<String>(
                              value: i,
                              child: Text(i),
                            ),
                        ],
                        hint: 'Select Kitchen',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                      child: SlideSwitcher(
                        onSelect: (index) => ref.read(menuProvider.notifier).selectMealType(index),
                        containerHeight: 65,
                        containerWight: 380,
                        containerBorderRadius: 20,
                        slidersColors: [Colors.tealAccent.shade700.withOpacity(0.7)],
                        containerColor: Colors.tealAccent.shade100,
                        children: MessMenuConstants.mealTypes,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 550,
                            width: 285,
                            margin: const EdgeInsets.only(right: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.transparent, width: 0),
                              color: Colors.grey[200],
                            ),
                            child: Column(
                              children: [
                                Consumer(
                                  builder: (_, ref, __) {
                                    final menuState = ref.watch(menuProvider);
                                    final weekDay =
                                        ref.watch(menuProvider.notifier).getWeekDay(menuState.selectedWeekdayIndex);
                                    final mealType =
                                        ref.watch(menuProvider.notifier).getMealType(menuState.selectedMealTypeIndex);
                                    return Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "$weekDay's $mealType",
                                            style: const TextStyle(fontSize: 23, fontFamily: "GoogleSanaFlex"),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                Consumer(
                                  builder: (context, ref, child) {
                                    final menuState = ref.watch(menuProvider);
                                    final weekDay =
                                        ref.watch(menuProvider.notifier).getWeekDay(menuState.selectedWeekdayIndex);
                                    final mealType =
                                        ref.watch(menuProvider.notifier).getMealType(menuState.selectedMealTypeIndex);
                                    if (menuState.selectedViewMenu != null) {
                                      MessMenu? selectedMenu = menuState.messMenus[menuState.selectedViewMenu];
                                      int length = selectedMenu?.messMenu?[weekDay]?[mealType]?.length ?? 0;
                                      List controllers = List.generate(length, (index) => TextEditingController());
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: length,
                                        itemBuilder: (context, index) {
                                          controllers[index].text =
                                              selectedMenu?.messMenu?[weekDay]?[mealType]?[index] ?? '';
                                          return length != 0
                                              ? Container(
                                                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15),
                                                    color: Colors.tealAccent.withOpacity(0.4),
                                                  ),
                                                  width: double.infinity,
                                                  child: AutoSizeText(
                                                    controllers[index].text,
                                                    style: TextStyle(fontSize: 15, color: Colors.teal.shade900),
                                                    maxLines: 5,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                )
                                              : const Expanded(
                                                  child: Center(
                                                    child: Text(
                                                      'No items today',
                                                      style: TextStyle(fontSize: 20, color: Colors.black38),
                                                    ),
                                                  ),
                                                );
                                        },
                                      );
                                    } else {
                                      return const Expanded(
                                        child: Center(
                                          child: Text(
                                            'No menu selected',
                                            style: TextStyle(fontSize: 20, color: Colors.black38),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: SlideSwitcher(
                              onSelect: (index) => ref.read(menuProvider.notifier).selectWeekday(index),
                              containerHeight: 550,
                              containerWight: 70,
                              containerBorderRadius: 20,
                              direction: Axis.vertical,
                              slidersColors: [Colors.tealAccent.shade700.withOpacity(0.7)],
                              containerColor: Colors.tealAccent.shade100,
                              children: MessMenuConstants.weekdays,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
