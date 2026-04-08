import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../record/providers/record_providers.dart';
import '../../../core/constants/enums.dart';

class DailySummary {
  final int feedingCount;
  final double totalMilkMl;
  final int diaperCount;
  final double waterMl;

  const DailySummary({
    this.feedingCount = 0,
    this.totalMilkMl = 0,
    this.diaperCount = 0,
    this.waterMl = 0,
  });
}

final dailySummaryProvider = Provider<DailySummary>((ref) {
  final recordsAsync = ref.watch(todayRecordsProvider);

  return recordsAsync.when(
    data: (records) {
      int feedingCount = 0;
      double totalMilkMl = 0;
      int diaperCount = 0;
      double waterMl = 0;

      for (final record in records) {
        final type = RecordType.values.firstWhere(
          (e) => e.name == record.type,
          orElse: () => RecordType.breastfeeding,
        );

        switch (type) {
          case RecordType.breastfeeding:
            feedingCount++;
          case RecordType.bottle:
          case RecordType.formula:
            feedingCount++;
            if (record.amountMl != null) totalMilkMl += record.amountMl!;
          case RecordType.diaper:
            diaperCount++;
          case RecordType.water:
            if (record.amountMl != null) waterMl += record.amountMl!;
          default:
            break;
        }
      }

      return DailySummary(
        feedingCount: feedingCount,
        totalMilkMl: totalMilkMl,
        diaperCount: diaperCount,
        waterMl: waterMl,
      );
    },
    loading: () => const DailySummary(),
    error: (_, __) => const DailySummary(),
  );
});
