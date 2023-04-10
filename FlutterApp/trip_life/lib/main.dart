import 'package:flutter/material.dart';
import 'package:trip_life/application/abstract_repositories/abstract_authentication_repository.dart';
import 'package:trip_life/infrastructure/abstracts/abstract_configuration_provider.dart';
import 'package:trip_life/presentation/app.dart';
import 'package:trip_life/presentation/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  await authenticationFromConfiguration();

  runApp(const App());
}

Future<void> authenticationFromConfiguration() async {
  var configurationProvider =
      serviceLocator.get<AbstractConfigurationProvider>();

  String token = configurationProvider.getStringValue("AUTH_TOKEN");

  if (token.isNotEmpty) {
    var authenticationRepository =
        serviceLocator.get<AbstractAuthenticationRepository>();

    await authenticationRepository.saveToken(token);
  }
}
