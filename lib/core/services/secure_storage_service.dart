import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Servicio para manejar datos SENSIBLES en FlutterSecureStorage
/// 
/// NOTA: El backend de FitManager actualmente solo devuelve accessToken.
/// RefreshToken está preparado para implementación futura.
class SecureStorageService {
  static const String _keyAccessToken = 'access_token';
  static const String _keyRefreshToken = 'refresh_token';

  // Configuración de seguridad para Android
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  /// Guarda el access token
  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: _keyAccessToken, value: token);
  }

  /// Guarda el refresh token (opcional - no implementado en backend aún)
  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: _keyRefreshToken, value: token);
  }

  /// Guarda ambos tokens
  /// [refreshToken] es opcional ya que el backend no lo implementa aún
  Future<void> saveTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
    await saveAccessToken(accessToken);
    if (refreshToken != null && refreshToken.isNotEmpty) {
      await saveRefreshToken(refreshToken);
    }
  }

  /// Obtiene el access token
  Future<String?> getAccessToken() async {
    return await _storage.read(key: _keyAccessToken);
  }

  /// Obtiene el refresh token
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _keyRefreshToken);
  }

  /// Verifica si existe un token guardado
  Future<bool> hasToken() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }

  /// Elimina el access token
  Future<void> deleteAccessToken() async {
    await _storage.delete(key: _keyAccessToken);
  }

  /// Elimina el refresh token
  Future<void> deleteRefreshToken() async {
    await _storage.delete(key: _keyRefreshToken);
  }

  /// Elimina todos los tokens
  Future<void> deleteAllTokens() async {
    await _storage.delete(key: _keyAccessToken);
    await _storage.delete(key: _keyRefreshToken);
  }

  /// Limpia completamente el almacenamiento seguro
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}
