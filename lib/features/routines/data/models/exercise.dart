class Exercise {
  final String id;
  final String nombre;
  final String maquina;
  final String grupoMuscular;
  final List<String> instrucciones;
  final int series;
  final String repeticiones; // Puede ser "10-12" o "15"
  final int descansoSegundos;
  final List<String> tips;
  final String? imagenUrl;

  Exercise({
    required this.id,
    required this.nombre,
    required this.maquina,
    required this.grupoMuscular,
    required this.instrucciones,
    required this.series,
    required this.repeticiones,
    required this.descansoSegundos,
    required this.tips,
    this.imagenUrl,
  });

  String get descansoFormatted {
    if (descansoSegundos < 60) {
      return '$descansoSegundos seg';
    }
    final minutos = descansoSegundos ~/ 60;
    final segundos = descansoSegundos % 60;
    return segundos > 0 ? '$minutos min $segundos seg' : '$minutos min';
  }
}
