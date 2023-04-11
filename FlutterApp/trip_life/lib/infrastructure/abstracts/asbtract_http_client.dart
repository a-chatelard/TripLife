import 'package:http/http.dart';

abstract class AbstractHttpClient {
  Future<Response> delete(String endpoint, {Map<String, String> headers});
  Future<Response> get(String endpoint,
      {Map<String, String>? headers, Map<String, String>? queryParameters});
  Future<Response> patch(String endpoint, Object? body,
      {Map<String, String>? headers});
  Future<Response> post(String endpoint, Object? body,
      {Map<String, String>? headers});
  Future<Response> put(String endpoint, Object? body,
      {Map<String, String>? headers});
}
