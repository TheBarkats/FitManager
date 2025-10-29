import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/services/shared_preferences_service.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../providers/auth_provider.dart';

class EvidencePage extends StatefulWidget {
  const EvidencePage({super.key});

  @override
  State<EvidencePage> createState() => _EvidencePageState();
}

class _EvidencePageState extends State<EvidencePage> {
  final _prefsService = SharedPreferencesService();
  final _secureStorage = SecureStorageService();

  String? _userName;
  String? _userEmail;
  String? _userId;
  bool _hasAccessToken = false;
  bool _hasRefreshToken = false;
  String? _accessToken;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStoredData();
  }

  Future<void> _loadStoredData() async {
    setState(() => _isLoading = true);

    try {
      // Cargar datos de SharedPreferences (NO sensibles)
      _userName = await _prefsService.getUserName();
      _userEmail = await _prefsService.getUserEmail();
      _userId = await _prefsService.getUserId();

      // Verificar existencia de tokens (Sensibles)
      _hasAccessToken = await _secureStorage.hasToken();
      _hasRefreshToken = (await _secureStorage.getRefreshToken()) != null;
      
      // Obtener primeros caracteres del token para mostrar
      final token = await _secureStorage.getAccessToken();
      if (token != null && token.length > 20) {
        _accessToken = '${token.substring(0, 20)}...';
      } else {
        _accessToken = token;
      }
    } catch (e) {
      // debugPrint('Error cargando datos: $e');
    }

    setState(() => _isLoading = false);
  }

  Future<void> _handleLogout() async {
    final authProvider = context.read<AuthProvider>();
    
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cerrar sesión'),
        content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Cerrar sesión'),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      await authProvider.logout();
      _loadStoredData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Evidencia de Almacenamiento'),
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadStoredData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Sección SharedPreferences
                    _buildSection(
                      title: 'SharedPreferences (Datos NO sensibles)',
                      icon: Icons.storage,
                      color: AppColors.primary,
                      children: [
                        _buildInfoCard(
                          'Nombre',
                          _userName ?? 'No disponible',
                          Icons.person,
                        ),
                        const SizedBox(height: 12),
                        _buildInfoCard(
                          'Email',
                          _userEmail ?? 'No disponible',
                          Icons.email,
                        ),
                        const SizedBox(height: 12),
                        _buildInfoCard(
                          'ID Usuario',
                          _userId ?? 'No disponible',
                          Icons.tag,
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Sección FlutterSecureStorage
                    _buildSection(
                      title: 'FlutterSecureStorage (Datos SENSIBLES)',
                      icon: Icons.security,
                      color: Colors.green,
                      children: [
                        _buildSecureInfoCard(
                          'Access Token',
                          _hasAccessToken ? 'Token presente ✓' : 'Sin token',
                          _hasAccessToken,
                          _accessToken,
                        ),
                        const SizedBox(height: 12),
                        _buildSecureInfoCard(
                          'Refresh Token',
                          _hasRefreshToken ? 'Token presente ✓' : 'Sin token',
                          _hasRefreshToken,
                          null,
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Estado de sesión
                    _buildSection(
                      title: 'Estado de Sesión',
                      icon: Icons.info,
                      color: Colors.orange,
                      children: [
                        Consumer<AuthProvider>(
                          builder: (context, authProvider, _) {
                            return _buildStatusCard(
                              authProvider.isAuthenticated,
                            );
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Botón de cerrar sesión
                    ElevatedButton.icon(
                      onPressed: _hasAccessToken ? _handleLogout : null,
                      icon: const Icon(Icons.logout),
                      label: const Text('Cerrar sesión'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        disabledBackgroundColor: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Botón de refrescar
                    OutlinedButton.icon(
                      onPressed: _loadStoredData,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Refrescar datos'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required Color color,
    required List<Widget> children,
  }) {
    return Container(
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
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.textSecondary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecureInfoCard(
    String label,
    String status,
    bool hasToken,
    String? tokenPreview,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: hasToken ? Colors.green[50] : Colors.red[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: hasToken ? Colors.green[200]! : Colors.red[200]!,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                hasToken ? Icons.check_circle : Icons.cancel,
                size: 20,
                color: hasToken ? Colors.green : Colors.red,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: hasToken ? Colors.green[700] : Colors.red[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (tokenPreview != null) ...[
            const SizedBox(height: 8),
            Text(
              'Vista previa: $tokenPreview',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey[600],
                fontFamily: 'monospace',
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusCard(bool isAuthenticated) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isAuthenticated ? Colors.green[50] : Colors.orange[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isAuthenticated ? Colors.green[200]! : Colors.orange[200]!,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isAuthenticated ? Icons.check_circle : Icons.warning,
            color: isAuthenticated ? Colors.green : Colors.orange,
            size: 32,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isAuthenticated ? 'Sesión activa' : 'Sin sesión',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isAuthenticated ? Colors.green[700] : Colors.orange[700],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isAuthenticated
                      ? 'Usuario autenticado correctamente'
                      : 'No hay una sesión activa',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
