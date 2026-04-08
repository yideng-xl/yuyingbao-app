import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yuyingbao/core/database/app_database.dart';
import 'package:yuyingbao/repositories/baby_repository.dart';
import 'package:yuyingbao/repositories/record_repository.dart';
import 'package:yuyingbao/services/statistics_service.dart';

void main() {
  late AppDatabase db;
  late BabyRepository babyRepo;
  late RecordRepository recordRepo;

  const testBabyId = 'baby-stats-001';

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    babyRepo = BabyRepository(db);
    recordRepo = RecordRepository(db);

    await babyRepo.addBaby(
      id: testBabyId,
      name: 'Stats Baby',
      gender: 'male',
      birthDate: DateTime(2024, 1, 1),
    );
  });

  tearDown(() async {
    await db.close();
  });

  group('StatisticsService.dailyFeedingTotals', () {
    test('aggregates bottle amountMl by day', () async {
      final day1 = DateTime(2024, 6, 15, 8, 0);
      final day1b = DateTime(2024, 6, 15, 12, 0);
      final day2 = DateTime(2024, 6, 16, 9, 0);

      await recordRepo.addRecord(
        id: 'r1',
        babyId: testBabyId,
        type: 'bottle',
        happenedAt: day1,
        amountMl: 120.0,
      );
      await recordRepo.addRecord(
        id: 'r2',
        babyId: testBabyId,
        type: 'bottle',
        happenedAt: day1b,
        amountMl: 80.0,
      );
      await recordRepo.addRecord(
        id: 'r3',
        babyId: testBabyId,
        type: 'formula',
        happenedAt: day2,
        amountMl: 150.0,
      );
      // breastfeeding should be excluded
      await recordRepo.addRecord(
        id: 'r4',
        babyId: testBabyId,
        type: 'breastfeeding',
        happenedAt: day1,
        durationMin: 20,
      );

      final records = await recordRepo.getAllRecords(testBabyId);
      final totals = StatisticsService.dailyFeedingTotals(records);

      final key1 = DateTime(2024, 6, 15);
      final key2 = DateTime(2024, 6, 16);

      expect(totals[key1], closeTo(200.0, 0.001));
      expect(totals[key2], closeTo(150.0, 0.001));
      // breastfeeding not included
      expect(totals.length, 2);
    });

    test('returns empty map when no volume records', () async {
      await recordRepo.addRecord(
        id: 'r5',
        babyId: testBabyId,
        type: 'breastfeeding',
        happenedAt: DateTime(2024, 6, 15),
        durationMin: 15,
      );
      final records = await recordRepo.getAllRecords(testBabyId);
      final totals = StatisticsService.dailyFeedingTotals(records);
      expect(totals, isEmpty);
    });

    test('ignores records with null amountMl', () async {
      await recordRepo.addRecord(
        id: 'r6',
        babyId: testBabyId,
        type: 'bottle',
        happenedAt: DateTime(2024, 6, 15),
        // amountMl not set
      );
      final records = await recordRepo.getAllRecords(testBabyId);
      final totals = StatisticsService.dailyFeedingTotals(records);
      expect(totals, isEmpty);
    });
  });

  group('StatisticsService.feedingTypeBreakdown', () {
    test('counts breastfeeding, bottle, formula separately', () async {
      await recordRepo.addRecord(
        id: 'f1',
        babyId: testBabyId,
        type: 'breastfeeding',
        happenedAt: DateTime(2024, 6, 15),
        durationMin: 10,
      );
      await recordRepo.addRecord(
        id: 'f2',
        babyId: testBabyId,
        type: 'breastfeeding',
        happenedAt: DateTime(2024, 6, 15, 3),
        durationMin: 10,
      );
      await recordRepo.addRecord(
        id: 'f3',
        babyId: testBabyId,
        type: 'bottle',
        happenedAt: DateTime(2024, 6, 15, 6),
        amountMl: 100,
      );
      await recordRepo.addRecord(
        id: 'f4',
        babyId: testBabyId,
        type: 'formula',
        happenedAt: DateTime(2024, 6, 15, 9),
        amountMl: 120,
      );
      // diaper should not appear
      await recordRepo.addRecord(
        id: 'f5',
        babyId: testBabyId,
        type: 'diaper',
        happenedAt: DateTime(2024, 6, 15, 10),
      );

      final records = await recordRepo.getAllRecords(testBabyId);
      final breakdown = StatisticsService.feedingTypeBreakdown(records);

      expect(breakdown['breastfeeding'], 2);
      expect(breakdown['bottle'], 1);
      expect(breakdown['formula'], 1);
      expect(breakdown.containsKey('diaper'), isFalse);
    });

    test('returns empty map when no feeding records', () async {
      await recordRepo.addRecord(
        id: 'f6',
        babyId: testBabyId,
        type: 'diaper',
        happenedAt: DateTime(2024, 6, 15),
      );
      final records = await recordRepo.getAllRecords(testBabyId);
      final breakdown = StatisticsService.feedingTypeBreakdown(records);
      expect(breakdown, isEmpty);
    });
  });

  group('StatisticsService.findPercentile', () {
    const p3 = 5.0;
    const p15 = 6.0;
    const p50 = 8.0;
    const p85 = 10.0;
    const p97 = 12.0;

    test('below P3', () {
      expect(
        StatisticsService.findPercentile(
          value: 4.0,
          p3: p3,
          p15: p15,
          p50: p50,
          p85: p85,
          p97: p97,
        ),
        '<P3',
      );
    });

    test('between P3 and P15', () {
      expect(
        StatisticsService.findPercentile(
          value: 5.5,
          p3: p3,
          p15: p15,
          p50: p50,
          p85: p85,
          p97: p97,
        ),
        'P3-P15',
      );
    });

    test('between P15 and P50', () {
      expect(
        StatisticsService.findPercentile(
          value: 7.0,
          p3: p3,
          p15: p15,
          p50: p50,
          p85: p85,
          p97: p97,
        ),
        'P15-P50',
      );
    });

    test('exactly P50', () {
      expect(
        StatisticsService.findPercentile(
          value: 8.0,
          p3: p3,
          p15: p15,
          p50: p50,
          p85: p85,
          p97: p97,
        ),
        'P50',
      );
    });

    test('between P50 and P85', () {
      expect(
        StatisticsService.findPercentile(
          value: 9.0,
          p3: p3,
          p15: p15,
          p50: p50,
          p85: p85,
          p97: p97,
        ),
        'P50-P85',
      );
    });

    test('between P85 and P97', () {
      expect(
        StatisticsService.findPercentile(
          value: 11.0,
          p3: p3,
          p15: p15,
          p50: p50,
          p85: p85,
          p97: p97,
        ),
        'P85-P97',
      );
    });

    test('above P97', () {
      expect(
        StatisticsService.findPercentile(
          value: 13.0,
          p3: p3,
          p15: p15,
          p50: p50,
          p85: p85,
          p97: p97,
        ),
        '>P97',
      );
    });
  });
}
