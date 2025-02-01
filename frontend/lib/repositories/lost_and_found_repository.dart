import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:smart_insti_app/constants/dummy_entries.dart';
import 'package:smart_insti_app/models/lost_and_found_item.dart';

final lostAndFoundRepositoryProvider = Provider<LostAndFoundRepository>((_) => LostAndFoundRepository());

class LostAndFoundRepository {
  final _client = Dio(
    BaseOptions(
      baseUrl: dotenv.env['BACKEND_DOMAIN']!,
      headers: {
        "Content-Type": "multipart/form-data",
      },
    ),
  );

  final Logger _logger = Logger();

  Future<List<LostAndFoundItem>> lostAndFoundItems() async {
    try {
      final response = await _client.get('/lost-and-found');
      List<LostAndFoundItem> items = [];
      for (var item in response.data) {
        items.add(LostAndFoundItem.fromJson(item));
      }
      return items;
    } catch (e) {
      Logger().e(e);
      return DummyLostAndFound.lostAndFoundItems;
    }
  }

  Future<bool> deleteLostAndFoundItem(String id) async {
    try {
      final response = await _client.delete('/lost-and-found-item/$id');
      Logger().i(response.data);
      return true;
    } catch (e) {
      Logger().e(e);
      return false;
    }
  }

  Future<bool> addLostAndFoundItem(LostAndFoundItem item) async {
    try {
      String? fileName = item.imagePath?.split('/').last;
      FormData formData = FormData.fromMap(
        {
          "name": item.name,
          "lastSeenLocation": item.lastSeenLocation,
          "description": item.description,
          "contactNumber": item.contactNumber,
          "isLost": item.isLost,
          "listerId": item.listerId,
          "image": item.imagePath != null
              ? await MultipartFile.fromFile(
                  item.imagePath!,
                  filename: fileName,
                )
              : null,
        },
      );
      final response = await _client.post('/lost-and-found', data: formData);
      Logger().i(response.data);
      return true;
    } catch (e) {
      Logger().e(e);
      return false;
    }
  }
}
