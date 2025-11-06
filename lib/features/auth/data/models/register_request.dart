/// Modelo de solicitud para registro de USUARIO en FitManager
class RegisterRequest {
  final String nombre;
  final String email;
  final String password;
  final int edad;
  final double altura;
  final double pesoInicial;

  RegisterRequest({
    required this.nombre,
    required this.email,
    required this.password,
    required this.edad,
    required this.altura,
    required this.pesoInicial,
  });

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'email': email,
      'password': password,
      'edad': edad,
      'altura': altura,
      'pesoInicial': pesoInicial,
    };
  }
}
