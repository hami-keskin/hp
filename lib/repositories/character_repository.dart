import 'package:dio/dio.dart';
import '../models/character.dart';

class CharacterRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://hp-api.onrender.com'));

  Future<List<Character>> fetchPage({required int page, required int limit}) async {
    final resp = await _dio.get(
      '/api/characters',
      queryParameters: {'page': page, 'limit': limit},
    );
    return (resp.data as List)
        .map((json) => Character.fromJson(json))
        .toList();
  }
}
