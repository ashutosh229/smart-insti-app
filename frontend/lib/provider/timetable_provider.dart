import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:smart_insti_app/components/borderless_button.dart';
import 'package:smart_insti_app/components/material_textformfield.dart';
import 'package:smart_insti_app/provider/auth_provider.dart';
import '../components/menu_tile.dart';
import '../components/timetable_button.dart';
import '../constants/constants.dart';
import '../models/admin.dart';
import '../models/faculty.dart';
import '../models/student.dart';
import '../models/timtable.dart';
import '../repositories/timetable_repository.dart';

final timetableProvider = StateNotifierProvider<TimetableProvider, TimetableState>((ref) => TimetableProvider(ref));

class TimetableState {
  final List<Timetable> timetables;
  final TextEditingController searchTimetableController;
  final TextEditingController timetableNameController;
  final TextEditingController rowsController;
  final TextEditingController columnsController;
  final bool includeSaturday;
  final List<List<TextEditingController>> tileControllers;
  final List<(TimeOfDay, TimeOfDay)> timeRanges;
  final bool tilesDisabled;
  final LoadingState loadingState;

  TimetableState(
      {required this.timetables,
      required this.searchTimetableController,
      required this.timetableNameController,
      required this.rowsController,
      required this.columnsController,
      required this.includeSaturday,
      required this.tileControllers,
      required this.timeRanges,
      required this.tilesDisabled,
      required this.loadingState});

  TimetableState copyWith({
    List<Timetable>? timetables,
    List<MenuTile>? timetableTiles,
    TextEditingController? searchTimetableController,
    TextEditingController? timetableNameController,
    TextEditingController? rowsController,
    TextEditingController? columnsController,
    bool? includeSaturday,
    List<List<TextEditingController>>? tileControllers,
    List<(TimeOfDay, TimeOfDay)>? timeRanges,
    bool? tilesDisabled,
    LoadingState? loadingState,
  }) {
    return TimetableState(
      timetables: timetables ?? this.timetables,
      searchTimetableController: searchTimetableController ?? this.searchTimetableController,
      timetableNameController: timetableNameController ?? this.timetableNameController,
      rowsController: rowsController ?? this.rowsController,
      columnsController: columnsController ?? this.columnsController,
      includeSaturday: includeSaturday ?? this.includeSaturday,
      tileControllers: tileControllers ?? this.tileControllers,
      timeRanges: timeRanges ?? this.timeRanges,
      tilesDisabled: tilesDisabled ?? this.tilesDisabled,
      loadingState: loadingState ?? this.loadingState,
    );
  }
}

class TimetableProvider extends StateNotifier<TimetableState> {
  TimetableProvider(Ref ref)
      : _authState = ref.read(authProvider),
        _api = ref.read(timetableRepositoryProvider),
        super(
          TimetableState(
            timetables: [],
            searchTimetableController: TextEditingController(),
            timetableNameController: TextEditingController(),
            rowsController: TextEditingController(text: '6'),
            columnsController: TextEditingController(),
            includeSaturday: true,
            tileControllers: [],
            timeRanges: [],
            loadingState: LoadingState.progress,
            tilesDisabled: false,
          ),
        ) {
    loadTimetables();
  }

  final TimetableRepository _api;
  final AuthState _authState;
  final Logger _logger = Logger();

  void loadTimetables() async {
    state = state.copyWith(loadingState: LoadingState.progress);
    try {
      String userId;

      if (_authState.currentUserRole == 'student') {
        userId = (_authState.currentUser as Student).id;
      } else if (_authState.currentUserRole == 'faculty') {
        userId = (_authState.currentUser as Faculty).id;
      } else if (_authState.currentUserRole == 'admin') {
        userId = (_authState.currentUser as Admin).id;
      } else {
        return;
      }

      final List<Timetable> timetables = await _api.getTimetablesByCreatorId(userId) ?? [];
      state = state.copyWith(
        timetables: timetables,
        loadingState: LoadingState.success,
      );
    } catch (e) {
      _logger.e(e);
      state = state.copyWith(loadingState: LoadingState.error);
    }
  }

  initTileControllersAndTime({Timetable? timetable}) {
    if (timetable != null) {
      state.rowsController.text = timetable.rows.toString();
      state.columnsController.text = timetable.columns.toString();
      state = state.copyWith(
        //2d matrix of text controllers
        tileControllers: List.generate(
          timetable.columns,
          (i) => List.generate(
            timetable.rows,
            (j) => TextEditingController(),
          ),
        ),
        includeSaturday: timetable.rows == 6 ? true : false,
        timeRanges: timetable.timeRanges,
        tilesDisabled: true,
      );

      for (int i = 0; i < timetable.columns; i++) {
        for (int j = 0; j < timetable.rows; j++) {
          state.tileControllers[i][j].text = timetable.timetable[i][j];
        }
      }
    } else {
      state = state.copyWith(
        //2d matrix of text controllers
        tileControllers: List.generate(
          int.parse(state.columnsController.text),
          (i) => List.generate(
            int.parse(state.rowsController.text),
            (j) => TextEditingController(),
          ),
        ),
        timeRanges: List.generate(
          int.parse(state.columnsController.text),
          (index) => (const TimeOfDay(hour: 0, minute: 0), const TimeOfDay(hour: 0, minute: 0)),
        ),
        tilesDisabled: false,
      );
    }
  }

