import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:slide_switcher/slide_switcher.dart';
import 'package:smart_insti_app/components/material_textformfield.dart';
import 'package:smart_insti_app/components/rounded_chip.dart';
import 'package:smart_insti_app/constants/constants.dart';
import '../../components/text_divider.dart';
import '../../provider/auth_provider.dart';
import '../../provider/menu_provider.dart';

class AddMessMenu extends ConsumerWidget {
  AddMessMenu({super.key});

  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.watch(menuProvider.notifier).clearControllers();
      if (ref.read(authProvider.notifier).tokenCheckProgress != LoadingState.progress) {
        ref.read(authProvider.notifier).verifyAuthTokenExistence(context, AuthConstants.adminAuthLabel.toLowerCase());
      }
    });

    return ResponsiveScaledBox(
      width: 411,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Mess Menu'),
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Consumer(
            builder: (_, ref, __) {
              if (ref.watch(menuProvider).loadingState == LoadingState.progress) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Column(
                  children: [
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
                            onPressed: () => ref.read(menuProvider.notifier).pickSpreadsheet(),
                            style: ButtonStyle(minimumSize: MaterialStateProperty.all(const Size(200, 60))),
                            child: const Text("Upload Spreadsheet"),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    const TextDivider(text: "OR"),
                    const SizedBox(height: 30),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 30),
                      child: const Text(
                        "Single Entry",
                        style: TextStyle(fontSize: 32, fontFamily: "RobotoFlex"),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: Form(
                        key: _formKey,
                        child: MaterialTextFormField(
                          controller: ref.read(menuProvider).kitchenNameController,
                          validator: (value) => Validators.nameValidator(value),
                          hintText: "Enter kitchen name",
                          onSubmitted: (value) => _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          ),
                          hintColor: Colors.teal.shade900.withOpacity(0.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
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
                    const SizedBox(height: 30),
                    Consumer(
                      builder: (_, ref, ___) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SlideSwitcher(
                                  onSelect: (index) => ref.read(menuProvider.notifier).selectWeekday(index),
                                  containerHeight: 550,
                                  containerWight: 70,
                                  containerBorderRadius: 20,
                                  direction: Axis.vertical,
                                  slidersColors: [Colors.tealAccent.shade700.withOpacity(0.7)],
                                  containerColor: Colors.tealAccent.shade100,
                                  children: MessMenuConstants.weekdays),
                              Container(
                                height: 550,
                                width: 285,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.transparent, width: 0),
                                  color: Colors.grey[200],
                                ),
                                child: Column(
                                  children: [
                                    Consumer(
                                      builder: (_, ref, __) {
                                        final weekDayIndex = ref.watch(menuProvider).selectedWeekdayIndex;
                                        final mealTypeIndex = ref.watch(menuProvider).selectedMealTypeIndex;

                                        final weekDay = ref.watch(menuProvider.notifier).getWeekDay(weekDayIndex);
                                        final mealType = ref.watch(menuProvider.notifier).getMealType(mealTypeIndex);
                                        return Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "$weekDay's $mealType",
                                            style: const TextStyle(fontSize: 23, fontFamily: "GoogleSanaFlex"),
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: MaterialTextFormField(
                                        controller: ref.read(menuProvider).itemNameController,
                                        onSubmitted: (value) => ref.read(menuProvider.notifier).addMenuItem(),
                                        validator: (value) => Validators.nameValidator(value),
                                        hintText: 'Enter Menu Item',
                                        hintColor: Colors.teal.shade900.withOpacity(0.5),
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    Container(
                                      width: 250,
                                      height: 360,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: Colors.transparent, width: 0),
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(left: 20, top: 15),
                                            alignment: Alignment.topLeft,
                                            child: const Text(
                                              "Menu Item",
                                              style: TextStyle(fontSize: 18, fontFamily: "GoogleSanaFlex"),
                                            ),
                                          ),
                                          const Divider(height: 20),
                                          Expanded(
                                            child: Consumer(
                                              builder: (_, ref, ___) {
                                                final menuState = ref.watch(menuProvider);
                                                final weekDay = ref
                                                    .watch(menuProvider.notifier)
                                                    .getWeekDay(menuState.selectedWeekdayIndex);
                                                final mealType = ref
                                                    .watch(menuProvider.notifier)
                                                    .getMealType(menuState.selectedMealTypeIndex);
                                                final currentMenu = ref.watch(menuProvider).currentMenu;
                                                return ListView.builder(
                                                  itemCount: currentMenu.messMenu![weekDay]![mealType]!.length,
                                                  itemBuilder: (context, index) {
                                                    return Container(
                                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                                      alignment: Alignment.centerLeft,
                                                      child: RoundedChip(
                                                        label: currentMenu.messMenu![weekDay]![mealType]![index],
                                                        color: Colors.tealAccent.shade100,
                                                        onDeleted: () =>
                                                            ref.watch(menuProvider.notifier).removeMenuItem(index),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ref.read(menuProvider.notifier).addMenu();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Menu added successfully"),
                                ),
                              );
                            }
                          },
                          style: ButtonStyle(minimumSize: MaterialStateProperty.all(const Size(200, 60))),
                          child: const Text("Add Menu"),
                        ),
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
