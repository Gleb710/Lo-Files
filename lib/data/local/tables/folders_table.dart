import 'package:drift/drift.dart';

class Folders extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get parentId => integer()
    .nullable()
    .references(Folders, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get createdAt => dateTime()();
}
