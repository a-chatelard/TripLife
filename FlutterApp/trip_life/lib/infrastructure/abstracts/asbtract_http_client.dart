import 'package:http/http.dart';

abstract class AbstractHttpClient {
  Future<Response> delete(String endpoint, {headers = Map<String, String>});
  Future<Response> get(String endpoint,
      {headers = Map<String, String>, queryParameters = Map<String, String>});
  Future<Response> patch(String endpoint, Object? body,
      {headers = Map<String, String>});
  Future<Response> post(String endpoint, Object? body,
      {headers = Map<String, String>});
  Future<Response> put(String endpoint, Object? body,
      {headers = Map<String, String>});
}
