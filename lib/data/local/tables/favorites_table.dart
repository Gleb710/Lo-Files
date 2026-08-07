import 'package:drift/drift.dart';

import 'local_files_table.dart';

class Favorites extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get fileId => integer().references(LocalFiles, #id)();
  DateTimeColumn get addedAt => dateTime()();
  TextColumn get syncStatus => text().nullable()();

  @override
  List<Set<Column>> get uniqueKeys => [
        {fileId},
      ];
}