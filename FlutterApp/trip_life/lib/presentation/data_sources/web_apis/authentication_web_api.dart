import 'package:trip_life/infrastructure/abstracts/abstract_configuration_provider.dart';
import 'package:trip_life/infrastructure/abstracts/abstract_web_api.dart';

class AuthenticationWebApi implements AbstractWebApi {
  AuthenticationWebApi(
      {required AbstractConfigurationProvider configurationProvider}) {
    _baseUrl = configurationProvider.getStringValue("AUTH_API");
  }

  late final String _baseUrl;

  @override
  String getBaseUrl() {
    return _baseUrl;
  }

  @override
  Map<String, String>? getHeaders() {
    return {"Content-Type": "application/json; charset=UTF-8"};
  }
}
