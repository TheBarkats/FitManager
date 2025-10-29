class Usuario {
  final int? idUsuario;
  final String nombre;
  final String correo;
  final String contrasena;
  final int edad;
  final double altura;
  final double pesoInicial;
  final DateTime? fechaRegistro;

  Usuario({
    this.idUsuario,
    required this.nombre,
    required this.correo,
    required this.contrasena,
    required this.edad,
    required this.altura,
    required this.pesoInicial,
    this.fechaRegistro,
  });

  // Convert from JSON
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      idUsuario: json['idUsuario'],
      nombre: json['nombre'],
      correo: json['correo'],
      contrasena: json['contrasena'],
      edad: json['edad'],
      altura: (json['altura'] as num).toDouble(),
      pesoInicial: (json['pesoInicial'] as num).toDouble(),
      fechaRegistro: json['fechaRegistro'] != null
          ? DateTime.parse(json['fechaRegistro'])
          : null,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      if (idUsuario != null) 'idUsuario': idUsuario,
      'nombre': nombre,
      'correo': correo,
      'contrasena': contrasena,
      'edad': edad,
      'altura': altura,
      'pesoInicial': pesoInicial,
      if (fechaRegistro != null)
        'fechaRegistro': fechaRegistro!.toIso8601String().split('T')[0],
    };
  }

  // Create a copy with some fields changed
  Usuario copyWith({
    int? idUsuario,
    String? nombre,
    String? correo,
    String? contrasena,
    int? edad,
    double? altura,
    double? pesoInicial,
    DateTime? fechaRegistro,
  }) {
    return Usuario(
      idUsuario: idUsuario ?? this.idUsuario,
      nombre: nombre ?? this.nombre,
      correo: correo ?? this.correo,
      contrasena: contrasena ?? this.contrasena,
      edad: edad ?? this.edad,
      altura: altura ?? this.altura,
      pesoInicial: pesoInicial ?? this.pesoInicial,
      fechaRegistro: fechaRegistro ?? this.fechaRegistro,
    );
  }

  @override
  String toString() {
    return 'Usuario{idUsuario: $idUsuario, nombre: $nombre, correo: $correo, edad: $edad, altura: $altura, pesoInicial: $pesoInicial, fechaRegistro: $fechaRegistro}';
  }
}
