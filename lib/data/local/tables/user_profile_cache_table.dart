import 'package:drift/drift.dart';

class UserProfileCache extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get displayName => text()();
  BoolColumn get isGuest => boolean()();
  TextColumn get entitlementsCache => text().nullable()();
}
