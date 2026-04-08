import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yuyingbao/core/database/app_database.dart';
import 'package:yuyingbao/repositories/baby_repository.dart';
import 'package:yuyingbao/repositories/record_repository.dart';

void main() {
  late AppDatabase db;
  late BabyRepository babyRepo;
  late RecordRepository recordRepo;

  const testBabyId = 'baby-001';

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    babyRepo = BabyRepository(db);
    recordRepo = RecordRepository(db);

    // Every test needs at least one baby due to FK constraint
    await babyRepo.addBaby(
      id: testBabyId,
      name: 'Test Baby',
      gender: 'male',
      birthDate: DateTime(2024, 1, 1),
    );
  });

  tearDown(() async {
    await db.close();
  });

  group('RecordRepository', () {
    test('addRecord and getRecordsByDate returns the record', () async {
      final day = DateTime(2024, 6, 15);
      await recordRepo.addRecord(
        id: 'r1',
        babyId: testBabyId,
        type: 'breastfeed',
        happenedAt: day,
        durationMin: 20,
        breastfeedingSide: 'left',
      );

      final records = await recordRepo.getRecordsByDate(
        babyId: testBabyId,
        start: DateTime(2024, 6, 15),
        end: DateTime(2024, 6, 15, 23, 59, 59),
      );

      expect(records, hasLength(1));
      expect(records.first.id, 'r1');
      expect(records.first.type, 'breastfeed');
      expect(records.first.durationMin, 20);
      expect(records.first.breastfeedingSide, 'left');
    });

    test('getRecordsByDate is ordered by happenedAt DESC', () async {
      final base = DateTime(2024, 6, 15);
      await recordRepo.addRecord(
        id: 'r1',
        babyId: testBabyId,
        type: 'feed',
        happenedAt: base,
      );
      await recordRepo.addRecord(
        id: 'r2',
        babyId: testBabyId,
        type: 'feed',
        happenedAt: base.add(const Duration(hours: 2)),
      );
      await recordRepo.addRecord(
        id: 'r3',
        babyId: testBabyId,
        type: 'feed',
        happenedAt: base.add(const Duration(hours: 1)),
      );

      final records = await recordRepo.getRecordsByDate(
        babyId: testBabyId,
        start: DateTime(2024, 6, 15),
        end: DateTime(2024, 6, 15, 23, 59, 59),
      );

      expect(records.map((r) => r.id).toList(), ['r2', 'r3', 'r1']);
    });

    test('getRecordsByType filters by type', () async {
      final day = DateTime(2024, 6, 15, 10);
      await recordRepo.addRecord(
        id: 'r1',
        babyId: testBabyId,
        type: 'breastfeed',
        happenedAt: day,
      );
      await recordRepo.addRecord(
        id: 'r2',
        babyId: testBabyId,
        type: 'diaper',
        happenedAt: day.add(const Duration(hours: 1)),
      );
      await recordRepo.addRecord(
        id: 'r3',
        babyId: testBabyId,
        type: 'breastfeed',
        happenedAt: day.add(const Duration(hours: 2)),
      );

      final breastfeedRecords = await recordRepo.getRecordsByType(
        babyId: testBabyId,
        type: 'breastfeed',
        start: DateTime(2024, 6, 15),
        end: DateTime(2024, 6, 15, 23, 59, 59),
      );

      expect(breastfeedRecords, hasLength(2));
      expect(breastfeedRecords.every((r) => r.type == 'breastfeed'), isTrue);
    });

    test('deleteRecord removes the record', () async {
      final day = DateTime(2024, 6, 15, 10);
      await recordRepo.addRecord(
        id: 'r1',
        babyId: testBabyId,
        type: 'feed',
        happenedAt: day,
      );
      await recordRepo.addRecord(
        id: 'r2',
        babyId: testBabyId,
        type: 'feed',
        happenedAt: day.add(const Duration(hours: 1)),
      );

      await recordRepo.deleteRecord('r1');

      final records = await recordRepo.getAllRecords(testBabyId);
      expect(records, hasLength(1));
      expect(records.first.id, 'r2');
    });

    test('watchRecordsByDate emits updates when record is added', () async {
      final start = DateTime(2024, 6, 15);
      final end = DateTime(2024, 6, 15, 23, 59, 59);

      final stream = recordRepo.watchRecordsByDate(
        babyId: testBabyId,
        start: start,
        end: end,
      );

      final future = expectLater(
        stream,
        emitsInOrder([
          hasLength(0),
          hasLength(1),
        ]),
      );

      // Yield control so the stream emits the initial empty state
      await Future<void>.delayed(Duration.zero);

      await recordRepo.addRecord(
        id: 'r1',
        babyId: testBabyId,
        type: 'feed',
        happenedAt: DateTime(2024, 6, 15, 12),
      );

      await future;
    });

    test('getRecentRecords limits results to specified count', () async {
      // Insert 15 records with different times
      for (var i = 0; i < 15; i++) {
        await recordRepo.addRecord(
          id: 'r${i.toString().padLeft(2, '0')}',
          babyId: testBabyId,
          type: 'feed',
          happenedAt: DateTime(2024, 6, 15, i),
        );
      }

      final recent = await recordRepo.getRecentRecords(
        babyId: testBabyId,
        limit: 10,
      );

      expect(recent, hasLength(10));
      // Most recent first (hours 14 down to 5)
      expect(recent.first.happenedAt.hour, 14);
      expect(recent.last.happenedAt.hour, 5);
    });

    test('getRecentRecords default limit is 10', () async {
      for (var i = 0; i < 12; i++) {
        await recordRepo.addRecord(
          id: 'r${i.toString().padLeft(2, '0')}',
          babyId: testBabyId,
          type: 'feed',
          happenedAt: DateTime(2024, 6, 15, i),
        );
      }

      final recent = await recordRepo.getRecentRecords(babyId: testBabyId);
      expect(recent, hasLength(10));
    });

    test('getAllRecords returns all records for a baby', () async {
      for (var i = 0; i < 5; i++) {
        await recordRepo.addRecord(
          id: 'r$i',
          babyId: testBabyId,
          type: 'feed',
          happenedAt: DateTime(2024, 6, i + 1),
        );
      }

      final all = await recordRepo.getAllRecords(testBabyId);
      expect(all, hasLength(5));
    });
  });
}
