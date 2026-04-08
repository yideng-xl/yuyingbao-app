import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/database_providers.dart';
import '../../../repositories/knowledge_repository.dart';

final selectedAgeRangeProvider = StateProvider<String?>((ref) => null);
final searchQueryProvider = StateProvider<String>((ref) => '');

final knowledgeListProvider = FutureProvider<List<KnowledgeItem>>((ref) async {
  final repo = ref.watch(knowledgeRepositoryProvider);
  final ageRange = ref.watch(selectedAgeRangeProvider);
  final query = ref.watch(searchQueryProvider);

  if (query.isNotEmpty) return repo.search(query);
  if (ageRange != null) return repo.getByAgeRange(ageRange);
  return repo.getAll();
});
