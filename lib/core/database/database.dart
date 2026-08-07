import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../../data/local/tables/recent_entries_table.dart';
import '../../data/local/tables/local_files_table.dart';
import '../../data/local/tables/favorites_table.dart';
import '../../data/local/tables/folders_table.dart';
import '../../data/local/tables/user_profile_cache_table.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    LocalFiles, 
    Favorites, 
    RecentEntries, 
    Folders,
    UserProfileCache,
    ],
  )
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'lo_files_db');
  }
}