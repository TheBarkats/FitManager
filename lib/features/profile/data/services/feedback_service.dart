import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Servicio para gestionar feedback del usuario
class FeedbackService {
  static const String baseUrl = 'http://10.0.2.2:9090/fitmanager/v1';
  
  final _storage = const FlutterSecureStorage();

  /// Enviar feedback del usuario
  Future<void> sendFeedback({
    required int userId,
    required String message,
  }) async {
    try {
      final token = await _storage.read(key: 'auth_token');
      
      final response = await http.post(
        Uri.parse('$baseUrl/feedback'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'usuarioId': userId,
          'mensaje': message,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Feedback enviado exitosamente
        return;
      } else if (response.statusCode == 400) {
        final error = jsonDecode(response.body);
        throw Exception(error['message'] ?? 'Datos inválidos');
      } else if (response.statusCode == 401) {
        throw Exception('Sesión expirada. Por favor inicia sesión nuevamente');
      } else {
        throw Exception('Error al enviar feedback: ${response.statusCode}');
      }
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        throw Exception('Error de conexión: Verifica que el backend esté corriendo');
      }
      rethrow;
    }
  }

  /// Obtener feedback del usuario (opcional)
  Future<List<Map<String, dynamic>>> getUserFeedback(int userId) async {
    try {
      final token = await _storage.read(key: 'auth_token');
      
      final response = await http.get(
        Uri.parse('$baseUrl/feedback/usuario/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else if (response.statusCode == 401) {
        throw Exception('Sesión expirada. Por favor inicia sesión nuevamente');
      } else {
        throw Exception('Error al obtener feedback: ${response.statusCode}');
      }
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        throw Exception('Error de conexión: Verifica que el backend esté corriendo');
      }
      rethrow;
    }
  }
}
