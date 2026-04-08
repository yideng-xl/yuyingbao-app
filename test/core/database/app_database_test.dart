import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yuyingbao/core/database/app_database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() => db.close());

  group('Babies table', () {
    test('insert and read a baby', () async {
      await db.into(db.babies).insert(BabiesCompanion.insert(
        id: 'baby-1',
        name: '小明',
        gender: 'male',
        birthDate: DateTime(2026, 1, 1),
      ));

      final results = await db.select(db.babies).get();
      expect(results, hasLength(1));
      expect(results.first.name, '小明');
      expect(results.first.gender, 'male');
    });

    test('delete a baby', () async {
      await db.into(db.babies).insert(BabiesCompanion.insert(
        id: 'baby-1',
        name: '小明',
        gender: 'male',
        birthDate: DateTime(2026, 1, 1),
      ));

      await (db.delete(db.babies)..where((t) => t.id.equals('baby-1'))).go();
      final results = await db.select(db.babies).get();
      expect(results, isEmpty);
    });
  });

  group('Records table', () {
    test('insert a feeding record', () async {
      await db.into(db.babies).insert(BabiesCompanion.insert(
        id: 'baby-1',
        name: '小明',
        gender: 'male',
        birthDate: DateTime(2026, 1, 1),
      ));

      await db.into(db.records).insert(RecordsCompanion.insert(
        id: 'rec-1',
        babyId: 'baby-1',
        type: 'breastfeeding',
        happenedAt: DateTime(2026, 4, 8, 10, 0),
        durationMin: const Value(15),
        breastfeedingSide: const Value('left'),
      ));

      final results = await db.select(db.records).get();
      expect(results, hasLength(1));
      expect(results.first.type, 'breastfeeding');
      expect(results.first.durationMin, 15);
    });

    test('query records by babyId and date range', () async {
      await db.into(db.babies).insert(BabiesCompanion.insert(
        id: 'baby-1',
        name: '小明',
        gender: 'male',
        birthDate: DateTime(2026, 1, 1),
      ));

      await db.into(db.records).insert(RecordsCompanion.insert(
        id: 'rec-1',
        babyId: 'baby-1',
        type: 'bottle',
        happenedAt: DateTime(2026, 4, 7, 10, 0),
        amountMl: const Value(120),
      ));
      await db.into(db.records).insert(RecordsCompanion.insert(
        id: 'rec-2',
        babyId: 'baby-1',
        type: 'bottle',
        happenedAt: DateTime(2026, 4, 8, 10, 0),
        amountMl: const Value(150),
      ));

      final query = db.select(db.records)
        ..where((r) => r.babyId.equals('baby-1'))
        ..where((r) => r.happenedAt.isBiggerOrEqualValue(DateTime(2026, 4, 8)))
        ..where((r) => r.happenedAt.isSmallerThanValue(DateTime(2026, 4, 9)));

      final results = await query.get();
      expect(results, hasLength(1));
      expect(results.first.amountMl, 150);
    });
  });

  group('Settings table', () {
    test('insert and upsert setting', () async {
      await db.into(db.settings).insert(SettingsCompanion.insert(
        key: 'feedingInterval',
        value: '180',
      ));

      var results = await db.select(db.settings).get();
      expect(results.first.value, '180');

      await db.into(db.settings).insertOnConflictUpdate(SettingsCompanion.insert(
        key: 'feedingInterval',
        value: '120',
      ));

      results = await db.select(db.settings).get();
      expect(results, hasLength(1));
      expect(results.first.value, '120');
    });
  });
}
