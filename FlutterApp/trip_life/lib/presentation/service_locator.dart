import 'package:get_it/get_it.dart';
import 'package:trip_life/application/abstract_repositories/abstract_authentication_repository.dart';
import 'package:trip_life/application/abstract_repositories/abstract_friend_repository.dart';
import 'package:trip_life/application/abstract_repositories/abstract_vacation_repository.dart';
import 'package:trip_life/infrastructure/abstracts/abstract_configuration_provider.dart';
import 'package:trip_life/infrastructure/abstracts/abstract_local_store.dart';
import 'package:trip_life/infrastructure/abstracts/abstract_web_api.dart';
import 'package:trip_life/infrastructure/abstracts/asbtract_http_client.dart';
import 'package:trip_life/infrastructure/repositories/authentication_repository.dart';
import 'package:trip_life/infrastructure/repositories/friend_repository.dart';
import 'package:trip_life/infrastructure/repositories/vacation_repository.dart';
import 'package:trip_life/presentation/data_sources/dotenv_configuration_provider.dart';
import 'package:trip_life/presentation/data_sources/http_client.dart';
import 'package:trip_life/presentation/data_sources/shared_preferences_local_store.dart';
import 'package:trip_life/presentation/data_sources/web_apis/authentication_web_api.dart';
import 'package:trip_life/presentation/data_sources/web_apis/friend_web_api.dart';
import 'package:trip_life/presentation/data_sources/web_apis/vacation_web_api.dart';

GetIt serviceLocator = GetIt.instance;

Future<void> setupServiceLocator() async {
  serviceLocator.registerSingleton<AbstractLocalStore>(
      await SharedPreferencesLocalStore.create(),
      signalsReady: true);
  serviceLocator.registerSingleton<AbstractConfigurationProvider>(
      await DotEnvConfigurationProvider.create(),
      signalsReady: true);

  serviceLocator.registerSingleton<AbstractWebApi>(
      AuthenticationWebApi(
          configurationProvider:
              serviceLocator.get<AbstractConfigurationProvider>()),
      instanceName: "AuthenticationWepApi");

  serviceLocator.registerSingleton<AbstractHttpClient>(
      HttpClient(
          webApi: serviceLocator.get<AbstractWebApi>(
              instanceName: "AuthenticationWepApi")),
      instanceName: "AuthenticationHttpClient");

  serviceLocator.registerSingleton<AbstractAuthenticationRepository>(
      AuthenticationRepository(
          localStore: serviceLocator.get<AbstractLocalStore>(),
          httpClient: serviceLocator.get<AbstractHttpClient>(
              instanceName: "AuthenticationHttpClient")));

  serviceLocator.registerSingleton<AbstractWebApi>(
      FriendWebApi(
          configurationProvider:
              serviceLocator.get<AbstractConfigurationProvider>(),
          authenticationRepository:
              serviceLocator.get<AbstractAuthenticationRepository>()),
      instanceName: "FriendWepApi");

  serviceLocator.registerSingleton<AbstractHttpClient>(
      HttpClient(
          webApi:
              serviceLocator.get<AbstractWebApi>(instanceName: "FriendWepApi")),
      instanceName: "FriendHttpClient");

  serviceLocator.registerSingleton<AbstractFriendRepository>(FriendRepository(
      httpClient: serviceLocator.get<AbstractHttpClient>(
          instanceName: "FriendHttpClient")));

  serviceLocator.registerSingleton<AbstractWebApi>(
      VacationWebApi(
          configurationProvider:
              serviceLocator.get<AbstractConfigurationProvider>(),
          authenticationRepository:
              serviceLocator.get<AbstractAuthenticationRepository>()),
      instanceName: "VacationWepApi");

  serviceLocator.registerSingleton<AbstractHttpClient>(
      HttpClient(
          webApi: serviceLocator.get<AbstractWebApi>(
              instanceName: "VacationWepApi")),
      instanceName: "VacationHttpClient");

  serviceLocator.registerSingleton<AbstractVacationRepository>(
      VacationRepository(
          httpClient: serviceLocator.get<AbstractHttpClient>(
              instanceName: "VacationHttpClient")));
}
