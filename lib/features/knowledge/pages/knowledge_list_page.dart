import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/knowledge_providers.dart';
import '../widgets/knowledge_card.dart';
import 'knowledge_detail_page.dart';

class KnowledgeListPage extends ConsumerStatefulWidget {
  const KnowledgeListPage({super.key});

  @override
  ConsumerState<KnowledgeListPage> createState() => _KnowledgeListPageState();
}

class _KnowledgeListPageState extends ConsumerState<KnowledgeListPage> {
  final _searchController = TextEditingController();

  static const _ageRanges = [
    ('全部', null),
    ('0-6月', '0-6'),
    ('6-12月', '6-12'),
    ('12-24月', '12-24'),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedAgeRange = ref.watch(selectedAgeRangeProvider);
    final knowledgeAsync = ref.watch(knowledgeListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('育儿知识'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '搜索文章...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          ref.read(searchQueryProvider.notifier).state = '';
                        },
                      )
                    : null,
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              onChanged: (value) {
                ref.read(searchQueryProvider.notifier).state = value;
              },
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Age range filter chips
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              children: _ageRanges.map((entry) {
                final (label, value) = entry;
                final isSelected = selectedAgeRange == value;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(label),
                    selected: isSelected,
                    onSelected: (_) {
                      ref.read(selectedAgeRangeProvider.notifier).state = value;
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          // Knowledge list
          Expanded(
            child: knowledgeAsync.when(
              data: (items) {
                if (items.isEmpty) {
                  return const Center(child: Text('暂无相关文章'));
                }
                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return KnowledgeCard(
                      item: item,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => KnowledgeDetailPage(item: item),
                          ),
                        );
                      },
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('加载失败：$e')),
            ),
          ),
        ],
      ),
    );
  }
}
