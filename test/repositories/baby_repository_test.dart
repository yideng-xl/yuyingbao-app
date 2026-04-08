import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yuyingbao/core/database/app_database.dart';
import 'package:yuyingbao/repositories/baby_repository.dart';

void main() {
  late AppDatabase db;
  late BabyRepository repo;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = BabyRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('BabyRepository', () {
    test('addBaby and getAllBabies returns the added baby', () async {
      await repo.addBaby(
        id: 'b1',
        name: 'Little One',
        gender: 'female',
        birthDate: DateTime(2024, 1, 15),
        birthHeight: 50.0,
        birthWeight: 3.2,
      );

      final babies = await repo.getAllBabies();
      expect(babies, hasLength(1));
      expect(babies.first.id, 'b1');
      expect(babies.first.name, 'Little One');
      expect(babies.first.gender, 'female');
      expect(babies.first.birthHeight, 50.0);
      expect(babies.first.birthWeight, 3.2);
    });

    test('getBabyById returns correct baby', () async {
      await repo.addBaby(
        id: 'b1',
        name: 'Baby A',
        gender: 'male',
        birthDate: DateTime(2023, 6, 1),
      );
      await repo.addBaby(
        id: 'b2',
        name: 'Baby B',
        gender: 'female',
        birthDate: DateTime(2024, 3, 10),
      );

      final baby = await repo.getBabyById('b2');
      expect(baby, isNotNull);
      expect(baby!.name, 'Baby B');
    });

    test('getBabyById returns null for unknown id', () async {
      final baby = await repo.getBabyById('nonexistent');
      expect(baby, isNull);
    });

    test('updateBaby updates specified fields', () async {
      await repo.addBaby(
        id: 'b1',
        name: 'Original Name',
        gender: 'male',
        birthDate: DateTime(2024, 1, 1),
      );

      await repo.updateBaby(id: 'b1', name: 'Updated Name', birthWeight: 4.5);

      final baby = await repo.getBabyById('b1');
      expect(baby!.name, 'Updated Name');
      expect(baby.birthWeight, 4.5);
      // gender should remain unchanged
      expect(baby.gender, 'male');
    });

    test('deleteBaby removes the baby', () async {
      await repo.addBaby(
        id: 'b1',
        name: 'To Delete',
        gender: 'male',
        birthDate: DateTime(2024, 1, 1),
      );
      await repo.addBaby(
        id: 'b2',
        name: 'To Keep',
        gender: 'female',
        birthDate: DateTime(2024, 2, 1),
      );

      await repo.deleteBaby('b1');

      final babies = await repo.getAllBabies();
      expect(babies, hasLength(1));
      expect(babies.first.id, 'b2');
    });

    test('watchAllBabies emits updates when baby is added', () async {
      final stream = repo.watchAllBabies();

      // Collect two emissions: initial empty state, then after insert
      final future = expectLater(
        stream,
        emitsInOrder([
          hasLength(0),
          hasLength(1),
        ]),
      );

      // Yield control so the stream emits the initial empty state
      await Future<void>.delayed(Duration.zero);

      // Add a baby to trigger the second emission
      await repo.addBaby(
        id: 'b1',
        name: 'Stream Baby',
        gender: 'male',
        birthDate: DateTime(2024, 1, 1),
      );

      await future;
    });
  });
}
