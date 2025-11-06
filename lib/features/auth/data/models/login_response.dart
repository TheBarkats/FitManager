class LoginResponse {
  final String accessToken;
  final String? refreshToken;
  final UserData user;

  LoginResponse({
    required this.accessToken,
    this.refreshToken,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    // Debug: ver qué llega
    // debugPrint('🟢 Parseando respuesta: $json');
    
    // Intentar obtener el token de múltiples posibles campos
    String token = '';
    if (json.containsKey('access_token')) {
      token = json['access_token'];
    } else if (json.containsKey('token')) {
      token = json['token'];
    } else if (json.containsKey('accessToken')) {
      token = json['accessToken'];
    } else if (json.containsKey('data') && json['data'] is Map) {
      final data = json['data'] as Map<String, dynamic>;
      token = data['access_token'] ?? data['token'] ?? '';
    }
    
    // Intentar obtener los datos del usuario
    Map<String, dynamic> userData = {};
    if (json.containsKey('user')) {
      userData = json['user'] ?? {};
    } else if (json.containsKey('data') && json['data'] is Map) {
      userData = json['data'] ?? {};
    } else {
      // Si no hay estructura específica, usar el json directamente
      userData = json;
    }
    
    // debugPrint('🟢 Token encontrado: ${token.isEmpty ? "NO" : "SI"}');
    // debugPrint('🟢 UserData: $userData');
    
    return LoginResponse(
      accessToken: token,
      refreshToken: json['refresh_token'] ?? json['refreshToken'],
      user: UserData.fromJson(userData),
    );
  }
}

class UserData {
  final String id;
  final String name;
  final String email;

  UserData({
    required this.id,
    required this.name,
    required this.email,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? json['nombre'] ?? '',
      email: json['email'] ?? json['correo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
