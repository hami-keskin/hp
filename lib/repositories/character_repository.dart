import 'package:dio/dio.dart';
import '../models/character.dart';

class CharacterRepository {
  final Dio _dio;
  final String endpoint;

  CharacterRepository(this._dio, {required this.endpoint});

  Future<List<Character>> fetchPage({
    required int page,
    required int limit,
  }) async {
    final resp = await _dio.get(endpoint);
    final all = (resp.data as List)
        .map((j) => Character.fromJson(j));

    final pageItems = all
        .skip(page * limit)
        .take(limit)
        .toList();

    return pageItems;
  }
}
