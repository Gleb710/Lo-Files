import 'package:drift/drift.dart';

import 'local_files_table.dart';

class RecentEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get fileId => integer().references(LocalFiles, #id)();
  DateTimeColumn get openedAt => dateTime()();
  TextColumn get syncStatus => text().nullable()();
}