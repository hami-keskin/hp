import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/character.dart';
import '../repositories/character_repository.dart';

const String kApiBaseUrl = 'https://hp-api.onrender.com';
const String kCharactersEndpoint = '/api/characters';

final dioProvider = Provider<Dio>(
      (ref) => Dio(BaseOptions(baseUrl: kApiBaseUrl)),
);

final characterRepositoryProvider = Provider<CharacterRepository>(
      (ref) => CharacterRepository(
    ref.watch(dioProvider),
    endpoint: kCharactersEndpoint,
  ),
);

final characterViewModelProvider = AsyncNotifierProvider<
    CharacterViewModel,
    List<Character>
>(
      () => CharacterViewModel(),
);

class CharacterViewModel extends AsyncNotifier<List<Character>> {
  static const int _pageSize = 20;
  int _currentPage = 0;
  bool _isLoading = false;
  bool _hasMore = true;
  final List<Character> _items = [];

  CharacterRepository get _repo =>
      ref.read(characterRepositoryProvider);

  @override
  Future<List<Character>> build() async {
    final firstPage = await _repo.fetchPage(
      page: _currentPage,
      limit: _pageSize,
    );
    _currentPage++;
    _hasMore = firstPage.length == _pageSize;
    _items.addAll(firstPage);
    return List.unmodifiable(_items);
  }

  Future<void> loadMore() async {
    if (_isLoading || !_hasMore) return;
    _isLoading = true;
    try {
      final nextPage = await _repo.fetchPage(
        page: _currentPage,
        limit: _pageSize,
      );
      _currentPage++;
      _hasMore = nextPage.length == _pageSize;
      _items.addAll(nextPage);
      state = AsyncValue.data(List.unmodifiable(_items));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    } finally {
      _isLoading = false;
    }
  }

  bool get hasMore => _hasMore;
}
