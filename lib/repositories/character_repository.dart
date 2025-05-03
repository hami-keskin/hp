import 'package:dio/dio.dart';
import '../models/character.dart';
import 'dart:math';

class CharacterRepository {
  final Dio _dio;
  final Map<int, List<Character>> _pageCache = {};

  CharacterRepository(this._dio);

  Future<List<Character>> fetchPage({
    required int page,
    required int limit,
  }) async {
    if (_pageCache.containsKey(page)) {
      return _pageCache[page]!;
    }

    final resp = await _dio.get('/api/characters');
    final all = (resp.data as List)
        .map((j) => Character.fromJson(j))
        .toList();

    final start = page * limit;
    if (start >= all.length) return [];

    final end = min(start + limit, all.length);
    final slice = all.sublist(start, end);

    _pageCache[page] = slice;
    return slice;
  }
}
