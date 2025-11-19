import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Servicio para cambiar contraseña del usuario
class PasswordService {
  static const String baseUrl = 'http://10.0.2.2:9090/fitmanager/v1';
  
  final _storage = const FlutterSecureStorage();

  /// Cambiar contraseña del usuario
  Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final token = await _storage.read(key: 'access_token');
      
      final response = await http.post(
        Uri.parse('$baseUrl/auth/change-password'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'currentPassword': currentPassword,
          'newPassword': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        // Contraseña cambiada exitosamente
        return {'message': 'Contraseña cambiada exitosamente'};
      } else if (response.statusCode == 400) {
        final error = jsonDecode(response.body);
        final message = error['message'] ?? 'Datos inválidos';
        
        // Verificar tipo de error
        if (message.contains('igual')) {
          throw Exception('La nueva contraseña debe ser diferente a la actual');
        } else {
          throw Exception(message);
        }
      } else if (response.statusCode == 401) {
        // Puede ser token inválido o contraseña actual incorrecta
        final error = jsonDecode(response.body);
        final message = error['message'] ?? '';
        
        if (message.contains('actual') || message.contains('incorrecta')) {
          throw Exception('La contraseña actual es incorrecta');
        } else {
          throw Exception('Sesión expirada. Por favor inicia sesión nuevamente');
        }
      } else {
        throw Exception('Error al cambiar contraseña: ${response.statusCode}');
      }
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        throw Exception('Error de conexión: Verifica que el backend esté corriendo');
      }
      rethrow;
    }
  }

  /// Solicitar código de restablecimiento de contraseña (cuando el usuario está autenticado)
  Future<void> requestPasswordResetCode() async {
    try {
      final token = await _storage.read(key: 'access_token');
      
      final response = await http.post(
        Uri.parse('$baseUrl/auth/request-password-reset-code'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return;
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['message'] ?? 'Error al solicitar código');
      }
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        throw Exception('Error de conexión: Verifica que el backend esté corriendo');
      }
      rethrow;
    }
  }

  /// Restablecer contraseña usando código de verificación (cuando el usuario está autenticado)
  Future<void> resetPasswordWithCode({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    try {
      final token = await _storage.read(key: 'access_token');
      
      final response = await http.post(
        Uri.parse('$baseUrl/auth/reset-password-with-code'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'email': email,
          'code': code,
          'newPassword': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        return;
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['message'] ?? 'Error al restablecer contraseña');
      }
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        throw Exception('Error de conexión: Verifica que el backend esté corriendo');
      }
      rethrow;
    }
  }
}
