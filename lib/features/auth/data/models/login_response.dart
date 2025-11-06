/// Modelo de respuesta del backend FitManager
/// 
/// El backend devuelve:
/// ```json
/// {
///   "token": "eyJhbGciOiJIUzI1...",
///   "userType": "USUARIO",
///   "userId": 1,
///   "userName": "Juan Pérez",
///   "email": "juan@email.com",
///   "message": "Login exitoso"
/// }
/// ```
class LoginResponse {
  final String token;
  final String userType;
  final UserData user;
  final String? message;

  LoginResponse({
    required this.token,
    required this.userType,
    required this.user,
    this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'] ?? '',
      userType: json['userType'] ?? 'USUARIO',
      message: json['message'],
      user: UserData(
        id: json['userId']?.toString() ?? '',
        name: json['userName'] ?? '',
        email: json['email'] ?? '',
      ),
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
