import 'package:drift/drift.dart';
import '../core/database/app_database.dart';

// Alias to avoid conflict with Dart 3 core Record type
typedef BabyRecord = Record;

class RecordRepository {
  final AppDatabase _db;

  RecordRepository(this._db);

  Future<void> addRecord({
    required String id,
    required String babyId,
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
  }) {
    return _db.into(_db.records).insert(
          RecordsCompanion.insert(
            id: id,
            babyId: babyId,
            type: type,
            happenedAt: happenedAt,
            durationMin: durationMin != null
                ? Value(durationMin)
                : const Value.absent(),
            amountMl:
                amountMl != null ? Value(amountMl) : const Value.absent(),
            breastfeedingSide: breastfeedingSide != null
                ? Value(breastfeedingSide)
                : const Value.absent(),
            solidType:
                solidType != null ? Value(solidType) : const Value.absent(),
            solidIngredients: solidIngredients != null
                ? Value(solidIngredients)
                : const Value.absent(),
            solidBrand: solidBrand != null
                ? Value(solidBrand)
                : const Value.absent(),
            diaperTexture: diaperTexture != null
                ? Value(diaperTexture)
                : const Value.absent(),
            diaperColor: diaperColor != null
                ? Value(diaperColor)
                : const Value.absent(),
            hasUrine:
                hasUrine != null ? Value(hasUrine) : const Value.absent(),
            heightCm:
                heightCm != null ? Value(heightCm) : const Value.absent(),
            weightKg:
                weightKg != null ? Value(weightKg) : const Value.absent(),
            nutritionTypes: nutritionTypes != null
                ? Value(nutritionTypes)
                : const Value.absent(),
            note: note != null ? Value(note) : const Value.absent(),
          ),
        );
  }

  Future<void> updateRecord({
    required String id,
    String? type,
    DateTime? happenedAt,
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
  }) {
    return (_db.update(_db.records)..where((t) => t.id.equals(id))).write(
      RecordsCompanion(
        type: type != null ? Value(type) : const Value.absent(),
        happenedAt:
            happenedAt != null ? Value(happenedAt) : const Value.absent(),
        durationMin: durationMin != null
            ? Value(durationMin)
            : const Value.absent(),
        amountMl: amountMl != null ? Value(amountMl) : const Value.absent(),
        breastfeedingSide: breastfeedingSide != null
            ? Value(breastfeedingSide)
            : const Value.absent(),
        solidType:
            solidType != null ? Value(solidType) : const Value.absent(),
        solidIngredients: solidIngredients != null
            ? Value(solidIngredients)
            : const Value.absent(),
        solidBrand:
            solidBrand != null ? Value(solidBrand) : const Value.absent(),
        diaperTexture: diaperTexture != null
            ? Value(diaperTexture)
            : const Value.absent(),
        diaperColor:
            diaperColor != null ? Value(diaperColor) : const Value.absent(),
        hasUrine: hasUrine != null ? Value(hasUrine) : const Value.absent(),
        heightCm: heightCm != null ? Value(heightCm) : const Value.absent(),
        weightKg: weightKg != null ? Value(weightKg) : const Value.absent(),
        nutritionTypes: nutritionTypes != null
            ? Value(nutritionTypes)
            : const Value.absent(),
        note: note != null ? Value(note) : const Value.absent(),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> deleteRecord(String id) {
    return (_db.delete(_db.records)..where((t) => t.id.equals(id))).go();
  }

  Future<List<BabyRecord>> getRecordsByDate({
    required String babyId,
    required DateTime start,
    required DateTime end,
  }) {
    return (_db.select(_db.records)
          ..where(
            (t) =>
                t.babyId.equals(babyId) &
                t.happenedAt.isBiggerOrEqualValue(start) &
                t.happenedAt.isSmallerOrEqualValue(end),
          )
          ..orderBy([(t) => OrderingTerm.desc(t.happenedAt)]))
        .get();
  }

  Future<List<BabyRecord>> getRecordsByType({
    required String babyId,
    required String type,
    required DateTime start,
    required DateTime end,
  }) {
    return (_db.select(_db.records)
          ..where(
            (t) =>
                t.babyId.equals(babyId) &
                t.type.equals(type) &
                t.happenedAt.isBiggerOrEqualValue(start) &
                t.happenedAt.isSmallerOrEqualValue(end),
          )
          ..orderBy([(t) => OrderingTerm.desc(t.happenedAt)]))
        .get();
  }

  Stream<List<BabyRecord>> watchRecordsByDate({
    required String babyId,
    required DateTime start,
    required DateTime end,
  }) {
    return (_db.select(_db.records)
          ..where(
            (t) =>
                t.babyId.equals(babyId) &
                t.happenedAt.isBiggerOrEqualValue(start) &
                t.happenedAt.isSmallerOrEqualValue(end),
          )
          ..orderBy([(t) => OrderingTerm.desc(t.happenedAt)]))
        .watch();
  }

  Future<List<BabyRecord>> getRecentRecords({
    required String babyId,
    int limit = 10,
  }) {
    return (_db.select(_db.records)
          ..where((t) => t.babyId.equals(babyId))
          ..orderBy([(t) => OrderingTerm.desc(t.happenedAt)])
          ..limit(limit))
        .get();
  }

  Future<List<BabyRecord>> getAllRecords(String babyId) {
    return (_db.select(_db.records)
          ..where((t) => t.babyId.equals(babyId))
          ..orderBy([(t) => OrderingTerm.desc(t.happenedAt)]))
        .get();
  }
}
