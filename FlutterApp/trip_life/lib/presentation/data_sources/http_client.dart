import 'package:http/http.dart';
import 'package:trip_life/infrastructure/abstracts/abstract_web_api.dart';
import 'package:trip_life/infrastructure/abstracts/asbtract_http_client.dart';

class HttpClient implements AbstractHttpClient {
  HttpClient({required AbstractWebApi webApi}) {
    _baseUrl = webApi.getBaseUrl();
    _headers = webApi.getHeaders() ?? <String, String>{};
  }

  late final Client _httpClient;
  late final String _baseUrl;
  late final Map<String, String> _headers;

  @override
  Future<Response> delete(String endpoint, {headers = Map<String, String>}) {
    return _httpClient.delete(_getUri(endpoint),
        headers: _mergeHeaders(headers));
  }

  @override
  Future<Response> get(String endpoint,
      {headers = Map<String, String>, queryParameters = Map<String, String>}) {
    return _httpClient.get(_getUri(endpoint, queryParameters: queryParameters),
        headers: _mergeHeaders(headers));
  }

  @override
  Future<Response> patch(String endpoint, Object? body,
      {headers = Map<String, String>}) {
    return _httpClient.patch(_getUri(endpoint),
        headers: _mergeHeaders(headers));
  }

  @override
  Future<Response> post(String endpoint, Object? body,
      {headers = Map<String, String>}) {
    return _httpClient.post(_getUri(endpoint), headers: _mergeHeaders(headers));
  }

  @override
  Future<Response> put(String endpoint, Object? body,
      {headers = Map<String, String>}) {
    return _httpClient.put(_getUri(endpoint), headers: _mergeHeaders(headers));
  }

  Map<String, String> _mergeHeaders(Map<String, String>? headersToMerged) {
    if (headersToMerged == null) {
      return _headers;
    }

    Map<String, String> headers = {..._headers};
    headers.addAll(headersToMerged);
    return {..._headers};
  }

  Uri _getUri(String endpoint, {queryParameters = Map<String, dynamic>}) {
    return Uri.https(_baseUrl, endpoint, queryParameters);
  }
}
