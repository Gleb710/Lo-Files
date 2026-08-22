// lib/core/entitlements/stub_entitlement_checker.dart

import 'entitlement_checker.dart';

/// MVP-заглушка [EntitlementChecker].
///
/// Плагинов и платных функций в MVP не существует физически, поэтому
/// [isFeatureAvailable] всегда возвращает `false` — ни один плагин не
/// показывается пользователю ни в Viewer Registry, ни в File Action
/// Registry (см. docs/architecture.md, раздел 3.6 — Strategy Pattern
/// через EntitlementChecker).
///
/// После MVP этот класс будет заменён реализацией, реально обращающейся
/// к backend'у (см. doc-комментарий [EntitlementChecker] про webhook от
/// RevenueCat и кэширование), но замена произойдёт через подмену
/// провайдера `entitlementCheckerProvider`, без изменения кода,
/// который использует интерфейс.
class StubEntitlementChecker implements EntitlementChecker {
  @override
  bool isFeatureAvailable(String featureId) => false;
}