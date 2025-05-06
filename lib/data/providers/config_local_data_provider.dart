part of 'local_data_providers.dart';

class ConfigLocalDataProvider {
  final SharedPreferences _sharedPreferences = getIt<SharedPreferences>();

  /// --- Разрешения ---

  /// Разрешения были запрошены
  Future<void> setPermissionsRequested() async {
    await _sharedPreferences.setBool('permissions_requested', true);
  }

  /// Сброс запроса разрешений
  Future<void> removePermissionsRequested() async {
    await _sharedPreferences.setBool('permissions_requested', false);
  }

  /// Были ли запрошены разрешения
  Future<bool> getPermissionsRequested() async {
    return _sharedPreferences.getBool('permissions_requested') ?? false;
  }
}
