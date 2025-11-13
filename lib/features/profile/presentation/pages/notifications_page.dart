import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/services/notifications_service.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final _notificationsService = NotificationsService();
  
  bool _isLoadingData = true;
  bool _workoutReminders = true;
  bool _progressUpdates = true;
  bool _newRoutines = false;
  bool _achievements = true;
  bool _systemNotifications = true;
  bool _emailNotifications = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    try {
      final authProvider = context.read<AuthProvider>();
      final user = authProvider.currentUser;
      
      if (user?.id != null) {
        final userId = int.parse(user!.id);
        final prefs = await _notificationsService.getPreferences(userId);
        
        if (mounted) {
          setState(() {
            _workoutReminders = prefs['recordatoriosEntrenamiento'] ?? true;
            _progressUpdates = prefs['actualizacionesProgreso'] ?? true;
            _newRoutines = prefs['nuevasRutinas'] ?? false;
            _achievements = prefs['logros'] ?? true;
            _systemNotifications = prefs['notificacionesSistema'] ?? true;
            _emailNotifications = prefs['notificacionesEmail'] ?? false;
            _isLoadingData = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingData = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al cargar preferencias: $e'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }

  Future<void> _savePreferences() async {
    try {
      final authProvider = context.read<AuthProvider>();
      final user = authProvider.currentUser;
      
      if (user?.id == null) return;
      
      final userId = int.parse(user!.id);
      
      await _notificationsService.updatePreferences(userId, {
        'workoutReminders': _workoutReminders,
        'progressUpdates': _progressUpdates,
        'newRoutines': _newRoutines,
        'achievements': _achievements,
        'systemNotifications': _systemNotifications,
        'emailNotifications': _emailNotifications,
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Preferencias guardadas'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al guardar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              _buildHeader(context),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: _isLoadingData
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        )
                      : ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      const Text(
                        'Notificaciones de Entrenamiento',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildNotificationTile(
                        icon: Icons.alarm,
                        title: 'Recordatorios de Entrenamiento',
                        subtitle: 'Recibe recordatorios para entrenar',
                        value: _workoutReminders,
                        onChanged: (value) {
                          setState(() => _workoutReminders = value);
                          _savePreferences();
                        },
                      ),
                      _buildNotificationTile(
                        icon: Icons.trending_up,
                        title: 'Actualizaciones de Progreso',
                        subtitle: 'Notificaciones sobre tu progreso',
                        value: _progressUpdates,
                        onChanged: (value) {
                          setState(() => _progressUpdates = value);
                          _savePreferences();
                        },
                      ),
                      _buildNotificationTile(
                        icon: Icons.fitness_center,
                        title: 'Nuevas Rutinas',
                        subtitle: 'Cuando se añadan rutinas nuevas',
                        value: _newRoutines,
                        onChanged: (value) {
                          setState(() => _newRoutines = value);
                          _savePreferences();
                        },
                      ),
                      _buildNotificationTile(
                        icon: Icons.emoji_events,
                        title: 'Logros y Medallas',
                        subtitle: 'Cuando alcances nuevos logros',
                        value: _achievements,
                        onChanged: (value) {
                          setState(() => _achievements = value);
                          _savePreferences();
                        },
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Métodos de Notificación',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildNotificationTile(
                        icon: Icons.notifications_active,
                        title: 'Notificaciones Push',
                        subtitle: 'En tu dispositivo',
                        value: _systemNotifications,
                        onChanged: (value) {
                          setState(() => _systemNotifications = value);
                          _savePreferences();
                        },
                      ),
                      _buildNotificationTile(
                        icon: Icons.email,
                        title: 'Notificaciones por Email',
                        subtitle: 'Recibir actualizaciones por correo',
                        value: _emailNotifications,
                        onChanged: (value) {
                          setState(() => _emailNotifications = value);
                          _savePreferences();
                        },
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Los cambios se guardan automáticamente',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'Notificaciones',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SwitchListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        secondary: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primary,
      ),
    );
  }
}
