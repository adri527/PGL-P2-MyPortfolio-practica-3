import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiException implements Exception {
  const ApiException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => message;
}

class LoginResponse {
  const LoginResponse({required this.message, required this.token});

  final String message;
  final String token;
}

/// HTTP client for the professor's API. Paths and JSON keys follow its
/// endpoints_api.md specification.
class AuthApi {
  AuthApi({http.Client? client}) : _client = client ?? http.Client();

  static final Uri _baseUri = Uri.parse('https://my-users-api.onrender.com');
  final http.Client _client;

  Future<String> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    final response = await _send(
      _client.post(
        _uri('/users/register'),
        headers: _jsonHeaders,
        body: jsonEncode({
          'fullName': fullName,
          'email': email,
          'pwd': password,
        }),
      ),
    );
    _requireStatus(response, const {201});
    return _message(response);
  }

  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    final response = await _send(
      _client.post(
        _uri('/users/login'),
        headers: _jsonHeaders,
        body: jsonEncode({'email': email, 'pwd': password}),
      ),
    );
    _requireStatus(response, const {200});
    final body = _jsonBody(response);
    final token = body['token'];
    if (token is! String || token.isEmpty) {
      throw const ApiException('La API no devolvió un token de sesión.');
    }
    return LoginResponse(message: _message(response), token: token);
  }

  Future<void> checkToken(String token) async {
    final response = await _send(
      _client.get(_uri('/users/check-token'), headers: _authHeaders(token)),
    );
    _requireStatus(response, const {200});
  }

  Future<String> welcome(String token) async {
    final response = await _send(
      _client.get(_uri('/users/welcome'), headers: _authHeaders(token)),
    );
    _requireStatus(response, const {200});
    return _message(response);
  }

  static const Map<String, String> _jsonHeaders = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
  };

  Map<String, String> _authHeaders(String token) => {
    ..._jsonHeaders,
    'Authorization': 'Bearer $token',
  };

  Uri _uri(String path) => _baseUri.resolve(path);

  Future<http.Response> _send(Future<http.Response> request) async {
    try {
      return await request.timeout(const Duration(seconds: 70));
    } on TimeoutException {
      throw const ApiException(
        'La API está tardando en responder. Inténtalo de nuevo en unos segundos.',
      );
    } on http.ClientException {
      throw const ApiException('No se pudo completar la petición a la API.');
    } on Exception {
      throw const ApiException(
        'No se pudo conectar con la API. Comprueba tu conexión e inténtalo de nuevo.',
      );
    }
  }

  void _requireStatus(http.Response response, Set<int> accepted) {
    if (!accepted.contains(response.statusCode)) {
      throw ApiException(_message(response), statusCode: response.statusCode);
    }
  }

  Map<String, dynamic> _jsonBody(http.Response response) {
    try {
      final body = jsonDecode(utf8.decode(response.bodyBytes));
      if (body is Map<String, dynamic>) return body;
    } on FormatException {
      // Use the general error below for non-JSON responses.
    }
    throw const ApiException('La API devolvió una respuesta no válida.');
  }

  String _message(http.Response response) {
    try {
      final body = jsonDecode(utf8.decode(response.bodyBytes));
      if (body is Map<String, dynamic> && body['message'] is String) {
        return body['message'] as String;
      }
    } on FormatException {
      // Fall through to the status-based message.
    }
    return 'La API respondió con el código ${response.statusCode}.';
  }
}
