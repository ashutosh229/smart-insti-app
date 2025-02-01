import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:smart_insti_app/components/rounded_chip.dart';
import 'package:smart_insti_app/models/mess_menu.dart';
import 'package:smart_insti_app/repositories/mess_menu_repository.dart';
import '../constants/constants.dart';
import 'dart:io';

final menuProvider = StateNotifierProvider<MenuStateNotifier, MenuState>((ref) => MenuStateNotifier(ref));

class MenuState {
  final TextEditingController kitchenNameController;
  final TextEditingController itemNameController;
  final String? selectedViewMenu;
  final List<RoundedChip> items;
  final Map<String, MessMenu> messMenus;
  final MessMenu currentMenu;
  final int selectedWeekdayIndex;
  final int selectedMealTypeIndex;
  final LoadingState loadingState;

  MenuState({
    required this.kitchenNameController,
    required this.itemNameController,
    required this.selectedViewMenu,
    required this.items,
    required this.messMenus,
    required this.currentMenu,
    required this.selectedWeekdayIndex,
    required this.selectedMealTypeIndex,
    required this.loadingState,
  });

  MenuState copyWith({
    TextEditingController? kitchenNameController,
    TextEditingController? itemNameController,
    String? selectedViewMenu,
    List<RoundedChip>? items,
    Map<String, MessMenu>? messMenus,
    MessMenu? currentMenu,
    int? selectedWeekdayIndex,
    int? selectedMealTypeIndex,
    LoadingState? loadingState,
  }) {
    return MenuState(
      kitchenNameController: kitchenNameController ?? this.kitchenNameController,
      itemNameController: itemNameController ?? this.itemNameController,
      selectedViewMenu: selectedViewMenu ?? this.selectedViewMenu,
      items: items ?? this.items,
      messMenus: messMenus ?? this.messMenus,
      currentMenu: currentMenu ?? this.currentMenu,
      selectedWeekdayIndex: selectedWeekdayIndex ?? this.selectedWeekdayIndex,
      selectedMealTypeIndex: selectedMealTypeIndex ?? this.selectedMealTypeIndex,
      loadingState: loadingState ?? this.loadingState,
    );
  }
}

class MenuStateNotifier extends StateNotifier<MenuState> {
  MenuStateNotifier(Ref ref)
      : _messMenuRepository = ref.read(messMenuRepositoryProvider),
        super(MenuState(
          kitchenNameController: TextEditingController(),
          itemNameController: TextEditingController(),
          selectedViewMenu: null,
          items: [],
          messMenus: {},
          currentMenu: MessMenu(
            kitchenName: "",
            messMenu: <String, Map<String, List<String>>>{
              'Sunday': <String, List<String>>{
                'Breakfast': <String>[],
                'Lunch': <String>[],
                'Snacks': <String>[],
                'Dinner': <String>[],
              },
              'Monday': <String, List<String>>{
                'Breakfast': <String>[],
                'Lunch': <String>[],
                'Snacks': <String>[],
                'Dinner': <String>[],
              },
              'Tuesday': <String, List<String>>{
                'Breakfast': <String>[],
                'Lunch': <String>[],
                'Snacks': <String>[],
                'Dinner': <String>[],
              },
              'Wednesday': <String, List<String>>{
                'Breakfast': <String>[],
                'Lunch': <String>[],
                'Snacks': <String>[],
                'Dinner': <String>[],
              },
              'Thursday': <String, List<String>>{
                'Breakfast': <String>[],
                'Lunch': <String>[],
                'Snacks': <String>[],
                'Dinner': <String>[],
              },
              'Friday': <String, List<String>>{
                'Breakfast': <String>[],
                'Lunch': <String>[],
                'Snacks': <String>[],
                'Dinner': <String>[],
              },
              'Saturday': <String, List<String>>{
                'Breakfast': <String>[],
                'Lunch': <String>[],
                'Snacks': <String>[],
                'Dinner': <String>[],
              },
            },
          ),
          selectedWeekdayIndex: 0,
          selectedMealTypeIndex: 0,
          loadingState: LoadingState.idle,
        )) {
    loadMenus();
  }

  final Logger _logger = Logger();
  final MessMenuRepository _messMenuRepository;

  String getWeekDay(int index) => MessMenuConstants.weekdaysShortToLong[MessMenuConstants.weekdays[index].data]!;

  String getMealType(int index) => MessMenuConstants.mealTypes[index].data!;

