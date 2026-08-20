// lib/core/providers/entitlement_checker_provider.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../entitlements/entitlement_checker.dart';
import '../entitlements/stub_entitlement_checker.dart';

part 'entitlement_checker_provider.g.dart';

/// Глобальный singleton-провайдер [EntitlementChecker].
///
/// `keepAlive: true` обязателен по той же причине, что и для
/// `databaseProvider`: `EntitlementChecker` — core-сервис уровня
/// приложения, а не state конкретного экрана, и не должен пересоздаваться
/// при потере последнего слушателя (см. docs/architecture.md, раздел 3.5 —
/// DI через Riverpod).
///
/// Сейчас возвращает [StubEntitlementChecker] (MVP-заглушка, всегда
/// `false`). После MVP здесь будет подменена конкретная реализация,
/// обращающаяся к backend'у — вызывающий код (Viewer Registry, File
/// Action Registry) от этой замены не изменится, так как зависит только
/// от интерфейса [EntitlementChecker].
@Riverpod(keepAlive: true)
EntitlementChecker entitlementChecker(Ref ref) {
  return StubEntitlementChecker();
}