import 'package:flutter/foundation.dart';
import 'package:my_portfolio/services/auth_api.dart';
import 'package:my_portfolio/services/token_storage.dart';

final SessionController sessionController = SessionController(
  api: AuthApi(),
  storage: TokenStorage(),
);

class SessionController extends ChangeNotifier {
  SessionController({required AuthApi api, required TokenStorage storage})
    : _api = api,
      _storage = storage;

  final AuthApi _api;
  final TokenStorage _storage;
  bool _initialized = false;
  bool _authenticated = false;
  String? _token;
  String? startupMessage;

  bool get initialized => _initialized;
  bool get isAuthenticated => _authenticated;

  Future<void> restoreSession() async {
    if (_initialized) return;
    try {
      _token = await _storage.readToken();
      if (_token != null) {
        await _api.checkToken(_token!);
        _authenticated = true;
      }
    } on ApiException catch (error) {
      if (error.statusCode == 401) {
        await _clearStoredToken();
      } else {
        // Keep a token on transient failures so it can be checked again later.
        startupMessage = error.message;
      }
    } catch (_) {
      startupMessage = 'No se pudo comprobar la sesión guardada.';
    } finally {
      _initialized = true;
      notifyListeners();
    }
  }

  Future<String> register({
    required String fullName,
    required String email,
    required String password,
  }) => _api.register(fullName: fullName, email: email, password: password);

  /// Stores the returned JWT before the UI completes the authenticated route.
  /// The caller shows the API response alert and then calls [completeLogin].
  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    final response = await _api.login(email: email, password: password);
    await _storage.saveToken(response.token);
    _token = response.token;
    return response;
  }

  void completeLogin() {
    _authenticated = true;
    startupMessage = null;
    notifyListeners();
  }

  Future<void> retryTokenValidation() async {
    try {
      _token = await _storage.readToken();
      if (_token == null) {
        startupMessage = null;
        notifyListeners();
        return;
      }
      await _api.checkToken(_token!);
      _authenticated = true;
      startupMessage = null;
      notifyListeners();
    } on ApiException catch (error) {
      if (error.statusCode == 401) await _clearStoredToken();
      startupMessage = error.message;
      notifyListeners();
    } catch (_) {
      startupMessage = 'No se pudo comprobar la sesión guardada.';
      notifyListeners();
    }
  }

  Future<String> requestWelcome() async {
    final token = _token ?? await _storage.readToken();
    if (token == null) throw const ApiException('No hay una sesión activa.');
    try {
      return await _api.welcome(token);
    } on ApiException catch (error) {
      if (error.statusCode == 401) await logout();
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _storage.deleteToken();
    } finally {
      _token = null;
      _authenticated = false;
      startupMessage = null;
      notifyListeners();
    }
  }

  Future<void> _clearStoredToken() async {
    await _storage.deleteToken();
    _token = null;
    _authenticated = false;
  }
}
