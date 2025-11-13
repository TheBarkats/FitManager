import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Servicio para gestionar preferencias de notificaciones
class NotificationsService {
  static const String baseUrl = 'http://10.0.2.2:9090/fitmanager/v1';
  
  final _storage = const FlutterSecureStorage();

  /// Obtener preferencias de notificaciones del usuario
  Future<Map<String, dynamic>> getPreferences(int userId) async {
    try {
      final token = await _storage.read(key: 'auth_token');
      
      final response = await http.get(
        Uri.parse('$baseUrl/usuarios/$userId/notificaciones'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        throw Exception('Sesión expirada. Por favor inicia sesión nuevamente');
      } else if (response.statusCode == 403) {
        throw Exception('No tienes permiso para acceder a estas preferencias');
      } else if (response.statusCode == 404) {
        // Si no existen preferencias, retornar valores por defecto
        return {
          'recordatoriosEntrenamiento': true,
          'actualizacionesProgreso': true,
          'nuevasRutinas': true,
          'logros': true,
          'notificacionesSistema': true,
          'notificacionesEmail': false,
        };
      } else {
        throw Exception('Error al obtener preferencias: ${response.statusCode}');
      }
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        throw Exception('Error de conexión: Verifica que el backend esté corriendo');
      }
      rethrow;
    }
  }

  /// Actualizar preferencias de notificaciones
  Future<Map<String, dynamic>> updatePreferences(
    int userId,
    Map<String, bool> preferences,
  ) async {
    try {
      final token = await _storage.read(key: 'auth_token');
      
      final response = await http.put(
        Uri.parse('$baseUrl/usuarios/$userId/notificaciones'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'recordatoriosEntrenamiento': preferences['workoutReminders'],
          'actualizacionesProgreso': preferences['progressUpdates'],
          'nuevasRutinas': preferences['newRoutines'],
          'logros': preferences['achievements'],
          'notificacionesSistema': preferences['systemNotifications'],
          'notificacionesEmail': preferences['emailNotifications'],
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        throw Exception('Sesión expirada. Por favor inicia sesión nuevamente');
      } else {
        throw Exception('Error al actualizar preferencias: ${response.statusCode}');
      }
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        throw Exception('Error de conexión: Verifica que el backend esté corriendo');
      }
      rethrow;
    }
  }
}