  void pickSpreadsheet() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      bool isSpreadsheet = result.files.single.path!.endsWith(".xlsx") ||
          result.files.single.path!.endsWith(".xls") ||
          result.files.single.path!.endsWith(".csv");
      if (isSpreadsheet) {
        File file = File(result.files.single.path!);

        // TODO : Add code to send the spreadsheet to the backend

        _logger.i("Picked file ${file.path}");
      } else {
        _logger.e("Picked file is not a spreadsheet");
      }
    } else {
      _logger.e("No file picked");
    }
  }

  void setSelectViewMenu(String? value) {
    if (value != null) {
      state = state.copyWith(selectedViewMenu: value, currentMenu: state.messMenus[value!]!);
    }
  }

  void selectWeekday(int index) {
    state = state.copyWith(selectedWeekdayIndex: index);
  }

  void selectMealType(int index) {
    state = state.copyWith(selectedMealTypeIndex: index);
  }

  void clearControllers() {
    state.kitchenNameController.clear();
    state = state.copyWith(
      items: [],
      currentMenu: MessMenu(
        kitchenName: state.kitchenNameController.text,
        messMenu: <String, Map<String, List<String>>>{
          'Sunday': <String, List<String>>{
            'Breakfast': <String>[],
            'Lunch': <String>[],
            'Snacks': <String>[],
            'Dinner': <String>[],
          },
          'Monday': <String, List<String>>{
            'Breakfast': <String>[],
            'Lunch': <String>[],
            'Snacks': <String>[],
            'Dinner': <String>[],
          },
          'Tuesday': <String, List<String>>{
            'Breakfast': <String>[],
            'Lunch': <String>[],
            'Snacks': <String>[],
            'Dinner': <String>[],
          },
          'Wednesday': <String, List<String>>{
            'Breakfast': <String>[],
            'Lunch': <String>[],
            'Snacks': <String>[],
            'Dinner': <String>[],
          },
          'Thursday': <String, List<String>>{
            'Breakfast': <String>[],
            'Lunch': <String>[],
            'Snacks': <String>[],
            'Dinner': <String>[],
          },
          'Friday': <String, List<String>>{
            'Breakfast': <String>[],
            'Lunch': <String>[],
            'Snacks': <String>[],
            'Dinner': <String>[],
          },
          'Saturday': <String, List<String>>{
            'Breakfast': <String>[],
            'Lunch': <String>[],
            'Snacks': <String>[],
            'Dinner': <String>[],
          },
        },
      ),
    );
  }

  void loadMenus() async {
    state = state.copyWith(loadingState: LoadingState.progress);
    final messMenus = await _messMenuRepository.getMessMenu();

    Map<String, MessMenu> menuDictionary = {};
    for (var menu in messMenus) {
      menuDictionary[menu.kitchenName] = menu;
    }
    const selectedViewMenu = null;
    state.kitchenNameController.clear();

    state = state.copyWith(
      selectedMealTypeIndex: 0,
      selectedWeekdayIndex: 0,
      selectedViewMenu: selectedViewMenu,
      currentMenu: selectedViewMenu != null
          ? menuDictionary[selectedViewMenu]
          : MessMenu(kitchenName: '', messMenu: <String, Map<String, List<String>>>{
        'Sunday': <String, List<String>>{
          'Breakfast': <String>[],
          'Lunch': <String>[],
          'Snacks': <String>[],
          'Dinner': <String>[],
        },
        'Monday': <String, List<String>>{
          'Breakfast': <String>[],
          'Lunch': <String>[],
          'Snacks': <String>[],
          'Dinner': <String>[],
        },
        'Tuesday': <String, List<String>>{
          'Breakfast': <String>[],
          'Lunch': <String>[],
          'Snacks': <String>[],
          'Dinner': <String>[],
        },
        'Wednesday': <String, List<String>>{
          'Breakfast': <String>[],
          'Lunch': <String>[],
          'Snacks': <String>[],
          'Dinner': <String>[],
        },
        'Thursday': <String, List<String>>{
          'Breakfast': <String>[],
          'Lunch': <String>[],
          'Snacks': <String>[],
          'Dinner': <String>[],
        },
        'Friday': <String, List<String>>{
          'Breakfast': <String>[],
          'Lunch': <String>[],
          'Snacks': <String>[],
          'Dinner': <String>[],
        },
        'Saturday': <String, List<String>>{
          'Breakfast': <String>[],
          'Lunch': <String>[],
          'Snacks': <String>[],
          'Dinner': <String>[],
        },
      }),
    );
    state = state.copyWith(messMenus: menuDictionary, loadingState: LoadingState.success);
  }

  void resetMenu() {
    if (state.selectedViewMenu != null) {
      state = state.copyWith(currentMenu: state.messMenus[state.selectedViewMenu!]!);
    }
  }

  Future<void> addMenu() async {
    String kitchenName = state.kitchenNameController.text;
    if (await _messMenuRepository
        .addMessMenu(MessMenu(kitchenName: kitchenName, messMenu: state.currentMenu.messMenu!))) {
      loadMenus();
    }
  }

  void updateMenu() async {
    String kitchenName = state.currentMenu.kitchenName;
    if (await _messMenuRepository.updateMessMenu(state.messMenus[state.selectedViewMenu!]!.id!,
        MessMenu(kitchenName: kitchenName, messMenu: state.currentMenu.messMenu!))) {
      loadMenus();
    }
  }

  void deleteMenu() async {
    if (await _messMenuRepository.deleteMessMenu(state.messMenus[state.selectedViewMenu!]!.id!)) {
      loadMenus();
    }
  }

  void addMenuItem() {
    String item = state.itemNameController.text;
    if (item == '') {
      return;
    }
    String weekday = getWeekDay(state.selectedWeekdayIndex);
    String mealType = getMealType(state.selectedMealTypeIndex);

    MessMenu menu = state.currentMenu;
    menu.messMenu![weekday]![mealType]!.add(item);

    state = state.copyWith(currentMenu: menu);
    state.itemNameController.clear();
  }

  void removeMenuItem(int index) {
    String weekday = getWeekDay(state.selectedWeekdayIndex);
    String mealType = getMealType(state.selectedMealTypeIndex);
    _logger.i("Removing ${state.currentMenu.messMenu![weekday]![mealType]![index]} from $weekday $mealType");
    MessMenu menu = state.currentMenu;
    menu.messMenu![weekday]![mealType]!.removeAt(index);
    state = state.copyWith(currentMenu: menu);
  }
}
