import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/database_providers.dart';
import '../../../features/baby/providers/baby_providers.dart';
import '../../../repositories/record_repository.dart';
import '../../../services/statistics_service.dart';

/// Time range options for the statistics page.
enum StatsTimeRange {
  today,
  week,
  month;

  String get label {
    switch (this) {
      case StatsTimeRange.today:
        return '今天';
      case StatsTimeRange.week:
        return '近7天';
      case StatsTimeRange.month:
        return '近30天';
    }
  }
}

/// Currently selected time range on the statistics page.
final timeRangeProvider =
    StateProvider<StatsTimeRange>((ref) => StatsTimeRange.week);

/// Records for the currently selected baby and time range.
final statsRecordsProvider = FutureProvider<List<BabyRecord>>((ref) async {
  final baby = ref.watch(selectedBabyProvider);
  if (baby == null) return [];

  final range = ref.watch(timeRangeProvider);
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  final DateTime start;
  switch (range) {
    case StatsTimeRange.today:
      start = today;
    case StatsTimeRange.week:
      start = today.subtract(const Duration(days: 6));
    case StatsTimeRange.month:
      start = today.subtract(const Duration(days: 29));
  }

  final end = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
  return ref.read(recordRepositoryProvider).getRecordsByDate(
        babyId: baby.id,
        start: start,
        end: end,
      );
});

/// WHO weight data loaded by gender ('male' or 'female').
final whoWeightDataProvider =
    FutureProvider.family<List<Map<String, dynamic>>, String>((ref, gender) {
  final assetPath = gender == 'male'
      ? 'assets/who/weight_for_age_boys.json'
      : 'assets/who/weight_for_age_girls.json';
  return StatisticsService.loadWhoData(assetPath);
});

/// WHO height data loaded by gender ('male' or 'female').
final whoHeightDataProvider =
    FutureProvider.family<List<Map<String, dynamic>>, String>((ref, gender) {
  final assetPath = gender == 'male'
      ? 'assets/who/height_for_age_boys.json'
      : 'assets/who/height_for_age_girls.json';
  return StatisticsService.loadWhoData(assetPath);
});
