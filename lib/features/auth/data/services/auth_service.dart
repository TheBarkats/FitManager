import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/login_request.dart';
import '../models/login_response.dart';
import '../models/register_request.dart';

/// Servicio de autenticación con el backend de FitManager
class AuthService {
  // Para desarrollo local
  static const String baseUrl = 'http://10.0.2.2:9090/fitmanager/v1';
  
  // Alternativas:
  // - Para dispositivo físico en la misma red: 'http://192.168.X.X:9090/fitmanager/v1'
  // - Para web o producción: 'https://tu-dominio.com/fitmanager/v1'
  
  /// Realiza el login de USUARIO
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/usuario/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return LoginResponse.fromJson(jsonResponse);
      } else {
        final error = jsonDecode(response.body);
        
        // Manejar nuevo formato de errores del backend
        String errorMessage = error['message'] ?? 'Error en la solicitud';
        
        // Si hay detalles de validación, mostrarlos
        if (error['details'] != null && error['details'] is List && (error['details'] as List).isNotEmpty) {
          errorMessage = error['details'][0];
        }
        
        throw Exception(errorMessage);
      }
    } catch (e) {
      if (e is Exception && e.toString().contains('Exception:')) {
        rethrow;
      }
      throw Exception('Error de conexión: Verifica que el backend esté corriendo en localhost:9090');
    }
  }

  /// Realiza el registro de USUARIO
  Future<LoginResponse> register(RegisterRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/usuario/register'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return LoginResponse.fromJson(jsonResponse);
      } else {
        final error = jsonDecode(response.body);
        
        // Manejar nuevo formato de errores del backend
        String errorMessage = error['message'] ?? 'Error en el registro';
        
        // Si hay detalles de validación, mostrarlos
        if (error['details'] != null && error['details'] is List && (error['details'] as List).isNotEmpty) {
          errorMessage = error['details'][0];
        }
        
        throw Exception(errorMessage);
      }
    } catch (e) {
      if (e is Exception && e.toString().contains('Exception:')) {
        rethrow;
      }
      throw Exception('Error de conexión: Verifica que el backend esté corriendo en localhost:9090');
    }
  }

  /// Verifica el token (NOTA: Endpoint pendiente de implementar en backend)
  Future<bool> verifyToken(String token) async {
    try {
      // TODO: Implementar cuando el backend tenga el endpoint de verificación
      // Por ahora, simplemente verificamos que el token no esté vacío
      return token.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
