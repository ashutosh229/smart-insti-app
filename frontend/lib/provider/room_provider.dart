import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:smart_insti_app/components/borderless_button.dart';
import 'package:smart_insti_app/constants/dummy_entries.dart';
import 'package:smart_insti_app/components/menu_tile.dart';
import 'package:smart_insti_app/models/room.dart';
import 'package:smart_insti_app/provider/auth_provider.dart';
import 'dart:io';
import '../constants/constants.dart';
import '../models/admin.dart';
import '../models/faculty.dart';
import '../models/student.dart';
import '../repositories/room_repository.dart';

final roomProvider = StateNotifierProvider<RoomProvider, RoomState>((ref) => RoomProvider(ref));

class RoomState {
  final List<Room> roomList;
  final List<MenuTile> roomTiles;
  final TextEditingController searchRoomController;
  final TextEditingController roomNameController;
  final LoadingState loadingState;

  RoomState(
      {required this.roomList,
      required this.roomTiles,
      required this.searchRoomController,
      required this.roomNameController,
      required this.loadingState});

  RoomState copyWith({
    List<Room>? roomList,
    List<MenuTile>? roomTiles,
    TextEditingController? searchRoomController,
    TextEditingController? roomNameController,
    LoadingState? loadingState,
  }) {
    return RoomState(
      roomList: roomList ?? this.roomList,
      roomTiles: roomTiles ?? this.roomTiles,
      searchRoomController: searchRoomController ?? this.searchRoomController,
      roomNameController: roomNameController ?? this.roomNameController,
      loadingState: loadingState ?? this.loadingState,
    );
  }
}

class RoomProvider extends StateNotifier<RoomState> {
  RoomProvider(Ref ref)
      : _authState = ref.read(authProvider),
        _api = ref.read(roomRepositoryProvider),
        super(
          RoomState(
            roomList: DummyRooms.rooms,
            roomTiles: [],
            searchRoomController: TextEditingController(),
            roomNameController: TextEditingController(),
            loadingState: LoadingState.progress,
          ),
        ) {
    loadRooms();
  }

  final RoomRepository _api;
  final Logger _logger = Logger();
  final AuthState _authState;

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

  void addRoom() {
    final newState = state.copyWith(
      roomList: [
        Room(name: state.roomNameController.text),
        ...state.roomList,
      ],
      roomNameController: TextEditingController(),
    );
    state = newState;
    _logger.i("Added room: ${state.roomNameController.text}");
  }

  Future<void> loadRooms() async {
    final rooms = await _api.getRooms();
    //   _api.getOccupants();
    final newState = state.copyWith(roomList: rooms, loadingState: LoadingState.success);
    state = newState;
  }

  Future<void> reserveRoom(Room room) async {
    String userId;
    String userName;

    if (_authState.currentUserRole == 'student') {
      userId = (_authState.currentUser as Student).id;
      userName = (_authState.currentUser as Student).name;
    } else if (_authState.currentUserRole == 'faculty') {
      userId = (_authState.currentUser as Faculty).id;
      userName = (_authState.currentUser as Faculty).name;
    } else if (_authState.currentUserRole == 'admin') {
      userId = (_authState.currentUser as Admin).id;
      userName = (_authState.currentUser as Admin).name;
    } else {
      return;
    }

    state = state.copyWith(loadingState: LoadingState.progress);
    if (await _api.reserveRoom(room.id!, userId, userName)) {
      loadRooms();
    } else {
      state = state.copyWith(loadingState: LoadingState.error);
    }
  }

  Future<void> vacateRoom(Room room) async {
    state = state.copyWith(loadingState: LoadingState.progress);

    if (await _api.vacateRoom(room.id!)) {
      loadRooms();
    } else {
      state = state.copyWith(loadingState: LoadingState.error);
    }
  }

  void buildRoomTiles(BuildContext context) async {
    final roomTiles = <MenuTile>[];
    for (Room room in state.roomList) {
      roomTiles.add(
        MenuTile(
          title: room.name,
          onTap: () => showDialog(
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
                    Text(room.name),
                    const SizedBox(height: 20),

                    /// TODO : Add code to edit room

                    const Text("Room editing will be added in future"),
                    const SizedBox(height: 20),
                    BorderlessButton(
                      onPressed: () {
                        removeRoom(room);
                        buildRoomTiles(context);
                        context.pop();
                      },
                      label: const Text("Remove"),
                      backgroundColor: Colors.red.shade100,
                      splashColor: Colors.redAccent,
                    )
                  ],
                ),
              ),
            ),
          ),
          icon: Icons.add,
          primaryColor: Colors.grey.shade200,
          secondaryColor: Colors.grey.shade300,
        ),
      );
    }
    String query = state.searchRoomController.text;
    state = state.copyWith(
      roomTiles: roomTiles.where((element) => element.title.toLowerCase().contains(query.toLowerCase())).toList(),
    );
    _logger.i("Built room tiles : ${roomTiles.length}");
  }

  void removeRoom(Room room) {
    final newState = state.copyWith(
      roomList: [
        ...state.roomList.where((element) => element.name != room.name),
      ],
    );
    state = newState;
    _logger.i("Removed room: ${room.name}");
  }
}
