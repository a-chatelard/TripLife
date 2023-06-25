import 'package:http/http.dart';
import 'package:trip_life/infrastructure/abstracts/abstract_web_api.dart';
import 'package:trip_life/infrastructure/abstracts/asbtract_http_client.dart';

class HttpClient implements AbstractHttpClient {
  HttpClient({required AbstractWebApi webApi}) {
    _webApi = webApi;
    _httpClient = Client();
  }

  late final Client _httpClient;
  late final AbstractWebApi _webApi;

  @override
  Future<Response> delete(String endpoint, {Map<String, String>? headers}) {
    return _httpClient.delete(_getUri(endpoint),
        headers: _mergeHeaders(headers));
  }

  @override
  Future<Response> get(String endpoint,
      {Map<String, String>? headers, Map<String, String>? queryParameters}) {
    return _httpClient.get(_getUri(endpoint, queryParameters: queryParameters),
        headers: _mergeHeaders(headers));
  }

  @override
  Future<Response> patch(String endpoint, Object? body,
      {Map<String, String>? headers}) {
    return _httpClient.patch(_getUri(endpoint),
        body: body, headers: _mergeHeaders(headers));
  }

  @override
  Future<Response> post(String endpoint, Object? body,
      {Map<String, String>? headers}) {
    return _httpClient.post(_getUri(endpoint),
        body: body, headers: _mergeHeaders(headers));
  }

  @override
  Future<Response> put(String endpoint, Object? body,
      {Map<String, String>? headers}) {
    return _httpClient.put(_getUri(endpoint),
        body: body, headers: _mergeHeaders(headers));
  }

  Map<String, String> _mergeHeaders(Map<String, String>? headersToMerged) {
    if (headersToMerged == null) {
      return _headers();
    }

    Map<String, String> headers = {..._headers()};
    headers.addAll(headersToMerged);
    return {..._headers()};
  }

  Uri _getUri(String endpoint, {Map<String, dynamic>? queryParameters}) {
    return Uri.https(_webApi.getBaseUrl(), endpoint, queryParameters);
  }

  Map<String, String> _headers() {
    return _webApi.getHeaders() ?? <String, String>{};
  }
}
