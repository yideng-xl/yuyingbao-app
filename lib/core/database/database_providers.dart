import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_database.dart';
import '../../repositories/baby_repository.dart';
import '../../repositories/record_repository.dart';
import '../../repositories/settings_repository.dart';
import '../../repositories/knowledge_repository.dart';
import '../../core/l10n/locale_provider.dart';

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

/// Resolves the effective language code from the locale provider.
/// Falls back to platform locale, then to 'zh'.
final _effectiveLangCodeProvider = Provider<String>((ref) {
  final locale = ref.watch(localeProvider);
  if (locale != null) return locale.languageCode;
  final platformCode = PlatformDispatcher.instance.locale.languageCode;
  const supported = {'zh', 'en', 'ja', 'ko'};
  return supported.contains(platformCode) ? platformCode : 'zh';
});

final knowledgeRepositoryProvider = Provider<KnowledgeRepository>((ref) {
  final langCode = ref.watch(_effectiveLangCodeProvider);
  return KnowledgeRepository(langCode: langCode);
});
