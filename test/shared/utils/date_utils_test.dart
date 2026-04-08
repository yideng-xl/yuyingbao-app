import 'package:flutter_test/flutter_test.dart';
import 'package:yuyingbao/shared/utils/date_utils.dart';

void main() {
  group('formatDate', () {
    test('formats date as yyyy-MM-dd', () {
      final date = DateTime(2026, 4, 8);
      expect(formatDate(date), '2026-04-08');
    });
  });

  group('formatTime', () {
    test('formats time as HH:mm', () {
      final date = DateTime(2026, 4, 8, 14, 30);
      expect(formatTime(date), '14:30');
    });
  });

  group('formatRelativeDate', () {
    test('returns 今天 for today', () {
      expect(formatRelativeDate(DateTime.now()), '今天');
    });

    test('returns 昨天 for yesterday', () {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      expect(formatRelativeDate(yesterday), '昨天');
    });
  });

  group('startOfDay / endOfDay', () {
    test('startOfDay returns midnight', () {
      final result = startOfDay(DateTime(2026, 4, 8, 14, 30));
      expect(result, DateTime(2026, 4, 8));
    });

    test('endOfDay returns 23:59:59.999', () {
      final result = endOfDay(DateTime(2026, 4, 8, 14, 30));
      expect(result, DateTime(2026, 4, 8, 23, 59, 59, 999));
    });
  });

  group('ageInMonths', () {
    test('calculates months difference', () {
      final now = DateTime.now();
      final sixMonthsAgo = DateTime(now.year, now.month - 6, now.day);
      expect(ageInMonths(sixMonthsAgo), 6);
    });
  });
}
