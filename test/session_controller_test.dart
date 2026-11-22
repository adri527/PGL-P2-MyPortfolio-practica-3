import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/services/auth_api.dart';
import 'package:my_portfolio/services/session_controller.dart';
import 'package:my_portfolio/services/token_storage.dart';

class _FakeAuthApi extends AuthApi {
  _FakeAuthApi({this.tokenIsValid = true});

  bool tokenIsValid;
  int validationCalls = 0;

  @override
  Future<void> checkToken(String token) async {
    validationCalls++;
    if (!tokenIsValid) {
      throw const ApiException('Token inválido', statusCode: 401);
    }
  }

  @override
  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async => const LoginResponse(message: 'Login correcto', token: 'jwt-test');
}

class _MemoryTokenStorage extends TokenStorage {
  String? token;

  @override
  Future<String?> readToken() async => token;

  @override
  Future<void> saveToken(String value) async => token = value;

  @override
  Future<void> deleteToken() async => token = null;
}

void main() {
  group('SessionController', () {
    test(
      'validates a saved token before restoring an authenticated session',
      () async {
        final api = _FakeAuthApi();
        final storage = _MemoryTokenStorage()..token = 'jwt-saved';
        final controller = SessionController(api: api, storage: storage);
        addTearDown(controller.dispose);

        await controller.restoreSession();

        expect(api.validationCalls, 1);
        expect(controller.initialized, isTrue);
        expect(controller.isAuthenticated, isTrue);
      },
    );

    test('removes an invalid saved token and remains signed out', () async {
      final api = _FakeAuthApi(tokenIsValid: false);
      final storage = _MemoryTokenStorage()..token = 'expired';
      final controller = SessionController(api: api, storage: storage);
      addTearDown(controller.dispose);

      await controller.restoreSession();

      expect(controller.isAuthenticated, isFalse);
      expect(storage.token, isNull);
    });

    test('persists the login token and clears it on logout', () async {
      final storage = _MemoryTokenStorage();
      final controller = SessionController(
        api: _FakeAuthApi(),
        storage: storage,
      );
      addTearDown(controller.dispose);

      final response = await controller.login(
        email: 'test@example.com',
        password: 'Password123',
      );
      expect(response.token, 'jwt-test');
      expect(storage.token, 'jwt-test');

      controller.completeLogin();
      expect(controller.isAuthenticated, isTrue);

      await controller.logout();
      expect(storage.token, isNull);
      expect(controller.isAuthenticated, isFalse);
    });
  });
}
