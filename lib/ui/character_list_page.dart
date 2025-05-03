import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../utils/error_messages.dart';
import '../viewmodels/character_view_model.dart';
import 'character_detail_page.dart';

class CharacterListPage extends HookConsumerWidget {
  const CharacterListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(characterViewModelProvider);
    final vm = ref.read(characterViewModelProvider.notifier);
    final ctrl = useScrollController();
    final query = useState('');

    useEffect(() {
      void onScroll() {
        if (ctrl.position.pixels >= ctrl.position.maxScrollExtent - 100 &&
            vm.hasMore &&
            query.value.isEmpty) {
          vm.loadMore();
        }
      }
      ctrl.addListener(onScroll);
      return () => ctrl.removeListener(onScroll);
    }, [ctrl, vm, query.value]);

    return Scaffold(
      appBar: AppBar(title: const Text('Harry Potter Karakterleri')),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Text(
            mapDioErrorToMessage(e),
            textAlign: TextAlign.center,
          ),
        ),
        data: (list) {
          final filtered = query.value.isEmpty
              ? list
              : list
              .where((c) => c.name.toLowerCase().contains(query.value.toLowerCase()))
              .toList();
          final itemCount = filtered.length + (vm.hasMore && query.value.isEmpty ? 1 : 0);

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Ara...',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (v) => query.value = v,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: ctrl,
                  itemCount: itemCount,
                  itemBuilder: (_, i) {
                    if (i == filtered.length) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    final c = filtered[i];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: c.image.isNotEmpty ? NetworkImage(c.image) : null,
                        child: c.image.isEmpty ? const Icon(Icons.person) : null,
                      ),
                      title: Text(c.name),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => CharacterDetailPage(character: c)),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
