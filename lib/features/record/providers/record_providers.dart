import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/database_providers.dart';
import '../../../repositories/record_repository.dart';
import '../../../shared/utils/date_utils.dart';
import '../../../shared/utils/uuid_utils.dart';
import '../../baby/providers/baby_providers.dart';

/// The date currently being viewed. Defaults to today.
final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

/// Stream of records for today for the selected baby.
final todayRecordsProvider = StreamProvider<List<BabyRecord>>((ref) {
  final baby = ref.watch(selectedBabyProvider);
  if (baby == null) return Stream.value([]);

  final now = DateTime.now();
  return ref.watch(recordRepositoryProvider).watchRecordsByDate(
        babyId: baby.id,
        start: startOfDay(now),
        end: endOfDay(now),
      );
});

/// Stream of records for the selected date for the selected baby.
final selectedDateRecordsProvider = StreamProvider<List<BabyRecord>>((ref) {
  final baby = ref.watch(selectedBabyProvider);
  if (baby == null) return Stream.value([]);

  final date = ref.watch(selectedDateProvider);
  return ref.watch(recordRepositoryProvider).watchRecordsByDate(
        babyId: baby.id,
        start: startOfDay(date),
        end: endOfDay(date),
      );
});

/// Future of the last 10 records for the selected baby.
/// Watches todayRecordsProvider to auto-refresh when records change.
final recentRecordsProvider = FutureProvider<List<BabyRecord>>((ref) {
  final baby = ref.watch(selectedBabyProvider);
  if (baby == null) return Future.value([]);

  // Watch the stream so we refresh when records are added/deleted
  ref.watch(todayRecordsProvider);

  return ref.watch(recordRepositoryProvider).getRecentRecords(
        babyId: baby.id,
        limit: 10,
      );
});

/// Returns a function that adds a record for the currently selected baby.
final addRecordProvider = Provider<
    Future<void> Function({
      required String type,
      required DateTime happenedAt,
      int? durationMin,
      double? amountMl,
      String? breastfeedingSide,
      String? solidType,
      String? solidIngredients,
      String? solidBrand,
      String? diaperTexture,
      String? diaperColor,
      bool? hasUrine,
      double? heightCm,
      double? weightKg,
      String? nutritionTypes,
      String? note,
    })>((ref) {
  return ({
    required String type,
    required DateTime happenedAt,
    int? durationMin,
    double? amountMl,
    String? breastfeedingSide,
    String? solidType,
    String? solidIngredients,
    String? solidBrand,
    String? diaperTexture,
    String? diaperColor,
    bool? hasUrine,
    double? heightCm,
    double? weightKg,
    String? nutritionTypes,
    String? note,
  }) async {
    final baby = ref.read(selectedBabyProvider);
    if (baby == null) throw StateError('No baby selected');

    final repo = ref.read(recordRepositoryProvider);
    await repo.addRecord(
      id: generateId(),
      babyId: baby.id,
      type: type,
      happenedAt: happenedAt,
      durationMin: durationMin,
      amountMl: amountMl,
      breastfeedingSide: breastfeedingSide,
      solidType: solidType,
      solidIngredients: solidIngredients,
      solidBrand: solidBrand,
      diaperTexture: diaperTexture,
      diaperColor: diaperColor,
      hasUrine: hasUrine,
      heightCm: heightCm,
      weightKg: weightKg,
      nutritionTypes: nutritionTypes,
      note: note,
    );
  };
});
