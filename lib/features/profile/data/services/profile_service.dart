import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Servicio para gestionar el perfil del usuario
class ProfileService {
  // URL base del backend
  static const String baseUrl = 'http://10.0.2.2:9090/fitmanager/v1';
  
  final _storage = const FlutterSecureStorage();

  /// Obtener información del perfil del usuario
  Future<Map<String, dynamic>> getProfile(int userId) async {
    try {
      final token = await _storage.read(key: 'access_token');
      
      final response = await http.get(
        Uri.parse('$baseUrl/usuarios/$userId'),
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
        throw Exception('No tienes permiso para acceder a este perfil');
      } else if (response.statusCode == 404) {
        throw Exception('Usuario no encontrado');
      } else {
        throw Exception('Error al obtener perfil: ${response.statusCode}');
      }
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        throw Exception('Error de conexión: Verifica que el backend esté corriendo');
      }
      rethrow;
    }
  }

  /// Actualizar información del perfil
  Future<Map<String, dynamic>> updateProfile(
    int userId,
    Map<String, dynamic> data,
  ) async {
    try {
      final token = await _storage.read(key: 'access_token');
      
      final response = await http.put(
        Uri.parse('$baseUrl/usuarios/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'nombre': data['nombre'],
          'email': data['email'],
          'edad': data['edad'],
          'altura': data['altura'], // Ya viene en metros desde el frontend
          'peso': data['peso'],
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 400) {
        final error = jsonDecode(response.body);
        throw Exception(error['message'] ?? 'Datos inválidos');
      } else if (response.statusCode == 401) {
        throw Exception('Sesión expirada. Por favor inicia sesión nuevamente');
      } else if (response.statusCode == 409) {
        throw Exception('El email ya está registrado');
      } else {
        throw Exception('Error al actualizar perfil: ${response.statusCode}');
      }
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        throw Exception('Error de conexión: Verifica que el backend esté corriendo');
      }
      rethrow;
    }
  }
}
