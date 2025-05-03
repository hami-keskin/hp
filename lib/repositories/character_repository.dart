import 'package:dio/dio.dart';
import '../models/character.dart';

class CharacterRepository {
  final Dio _dio;

  CharacterRepository(this._dio);

  Future<List<Character>> fetchPage({
    required int page,
    required int limit,
  }) async {
    final resp = await _dio.get('/api/characters');
    final all = (resp.data as List)
        .map((j) => Character.fromJson(j));

    // skip ve take ile sayfalamayı tek satırda yapıyoruz
    final pageItems = all
        .skip(page * limit)
        .take(limit)
        .toList();

    return pageItems;
  }
}
