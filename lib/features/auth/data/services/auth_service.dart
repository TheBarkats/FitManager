import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/login_request.dart';
import '../models/login_response.dart';
import '../models/register_request.dart';

/// Servicio de autenticación con la API de VisionTic
class AuthService {
  static const String baseUrl = 'https://parking.visiontic.com.co/api';
  
  /// Realiza el login
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        return LoginResponse.fromJson(jsonResponse);
      } else {
        final error = jsonDecode(response.body);
        throw Exception(
          error['message'] ?? 'Error en el login: ${response.statusCode}'
        );
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  /// Realiza el registro
  Future<LoginResponse> register(RegisterRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        return LoginResponse.fromJson(jsonResponse);
      } else {
        final error = jsonDecode(response.body);
        throw Exception(
          error['message'] ?? 'Error en el registro: ${response.statusCode}'
        );
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  /// Verifica el token
  Future<bool> verifyToken(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
