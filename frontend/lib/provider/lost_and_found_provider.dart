import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:smart_insti_app/constants/dummy_entries.dart';
import 'package:smart_insti_app/models/lost_and_found_item.dart';
import 'package:smart_insti_app/repositories/lost_and_found_repository.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'dart:io';
import '../constants/constants.dart';
import '../models/admin.dart';
import '../models/faculty.dart';
import '../models/student.dart';
import 'auth_provider.dart';

final lostAndFoundProvider =
    StateNotifierProvider<LostAndFoundStateNotifier, LostAndFoundState>((ref) => LostAndFoundStateNotifier(ref));

class LostAndFoundState {
  final List<LostAndFoundItem> lostAndFoundItemList;
  final TextEditingController itemNameController;
  final TextEditingController itemDescriptionController;
  final TextEditingController lastSeenLocationController;
  final TextEditingController searchLostAndFoundController;
  final TextEditingController contactNumberController;
  final String listingStatus;
  final File? selectedImage;
  final LoadingState loadingState;

  LostAndFoundState({
    required this.lostAndFoundItemList,
    required this.itemNameController,
    required this.itemDescriptionController,
    required this.lastSeenLocationController,
    required this.searchLostAndFoundController,
    required this.contactNumberController,
    required this.listingStatus,
    this.selectedImage,
    required this.loadingState,
  });

  LostAndFoundState copyWith({
    List<LostAndFoundItem>? lostAndFoundItemList,
    List<File>? lostAndFoundImageList,
    TextEditingController? itemNameController,
    TextEditingController? itemDescriptionController,
    TextEditingController? lastSeenLocationController,
    TextEditingController? searchLostAndFoundController,
    TextEditingController? contactNumberController,
    String? listingStatus,
    File? selectedImage,
    LoadingState? loadingState,
  }) {
    return LostAndFoundState(
      lostAndFoundItemList: lostAndFoundItemList ?? this.lostAndFoundItemList,
      itemNameController: itemNameController ?? this.itemNameController,
      itemDescriptionController: itemDescriptionController ?? this.itemDescriptionController,
      lastSeenLocationController: lastSeenLocationController ?? this.lastSeenLocationController,
      searchLostAndFoundController: searchLostAndFoundController ?? this.searchLostAndFoundController,
      contactNumberController: contactNumberController ?? this.contactNumberController,
      listingStatus: listingStatus ?? this.listingStatus,
      selectedImage: selectedImage,
      loadingState: loadingState ?? this.loadingState,
    );
  }
}

class LostAndFoundStateNotifier extends StateNotifier<LostAndFoundState> {
  LostAndFoundStateNotifier(Ref ref)
      : _authState = ref.read(authProvider),
        _api = ref.read(lostAndFoundRepositoryProvider),
        super(
          LostAndFoundState(
            lostAndFoundItemList: [],
            itemNameController: TextEditingController(),
            itemDescriptionController: TextEditingController(),
            lastSeenLocationController: TextEditingController(),
            searchLostAndFoundController: TextEditingController(),
            contactNumberController: TextEditingController(),
            listingStatus: LostAndFoundConstants.lostState,
            selectedImage: null,
            loadingState: LoadingState.progress,
          ),
        ) {
    loadItems();
  }

  final LostAndFoundRepository _api;
  final AuthState _authState;
  final Logger _logger = Logger();

  Future<void> addItem() async {

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

    final LostAndFoundItem item = LostAndFoundItem(
      name: state.itemNameController.text,
      lastSeenLocation: state.lastSeenLocationController.text,
      imagePath: state.selectedImage?.path,
      description: state.itemDescriptionController.text,
      isLost: state.listingStatus == LostAndFoundConstants.lostState,
      listerId: userId,
      contactNumber: state.contactNumberController.text,
    );
    state = state.copyWith(loadingState: LoadingState.progress);
    if(await _api.addLostAndFoundItem(item)){
      loadItems();
    }
    else{
      state = state.copyWith(loadingState: LoadingState.error);
    }
  }

  launchCaller(String number) async {
    final url = "tel:$number";
    if (await canLaunchUrlString(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void updateListingStatus(String status) {
    state = state.copyWith(listingStatus: status);
  }

  void clearControllers() {
    state.itemNameController.clear();
    state.itemDescriptionController.clear();
    state.lastSeenLocationController.clear();
    state.contactNumberController.clear();
    state = state.copyWith(selectedImage: null);
  }

  Future<CroppedFile?> _cropImage(XFile image) {
    return ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatio: const CropAspectRatio(ratioX: 4, ratioY: 3),
      compressQuality: 100,
      compressFormat: ImageCompressFormat.jpg,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Lost and Found',
          toolbarColor: Colors.tealAccent,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true,
        ),
      ],
    );
  }

  void pickImageFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      CroppedFile? file = await _cropImage(pickedFile);
      state = state.copyWith(selectedImage: File(file!.path));
      _logger.d(file.path);
    }
  }

  void pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      CroppedFile? file = await _cropImage(pickedFile);
      state = state.copyWith(selectedImage: File(file!.path));
      _logger.d(file.path);
    }
    _logger.d(pickedFile?.path);
  }

  void resetImageSelection() {
    state = state.copyWith(selectedImage: null);
    _logger.d('Image selection reset');
  }

  void loadItems() async {
    final items = await _api.lostAndFoundItems();
    state = state.copyWith(lostAndFoundItemList: items, loadingState: LoadingState.success);
  }

  Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }

  Future<void> deleteItem(String id) async {
    state = state.copyWith(loadingState: LoadingState.progress);
    if(await _api.deleteLostAndFoundItem(id)){
        loadItems();
    }
    else{
      state = state.copyWith(loadingState: LoadingState.error);
    }
  }
}
