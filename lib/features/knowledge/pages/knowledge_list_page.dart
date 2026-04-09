import 'package:flutter/material.dart';
import 'package:yuyingbao/l10n/generated/app_localizations.dart';
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

  List<(String, String?)> _ageRanges = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final s = S.of(context);
    _ageRanges = [
      (s.knowledgeAll, null),
      (s.ageRange0To6, '0-6'),
      (s.ageRange6To12, '6-12'),
      (s.ageRange12To24, '12-24'),
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final selectedAgeRange = ref.watch(selectedAgeRangeProvider);
    final knowledgeAsync = ref.watch(knowledgeListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(s.knowledgeTitle),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: s.searchArticles,
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
                  return Center(child: Text(s.noArticles));
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
              error: (e, _) => Center(child: Text(s.recordLoadFailed(e.toString()))),
            ),
          ),
        ],
      ),
    );
  }
}
