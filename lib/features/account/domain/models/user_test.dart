import 'package:flutter_test/flutter_test.dart';
import 'package:lo_files/features/account/domain/models/user.dart';

void main() {
  group('User', () {
    test('creates guest user as default MVP scenario', () {
      final user = User.guest(id: 'guest-001');

      expect(user.id, 'guest-001');
      expect(user.displayName, 'Гость');
      expect(user.isGuest, true);
    });

    test('copyWith updates only requested field', () {
      final user = User(
        id: 'user-001',
        displayName: 'Alex',
        isGuest: false,
      );

      final updated = user.copyWith(displayName: 'Alexey');

      expect(updated.id, user.id);
      expect(updated.displayName, 'Alexey');
      expect(updated.isGuest, user.isGuest);
      expect(identical(updated, user), isFalse);
    });
  });
}