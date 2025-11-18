import 'dart:convert';
import 'package:http/http.dart' as http;

/// Servicio para obtener configuración de la aplicación desde el backend
class ConfigService {
  static const String baseUrl = 'http://10.0.2.2:9090/fitmanager/v1';

  /// Obtiene la información de la aplicación (versión, URLs legales, etc.)
  Future<Map<String, dynamic>> getAppInfo() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/configuracion/app-info'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        // El backend retorna: { "success": true, "data": {...}, "message": "..." }
        return jsonResponse['data'] as Map<String, dynamic>;
      } else {
        throw Exception('Error al obtener información de la app');
      }
    } catch (e) {
      // Retornar valores por defecto si hay error
      return {
        'version': '1.0.0',
        'buildNumber': '1',
        'privacyPolicyUrl': null,
        'termsUrl': null,
        'licenseUrl': null,
      };
    }
  }

  /// Obtiene la información de contacto (email, teléfono, chat, web)
  Future<Map<String, dynamic>> getContactInfo() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/configuracion/contacto'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        // El backend retorna: { "success": true, "data": {...}, "message": "..." }
        return jsonResponse['data'] as Map<String, dynamic>;
      } else {
        throw Exception('Error al obtener información de contacto');
      }
    } catch (e) {
      // Retornar valores por defecto si hay error
      return {
        'email': 'soporte@fitmanager.com',
        'telefono': '+57 300 123 4567',
        'chatUrl': null,
        'websiteUrl': null,
      };
    }
  }
}
