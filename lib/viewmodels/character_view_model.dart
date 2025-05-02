import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/character.dart';
import '../repositories/character_repository.dart';

final characterRepositoryProvider = Provider<CharacterRepository>(
      (ref) => CharacterRepository(),
);

final characterViewModelProvider = StateNotifierProvider<
    CharacterViewModel,
    AsyncValue<List<Character>>
>((ref) {
  final repo = ref.watch(characterRepositoryProvider);
  return CharacterViewModel(repo);
});

class CharacterViewModel extends StateNotifier<AsyncValue<List<Character>>> {
  final CharacterRepository _repo;
  static const int _pageSize = 20;

  int _currentPage = 0;
  bool _isLoading = false;
  bool _hasMore = true;
  final List<Character> _items = [];

  CharacterViewModel(this._repo) : super(const AsyncValue.loading()) {
    loadMore();
  }

  Future<void> loadMore() async {
    if (_isLoading || !_hasMore) return;
    _isLoading = true;
    try {
      final newItems = await _repo.fetchPage(
        page: _currentPage,
        limit: _pageSize,
      );
      _currentPage++;
      _items.addAll(newItems);
      _hasMore = newItems.length == _pageSize;
      state = AsyncValue.data(List.unmodifiable(_items));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    } finally {
      _isLoading = false;
    }
  }

  bool get hasMore => _hasMore;
}
