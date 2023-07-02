import 'package:trip_life/application/abstract_repositories/abstract_authentication_repository.dart';
import 'package:trip_life/infrastructure/abstracts/abstract_configuration_provider.dart';
import 'package:trip_life/infrastructure/abstracts/abstract_web_api.dart';

class VacationWebApi implements AbstractWebApi {
  VacationWebApi(
      {required AbstractConfigurationProvider configurationProvider,
      required AbstractAuthenticationRepository authenticationRepository}) {
    _baseUrl = configurationProvider.getStringValue("VACATION_API");
    _authenticationRepository = authenticationRepository;
  }

  late final String _baseUrl;
  late final AbstractAuthenticationRepository _authenticationRepository;

  @override
  String getBaseUrl() {
    return _baseUrl;
  }

  @override
  Map<String, String>? getHeaders() {
    return {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer ${_authenticationRepository.readToken()}"
    };
  }
}
