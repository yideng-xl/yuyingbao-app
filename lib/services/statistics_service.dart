import 'dart:convert';
import 'package:flutter/services.dart';
import '../repositories/record_repository.dart';

class StatisticsService {
  /// Aggregates amountMl by day for bottle/formula/water records.
  /// Returns a map of date (time zeroed) to total ml.
  static Map<DateTime, double> dailyFeedingTotals(List<BabyRecord> records) {
    final result = <DateTime, double>{};
    for (final record in records) {
      final type = record.type;
      if (type != 'bottle' && type != 'formula' && type != 'water') continue;
      final amount = record.amountMl;
      if (amount == null || amount <= 0) continue;
      final day = DateTime(
        record.happenedAt.year,
        record.happenedAt.month,
        record.happenedAt.day,
      );
      result[day] = (result[day] ?? 0.0) + amount;
    }
    return result;
  }

  /// Counts feeding records by type: breastfeeding, bottle, formula.
  static Map<String, int> feedingTypeBreakdown(List<BabyRecord> records) {
    final result = <String, int>{};
    const feedingTypes = {'breastfeeding', 'bottle', 'formula'};
    for (final record in records) {
      if (!feedingTypes.contains(record.type)) continue;
      result[record.type] = (result[record.type] ?? 0) + 1;
    }
    return result;
  }

  /// Returns a percentile band label for a given value.
  /// Possible return values: less-than-P3, P3-P15, P15-P50, P50, P50-P85, P85-P97, greater-than-P97
  static String findPercentile({
    required double value,
    required double p3,
    required double p15,
    required double p50,
    required double p85,
    required double p97,
  }) {
    if (value < p3) return '<P3';
    if (value < p15) return 'P3-P15';
    if (value < p50) return 'P15-P50';
    if (value == p50) return 'P50';
    if (value <= p85) return 'P50-P85';
    if (value <= p97) return 'P85-P97';
    return '>P97';
  }

  /// Loads WHO growth data JSON from assets.
  static Future<List<Map<String, dynamic>>> loadWhoData(
      String assetPath) async {
    final jsonStr = await rootBundle.loadString(assetPath);
    final List<dynamic> decoded = jsonDecode(jsonStr);
    return decoded.cast<Map<String, dynamic>>();
  }
}
