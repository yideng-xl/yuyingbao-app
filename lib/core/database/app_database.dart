import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'app_database.g.dart';

class Babies extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get gender => text()();
  DateTimeColumn get birthDate => dateTime()();
  RealColumn get birthHeight => real().nullable()();
  RealColumn get birthWeight => real().nullable()();
  TextColumn get avatar => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class Records extends Table {
  TextColumn get id => text()();
  TextColumn get babyId => text().references(Babies, #id)();
  TextColumn get type => text()();
  DateTimeColumn get happenedAt => dateTime()();
  IntColumn get durationMin => integer().nullable()();
  RealColumn get amountMl => real().nullable()();
  TextColumn get breastfeedingSide => text().nullable()();
  TextColumn get solidType => text().nullable()();
  TextColumn get solidIngredients => text().nullable()();
  TextColumn get solidBrand => text().nullable()();
  TextColumn get diaperTexture => text().nullable()();
  TextColumn get diaperColor => text().nullable()();
  BoolColumn get hasUrine => boolean().nullable()();
  RealColumn get heightCm => real().nullable()();
  RealColumn get weightKg => real().nullable()();
  TextColumn get nutritionTypes => text().nullable()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class Settings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'yuyingbao.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

@DriftDatabase(tables: [Babies, Records, Settings])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// For testing: accept a custom QueryExecutor
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;
}
