import 'package:drift/drift.dart';
import '../core/database/app_database.dart';

class BabyRepository {
  final AppDatabase _db;

  BabyRepository(this._db);

  Future<List<Baby>> getAllBabies() {
    return (_db.select(_db.babies)
          ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
        .get();
  }

  Stream<List<Baby>> watchAllBabies() {
    return (_db.select(_db.babies)
          ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
        .watch();
  }

  Future<Baby?> getBabyById(String id) {
    return (_db.select(_db.babies)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<void> addBaby({
    required String id,
    required String name,
    required String gender,
    required DateTime birthDate,
    double? birthHeight,
    double? birthWeight,
    String? avatar,
  }) {
    return _db.into(_db.babies).insert(
          BabiesCompanion.insert(
            id: id,
            name: name,
            gender: gender,
            birthDate: birthDate,
            birthHeight: birthHeight != null
                ? Value(birthHeight)
                : const Value.absent(),
            birthWeight: birthWeight != null
                ? Value(birthWeight)
                : const Value.absent(),
            avatar: avatar != null ? Value(avatar) : const Value.absent(),
          ),
        );
  }

  Future<void> updateBaby({
    required String id,
    String? name,
    String? gender,
    DateTime? birthDate,
    double? birthHeight,
    double? birthWeight,
    String? avatar,
  }) {
    return (_db.update(_db.babies)..where((t) => t.id.equals(id))).write(
      BabiesCompanion(
        name: name != null ? Value(name) : const Value.absent(),
        gender: gender != null ? Value(gender) : const Value.absent(),
        birthDate:
            birthDate != null ? Value(birthDate) : const Value.absent(),
        birthHeight:
            birthHeight != null ? Value(birthHeight) : const Value.absent(),
        birthWeight:
            birthWeight != null ? Value(birthWeight) : const Value.absent(),
        avatar: avatar != null ? Value(avatar) : const Value.absent(),
      ),
    );
  }

  Future<void> deleteBaby(String id) {
    return (_db.delete(_db.babies)..where((t) => t.id.equals(id))).go();
  }
}