  Widget buildTimetableTiles(BuildContext context) {
    final timeTable = Consumer(
      builder: (_, ref, __) => Row(
        children: [
          Column(
            children: [
              TimetableButton(
                onPressed: ref.read(timetableProvider).tilesDisabled ? () {} : () {},
                child: const Text(''),
              ),
              TimetableButton(
                onPressed: ref.read(timetableProvider).tilesDisabled ? () {} : () {},
                child: const Text('Monday'),
              ),
              TimetableButton(
                onPressed: ref.read(timetableProvider).tilesDisabled ? () {} : () {},
                child: const Text('Tuesday'),
              ),
              TimetableButton(
                onPressed: ref.read(timetableProvider).tilesDisabled ? () {} : () {},
                child: const Text('Wednesday'),
              ),
              TimetableButton(
                onPressed: ref.read(timetableProvider).tilesDisabled ? () {} : () {},
                child: const Text('Thursday'),
              ),
              TimetableButton(
                onPressed: ref.read(timetableProvider).tilesDisabled ? () {} : () {},
                child: const Text('Friday'),
              ),
              if (state.includeSaturday)
                TimetableButton(
                  onPressed: ref.read(timetableProvider).tilesDisabled ? () {} : () {},
                  child: const Text('Saturday'),
                ),
            ],
          ),
          for (int i = 0; i < int.parse(state.columnsController.text); i++)
            Column(
              children: [
                TimetableButton(
                  onPressed: ref.read(timetableProvider).tilesDisabled
                      ? () {}
                      : () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Edit Time Range'),
                              content: Container(
                                width: 300,
                                height: 100,
                                color: Colors.transparent,
                                child: Consumer(
                                  builder: (_, ref, __) => Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      BorderlessButton(
                                        backgroundColor: Colors.green.shade100,
                                        onPressed: () async {
                                          final TimeOfDay? time = await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                            initialEntryMode: TimePickerEntryMode.dial,
                                          );
                                          if (time != null) {
                                            state = state.copyWith(
                                              timeRanges: [
                                                ...state.timeRanges.sublist(0, i),
                                                (time, state.timeRanges[i].$2),
                                                ...state.timeRanges.sublist(i + 1),
                                              ],
                                            );
                                          }
                                        },
                                        splashColor: Colors.green.shade700,
                                        label: Text(
                                            '${ref.watch(timetableProvider).timeRanges[i].$1.hour}:${ref.watch(timetableProvider).timeRanges[i].$1.minute}'),
                                      ),
                                      BorderlessButton(
                                        backgroundColor: Colors.red.shade100,
                                        onPressed: () async {
                                          final TimeOfDay? time = await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                            initialEntryMode: TimePickerEntryMode.dial,
                                          );
                                          if (time != null) {
                                            state = state.copyWith(
                                              timeRanges: [
                                                ...state.timeRanges.sublist(0, i),
                                                (state.timeRanges[i].$1, time),
                                                ...state.timeRanges.sublist(i + 1),
                                              ],
                                            );
                                          }
                                        },
                                        splashColor: Colors.red.shade700,
                                        label: Text(
                                            '${ref.watch(timetableProvider).timeRanges[i].$2.hour}:${ref.watch(timetableProvider).timeRanges[i].$2.minute}'),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                  child: AutoSizeText(
                    '${ref.watch(timetableProvider).timeRanges[i].$1.hour}:${ref.watch(timetableProvider).timeRanges[i].$1.minute} - ${ref.watch(timetableProvider).timeRanges[i].$2.hour}:${ref.watch(timetableProvider).timeRanges[i].$2.minute}',
                    maxLines: 1,
                    minFontSize: 12,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                for (int j = 0; j < int.parse(state.rowsController.text); j++)
                  TimetableButton(
                    onPressed: ref.read(timetableProvider).tilesDisabled
                        ? () {}
                        : () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                scrollable: true,
                                title: const Text('Edit Subject'),
                                content: Container(
                                  width: 300,
                                  color: Colors.transparent,
                                  child: IntrinsicHeight(
                                    child: MaterialTextFormField(
                                      controller: state.tileControllers[i][j],
                                      hintText: 'Enter Subject',
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                    child: AutoSizeText(
                      state.tileControllers[i][j].text,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      minFontSize: 12,
                    ),
                  ),
              ],
            ),
        ],
      ),
    );

    return FittedBox(
      child: timeTable,
    );
  }

  void toggleIncludeSaturday() {
    state.rowsController.text = state.includeSaturday ? '5' : '6';
    state = state.copyWith(includeSaturday: !state.includeSaturday);
  }

  Future<void> addTimetable() async {
    String userId;

    if (_authState.currentUserRole == 'student') {
      userId = (_authState.currentUser as Student).id;
    } else if (_authState.currentUserRole == 'faculty') {
      userId = (_authState.currentUser as Faculty).id;
    } else {
      userId = (_authState.currentUser as Admin).id;
    }

    final Timetable timetable = Timetable(
      creatorId: userId,
      name: state.timetableNameController.text,
      rows: int.parse(state.rowsController.text),
      columns: int.parse(state.columnsController.text),
      timeRanges: state.timeRanges,
      timetable: List.generate(
        int.parse(state.columnsController.text),
        (i) => List.generate(
          int.parse(state.rowsController.text),
          (j) => state.tileControllers[i][j].text,
        ),
      ),
    );
    if (await _api.createTimetable(timetable)) {
      loadTimetables();
    }
  }

  Future<void> deleteTimetable(Timetable timetable) async {
    if (await _api.deleteTimetableById(timetable.id!)) {
      loadTimetables();
    }
  }

  void clearControllers() {
    state = state.copyWith(
      timetableNameController: TextEditingController(),
      rowsController: TextEditingController(text: '6'),
      columnsController: TextEditingController(),
      tileControllers: [],
      timeRanges: [],
      includeSaturday: true,
    );
  }
}
