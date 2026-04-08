import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_database.dart';
import '../../repositories/baby_repository.dart';
import '../../repositories/record_repository.dart';
import '../../repositories/settings_repository.dart';
import '../../repositories/knowledge_repository.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

final babyRepositoryProvider = Provider<BabyRepository>((ref) {
  return BabyRepository(ref.watch(databaseProvider));
});

final recordRepositoryProvider = Provider<RecordRepository>((ref) {
  return RecordRepository(ref.watch(databaseProvider));
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepository(ref.watch(databaseProvider));
});

final knowledgeRepositoryProvider = Provider<KnowledgeRepository>((ref) {
  return KnowledgeRepository();
});
