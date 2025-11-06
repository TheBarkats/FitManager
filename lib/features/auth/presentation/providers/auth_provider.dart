import 'package:flutter/foundation.dart';
import '../../data/models/login_request.dart';
import '../../data/models/login_response.dart';
import '../../data/models/register_request.dart';
import '../../data/services/auth_service.dart';
import '../../../../core/services/shared_preferences_service.dart';
import '../../../../core/services/secure_storage_service.dart';

enum AuthState {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
}

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final SharedPreferencesService _prefsService = SharedPreferencesService();
  final SecureStorageService _secureStorage = SecureStorageService();

  AuthState _state = AuthState.initial;
  String? _errorMessage;
  UserData? _currentUser;

  AuthState get state => _state;
  String? get errorMessage => _errorMessage;
  UserData? get currentUser => _currentUser;
  bool get isAuthenticated => _state == AuthState.authenticated;
  bool get isLoading => _state == AuthState.loading;

  /// Inicializa el estado de autenticación
  Future<void> initialize() async {
    _state = AuthState.loading;
    notifyListeners();

    try {
      final hasToken = await _secureStorage.hasToken();
      final isLoggedIn = await _prefsService.isLoggedIn();

      if (hasToken && isLoggedIn) {
        // Cargar datos del usuario desde SharedPreferences
        final name = await _prefsService.getUserName();
        final email = await _prefsService.getUserEmail();
        final id = await _prefsService.getUserId();

        if (name != null && email != null && id != null) {
          _currentUser = UserData(id: id, name: name, email: email);
          _state = AuthState.authenticated;
        } else {
          _state = AuthState.unauthenticated;
        }
      } else {
        _state = AuthState.unauthenticated;
      }
    } catch (e) {
      _state = AuthState.unauthenticated;
    }

    notifyListeners();
  }

  /// Realiza el login
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _state = AuthState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final request = LoginRequest(email: email, password: password);
      final response = await _authService.login(request);

      // Guardar token (el backend solo devuelve accessToken)
      await _secureStorage.saveTokens(
        accessToken: response.token,
        refreshToken: null, // No implementado en el backend aún
      );

      // Guardar datos del usuario
      await _prefsService.saveUserData(
        name: response.user.name,
        email: response.user.email,
        id: response.user.id,
      );

      _currentUser = response.user;
      _state = AuthState.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _state = AuthState.error;
      notifyListeners();
      return false;
    }
  }

  /// Realiza el registro de USUARIO
  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required int edad,
    required double altura,
    required double pesoInicial,
  }) async {
    _state = AuthState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final request = RegisterRequest(
        nombre: name,
        email: email,
        password: password,
        edad: edad,
        altura: altura,
        pesoInicial: pesoInicial,
      );
      final response = await _authService.register(request);

      // Guardar token (el backend solo devuelve accessToken)
      await _secureStorage.saveTokens(
        accessToken: response.token,
        refreshToken: null, // No implementado en el backend aún
      );

      // Guardar datos del usuario
      await _prefsService.saveUserData(
        name: response.user.name,
        email: response.user.email,
        id: response.user.id,
      );

      _currentUser = response.user;
      _state = AuthState.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _state = AuthState.error;
      notifyListeners();
      return false;
    }
  }

  /// Cierra sesión
  Future<void> logout() async {
    _state = AuthState.loading;
    notifyListeners();

    try {
      // Limpiar datos seguros
      await _secureStorage.deleteAllTokens();
      
      // Limpiar datos no sensibles
      await _prefsService.clearUserData();

      _currentUser = null;
      _state = AuthState.unauthenticated;
    } catch (e) {
      _errorMessage = 'Error al cerrar sesión: $e';
      _state = AuthState.error;
    }

    notifyListeners();
  }

  /// Limpia el error
  void clearError() {
    _errorMessage = null;
    if (_state == AuthState.error) {
      _state = AuthState.unauthenticated;
      notifyListeners();
    }
  }
}
