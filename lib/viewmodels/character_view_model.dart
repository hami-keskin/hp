import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/character.dart';
import '../repositories/character_repository.dart';

final characterRepositoryProvider = Provider<CharacterRepository>(
      (ref) => CharacterRepository(),
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

  /// Repository'yi ref üzerinden okuyarak alıyoruz
  CharacterRepository get _repo => ref.read(characterRepositoryProvider);

  /// build, widget ilk yüklendiğinde çağrılır
  @override
  Future<List<Character>> build() async {
    return await _loadNextPage();
  }

  Future<List<Character>> _loadNextPage() async {
    final newItems = await _repo.fetchPage(
      page: _currentPage,
      limit: _pageSize,
    );
    _currentPage++;
    _hasMore = newItems.length == _pageSize;
    _items.addAll(newItems);
    return List.unmodifiable(_items);
  }

  Future<void> loadMore() async {
    if (_isLoading || !_hasMore) return;
    _isLoading = true;
    try {
      state = const AsyncValue.loading();
      final updated = await _loadNextPage();
      state = AsyncValue.data(updated);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    } finally {
      _isLoading = false;
    }
  }

  bool get hasMore => _hasMore;
}
