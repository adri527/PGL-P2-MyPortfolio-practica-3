import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:my_portfolio/services/auth_api.dart';

void main() {
  group('AuthApi contract', () {
    test(
      'register sends the documented fields to the registration route',
      () async {
        final api = AuthApi(
          client: MockClient((request) async {
            expect(request.method, 'POST');
            expect(request.url.path, '/users/register');
            expect(
              request.headers['content-type'],
              contains('application/json'),
            );
            expect(jsonDecode(request.body), {
              'fullName': 'Test User',
              'email': 'test@example.com',
              'pwd': 'Password123',
            });
            return http.Response(
              jsonEncode({'message': 'Registro correcto'}),
              201,
            );
          }),
        );

        expect(
          await api.register(
            fullName: 'Test User',
            email: 'test@example.com',
            password: 'Password123',
          ),
          'Registro correcto',
        );
      },
    );

    test('login reads the JWT and sends the documented request body', () async {
      final api = AuthApi(
        client: MockClient((request) async {
          expect(request.method, 'POST');
          expect(request.url.path, '/users/login');
          expect(jsonDecode(request.body), {
            'email': 'test@example.com',
            'pwd': 'Password123',
          });
          return http.Response(
            jsonEncode({'message': 'Login correcto', 'token': 'jwt-value'}),
            200,
          );
        }),
      );

      final response = await api.login(
        email: 'test@example.com',
        password: 'Password123',
      );
      expect(response.message, 'Login correcto');
      expect(response.token, 'jwt-value');
    });

    test(
      'check-token and welcome send the token as a Bearer credential',
      () async {
        final paths = <String>[];
        final api = AuthApi(
          client: MockClient((request) async {
            paths.add(request.url.path);
            expect(request.method, 'GET');
            expect(request.headers['authorization'], 'Bearer jwt-value');
            return http.Response(
              jsonEncode({'message': 'Respuesta válida'}),
              200,
              headers: {'content-type': 'application/json; charset=utf-8'},
            );
          }),
        );

        await api.checkToken('jwt-value');
        expect(await api.welcome('jwt-value'), 'Respuesta válida');
        expect(paths, ['/users/check-token', '/users/welcome']);
      },
    );

    test('propagates the API message when a request fails', () async {
      final api = AuthApi(
        client: MockClient(
          (_) async => http.Response(
            jsonEncode({'message': 'Credenciales incorrectas'}),
            409,
          ),
        ),
      );

      await expectLater(
        api.login(email: 'test@example.com', password: 'wrong'),
        throwsA(
          isA<ApiException>()
              .having(
                (error) => error.message,
                'message',
                'Credenciales incorrectas',
              )
              .having((error) => error.statusCode, 'statusCode', 409),
        ),
      );
    });
  });
}
