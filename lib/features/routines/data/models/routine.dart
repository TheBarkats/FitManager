import 'exercise.dart';

class Routine {
  final String id;
  final String nombre;
  final String descripcion;
  final String dificultad; // Principiante, Intermedio, Avanzado
  final int duracionMinutos;
  final String objetivo;
  final List<Exercise> ejercicios;
  final String icono; // nombre del icono

  Routine({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.dificultad,
    required this.duracionMinutos,
    required this.objetivo,
    required this.ejercicios,
    required this.icono,
  });

  int get totalEjercicios => ejercicios.length;
  
  String get duracionFormatted {
    if (duracionMinutos < 60) {
      return '$duracionMinutos min';
    }
    final horas = duracionMinutos ~/ 60;
    final minutos = duracionMinutos % 60;
    return minutos > 0 ? '$horas h $minutos min' : '$horas h';
  }
}
