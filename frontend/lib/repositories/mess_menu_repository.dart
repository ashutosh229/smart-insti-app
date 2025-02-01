import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:smart_insti_app/models/mess_menu.dart';

final messMenuRepositoryProvider = Provider<MessMenuRepository>((ref) => MessMenuRepository());

class MessMenuRepository{

  final _client = Dio(
    BaseOptions(
      baseUrl: dotenv.env['BACKEND_DOMAIN']!,
    ),
  );

  final Logger _logger = Logger();

 Future<List<MessMenu>> getMessMenu() async {
    try {
      final response = await _client.get('/mess-menus');
      List<MessMenu> messMenus = (response.data as List).map((e) => MessMenu.fromJson(e)).toList();
      return messMenus;
    } catch (e) {
      _logger.e(e);
      return [];
    }
  }

  Future<bool> addMessMenu(MessMenu messMenu) async {
    try {
      final response = await _client.post('/mess-menus', data: messMenu.toJson());
      _logger.i(response.data);
      return true;
    } catch (e) {
      _logger.e(e);
      return false;
    }
  }

  Future<bool> updateMessMenu(String menuId, MessMenu messMenu) async {
    try {
      final response = await _client.put('/mess-menu/$menuId', data: messMenu.toJson());
      _logger.i(response.data);
      return true;
    } catch (e) {
      _logger.e(e);
      return false;
    }
  }

  Future<bool> deleteMessMenu(String id) async {
    try {
      final response = await _client.delete('/mess-menu/$id');
      _logger.i(response.data);
      return true;
    } catch (e) {
      _logger.e(e);
      return false;
    }
  }
}