import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/routine.dart';
import '../../data/models/exercise.dart';
import 'routine_detail_page.dart';

class RoutinesPage extends StatelessWidget {
  const RoutinesPage({super.key});

  // Datos de rutinas con ejercicios reales
  List<Routine> _getRoutines() {
    return [
      Routine(
        id: '1',
        nombre: 'Rutina de Pecho',
        descripcion: 'Desarrollo completo del pecho con énfasis en fuerza y volumen muscular',
        dificultad: 'Intermedio',
        duracionMinutos: 45,
        objetivo: 'Hipertrofia y Fuerza',
        icono: 'self_improvement',
        ejercicios: [
          Exercise(
            id: '1',
            nombre: 'Press Banca Plano',
            maquina: 'Banco plano con barra',
            grupoMuscular: 'Pecho',
            instrucciones: [
              'Acuéstate en el banco con los pies apoyados en el suelo',
              'Agarra la barra con las manos a una distancia ligeramente mayor que el ancho de los hombros',
              'Baja la barra controladamente hasta tocar el pecho',
              'Empuja la barra hacia arriba hasta extender completamente los brazos',
              'Mantén los omóplatos juntos durante todo el movimiento',
            ],
            series: 4,
            repeticiones: '8-10',
            descansoSegundos: 90,
            tips: [
              'Mantén la espalda baja ligeramente arqueada',
              'No rebotes la barra en el pecho',
              'Exhala al empujar la barra hacia arriba',
            ],
          ),
          Exercise(
            id: '2',
            nombre: 'Press Inclinado con Mancuernas',
            maquina: 'Banco inclinado 30-45°',
            grupoMuscular: 'Pecho Superior',
            instrucciones: [
              'Ajusta el banco a 30-45 grados de inclinación',
              'Siéntate con las mancuernas sobre los muslos',
              'Levanta las mancuernas a la altura de los hombros',
              'Empuja las mancuernas hacia arriba hasta casi juntar',
              'Baja controladamente hasta sentir estiramiento en el pecho',
            ],
            series: 4,
            repeticiones: '10-12',
            descansoSegundos: 75,
            tips: [
              'No arquees demasiado la espalda',
              'Controla el peso en todo momento',
              'Rota ligeramente las mancuernas en la parte superior',
            ],
          ),
          Exercise(
            id: '3',
            nombre: 'Aperturas en Polea',
            maquina: 'Polea cruzada alta',
            grupoMuscular: 'Pecho',
            instrucciones: [
              'Párate en el centro de la máquina de poleas',
              'Agarra las manijas con los brazos extendidos a los lados',
              'Inclínate ligeramente hacia adelante',
              'Junta las manos frente a tu pecho en un movimiento de abrazo',
              'Regresa lentamente a la posición inicial',
            ],
            series: 3,
            repeticiones: '12-15',
            descansoSegundos: 60,
            tips: [
              'Mantén una ligera flexión en los codos',
              'Concéntrate en el estiramiento y contracción',
              'No uses impulso, movimiento controlado',
            ],
          ),
          Exercise(
            id: '4',
            nombre: 'Fondos en Paralelas',
            maquina: 'Barras paralelas',
            grupoMuscular: 'Pecho Inferior',
            instrucciones: [
              'Agarra las barras y elévate hasta extender los brazos',
              'Inclina el torso ligeramente hacia adelante',
              'Baja el cuerpo doblando los codos hasta 90 grados',
              'Empuja hacia arriba hasta extender completamente los brazos',
              'Mantén el core activado durante todo el ejercicio',
            ],
            series: 3,
            repeticiones: '8-12',
            descansoSegundos: 90,
            tips: [
              'Mayor inclinación = más trabajo de pecho',
              'Si es muy difícil, usa banda de asistencia',
              'No bloquees los codos bruscamente',
            ],
          ),
        ],
      ),
      Routine(
        id: '2',
        nombre: 'Rutina de Espalda',
        descripcion: 'Entrenamiento completo para desarrollar anchura y grosor de la espalda',
        dificultad: 'Avanzado',
        duracionMinutos: 50,
        objetivo: 'Masa Muscular',
        icono: 'fitness_center',
        ejercicios: [
          Exercise(
            id: '5',
            nombre: 'Dominadas',
            maquina: 'Barra para dominadas',
            grupoMuscular: 'Dorsal Ancho',
            instrucciones: [
              'Agarra la barra con las manos más anchas que los hombros',
              'Cuelga con los brazos completamente extendidos',
              'Tira hacia arriba hasta que la barbilla sobrepase la barra',
              'Baja controladamente hasta la posición inicial',
              'Mantén el pecho hacia afuera durante el movimiento',
            ],
            series: 4,
            repeticiones: '6-10',
            descansoSegundos: 120,
            tips: [
              'Evita balancearte o usar impulso',
              'Si es muy difícil, usa máquina asistida',
              'Enfócate en jalar con los codos, no con las manos',
            ],
          ),
          Exercise(
            id: '6',
            nombre: 'Remo con Barra',
            maquina: 'Barra olímpica',
            grupoMuscular: 'Espalda Media',
            instrucciones: [
              'Párate con los pies al ancho de hombros',
              'Inclínate hacia adelante manteniendo la espalda recta',
              'Agarra la barra con agarre pronado',
              'Jala la barra hacia el abdomen bajo',
              'Baja la barra controladamente sin perder la postura',
            ],
            series: 4,
            repeticiones: '8-10',
            descansoSegundos: 90,
            tips: [
              'Mantén las rodillas ligeramente flexionadas',
              'No redondees la espalda baja',
              'Aprieta los omóplatos al final del movimiento',
            ],
          ),
          Exercise(
            id: '7',
            nombre: 'Jalón al Pecho',
            maquina: 'Polea alta',
            grupoMuscular: 'Dorsal Ancho',
            instrucciones: [
              'Siéntate en la máquina y ajusta las rodilleras',
              'Agarra la barra con las manos más anchas que los hombros',
              'Inclínate ligeramente hacia atrás',
              'Jala la barra hacia el pecho superior',
              'Sube controladamente sin perder la tensión',
            ],
            series: 4,
            repeticiones: '10-12',
            descansoSegundos: 75,
            tips: [
              'No uses el peso del cuerpo para bajar la barra',
              'Saca el pecho al jalar',
              'Controla la fase excéntrica',
            ],
          ),
          Exercise(
            id: '8',
            nombre: 'Peso Muerto Rumano',
            maquina: 'Barra olímpica',
            grupoMuscular: 'Espalda Baja',
            instrucciones: [
              'Párate con los pies al ancho de cadera',
              'Agarra la barra con agarre pronado',
              'Mantén las piernas ligeramente flexionadas',
              'Baja la barra deslizándola por las piernas',
              'Sube empujando con las caderas hacia adelante',
            ],
            series: 3,
            repeticiones: '10-12',
            descansoSegundos: 90,
            tips: [
              'La espalda debe mantenerse recta siempre',
              'No es un ejercicio de piernas, enfócate en isquios',
              'Activa el core para proteger la zona lumbar',
            ],
          ),
        ],
      ),
      Routine(
        id: '3',
        nombre: 'Rutina de Pierna',
        descripcion: 'Entrenamiento intenso para desarrollo de cuádriceps, glúteos e isquiotibiales',
        dificultad: 'Avanzado',
        duracionMinutos: 60,
        objetivo: 'Fuerza y Volumen',
        icono: 'directions_run',
        ejercicios: [
          Exercise(
            id: '9',
            nombre: 'Sentadilla con Barra',
            maquina: 'Rack de sentadillas',
            grupoMuscular: 'Cuádriceps y Glúteos',
            instrucciones: [
              'Coloca la barra sobre los trapecios',
              'Separa los pies al ancho de hombros',
              'Baja flexionando rodillas y caderas simultáneamente',
              'Desciende hasta que los muslos estén paralelos al suelo',
              'Empuja con los talones para subir',
            ],
            series: 4,
            repeticiones: '8-10',
            descansoSegundos: 120,
            tips: [
              'Mantén el pecho hacia arriba',
              'Las rodillas no deben sobrepasar las puntas de los pies',
              'Respira profundo antes de bajar',
            ],
          ),
          Exercise(
            id: '10',
            nombre: 'Prensa de Piernas',
            maquina: 'Máquina prensa 45°',
            grupoMuscular: 'Cuádriceps',
            instrucciones: [
              'Siéntate y coloca los pies en la plataforma',
              'Separa los pies al ancho de hombros',
              'Desbloquea la plataforma y baja controladamente',
              'Baja hasta que las rodillas formen 90 grados',
              'Empuja con toda la planta del pie',
            ],
            series: 4,
            repeticiones: '10-12',
            descansoSegundos: 90,
            tips: [
              'No despegues la espalda baja del respaldo',
              'No extiendas completamente las rodillas arriba',
              'Mayor amplitud = más trabajo de glúteos',
            ],
          ),
          Exercise(
            id: '11',
            nombre: 'Extensión de Cuádriceps',
            maquina: 'Máquina de extensiones',
            grupoMuscular: 'Cuádriceps',
            instrucciones: [
              'Siéntate y ajusta el respaldo',
              'Coloca los pies detrás del rodillo',
              'Agarra las manijas a los lados',
              'Extiende las piernas hasta la posición horizontal',
              'Baja controladamente sin dejar caer el peso',
            ],
            series: 3,
            repeticiones: '12-15',
            descansoSegundos: 60,
            tips: [
              'No uses impulso para subir el peso',
              'Aprieta los cuádriceps en la parte superior',
              'Controla la bajada para mayor tensión',
            ],
          ),
          Exercise(
            id: '12',
            nombre: 'Curl Femoral Acostado',
            maquina: 'Máquina de curl femoral',
            grupoMuscular: 'Isquiotibiales',
            instrucciones: [
              'Acuéstate boca abajo en la máquina',
              'Coloca los tobillos bajo el rodillo',
              'Agarra las manijas para estabilizarte',
              'Flexiona las rodillas llevando el rodillo hacia los glúteos',
              'Baja controladamente hasta extensión completa',
            ],
            series: 3,
            repeticiones: '12-15',
            descansoSegundos: 60,
            tips: [
              'No despegues las caderas del banco',
              'Contrae los isquios en la parte superior',
              'Evita arquear demasiado la espalda',
            ],
          ),
        ],
      ),
      Routine(
        id: '4',
        nombre: 'Cardio Intenso',
        descripcion: 'Entrenamiento cardiovascular de alta intensidad para quemar grasa',
        dificultad: 'Intermedio',
        duracionMinutos: 30,
        objetivo: 'Pérdida de Grasa',
        icono: 'favorite',
        ejercicios: [
          Exercise(
            id: '13',
            nombre: 'Caminadora HIIT',
            maquina: 'Caminadora eléctrica',
            grupoMuscular: 'Cardiovascular',
            instrucciones: [
              'Comienza con 3 minutos de calentamiento caminando',
              'Corre a alta intensidad por 1 minuto',
              'Camina o trota suave por 2 minutos',
              'Repite el ciclo 6 veces',
              'Termina con 3 minutos de enfriamiento',
            ],
            series: 6,
            repeticiones: '1 min sprint',
            descansoSegundos: 120,
            tips: [
              'Mantén una postura erguida al correr',
              'Usa las barras solo para equilibrio',
              'Hidratate constantemente',
            ],
          ),
          Exercise(
            id: '14',
            nombre: 'Elíptica',
            maquina: 'Máquina elíptica',
            grupoMuscular: 'Cardiovascular',
            instrucciones: [
              'Coloca los pies en los pedales',
              'Agarra las manijas móviles',
              'Mantén un ritmo constante y fluido',
              'Alterna entre resistencia alta y baja',
              'Mantén el core activado',
            ],
            series: 3,
            repeticiones: '5 min',
            descansoSegundos: 60,
            tips: [
              'No te inclines hacia adelante',
              'Usa todo el rango de movimiento',
              'Bajo impacto, ideal para proteger rodillas',
            ],
          ),
          Exercise(
            id: '15',
            nombre: 'Bicicleta Estática',
            maquina: 'Bicicleta spinning',
            grupoMuscular: 'Cardiovascular',
            instrucciones: [
              'Ajusta la altura del asiento',
              'Comienza con resistencia baja',
              'Pedalea a ritmo moderado',
              'Aumenta la resistencia cada 2 minutos',
              'Mantén una cadencia constante',
            ],
            series: 4,
            repeticiones: '4 min',
            descansoSegundos: 90,
            tips: [
              'La rodilla no debe extenderse completamente',
              'Mantén los hombros relajados',
              'Varía entre sentado y de pie',
            ],
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final routines = _getRoutines();
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.gradientStart,
            AppColors.gradientEnd.withValues(alpha: 0.3),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Icon(
                    Icons.fitness_center_rounded,
                    color: Colors.white,
                    size: 32,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Mis Rutinas',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            
            // Content
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    ...routines.asMap().entries.map((entry) {
                      final routine = entry.value;
                      final colors = [Colors.blue, Colors.green, Colors.orange, Colors.red];
                      final icons = [
                        Icons.self_improvement_rounded,
                        Icons.fitness_center_rounded,
                        Icons.directions_run_rounded,
                        Icons.favorite_rounded,
                      ];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildRoutineCard(
                          context: context,
                          routine: routine,
                          icon: icons[entry.key],
                          color: colors[entry.key],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoutineCard({
    required BuildContext context,
    required Routine routine,
    required IconData icon,
    required Color color,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RoutineDetailPage(routine: routine),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    routine.nombre,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildInfoChip(
                        icon: Icons.list_rounded,
                        text: '${routine.totalEjercicios} ejercicios',
                      ),
                      const SizedBox(width: 8),
                      _buildInfoChip(
                        icon: Icons.access_time_rounded,
                        text: routine.duracionFormatted,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      routine.dificultad,
                      style: TextStyle(
                        fontSize: 12,
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String text,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
