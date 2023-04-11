import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:trip_life/infrastructure/abstracts/abstract_configuration_provider.dart';

class DotEnvConfigurationProvider implements AbstractConfigurationProvider {
  DotEnvConfigurationProvider._();

  static Future<DotEnvConfigurationProvider> create() async {
    DotEnvConfigurationProvider configurationProvider =
        DotEnvConfigurationProvider._();

    await dotenv.load(fileName: ".env");

    return configurationProvider;
  }

  static dynamic dotenvConfig;

  @override
  String getStringValue(String key) {
    return dotenv.get(key);
  }
}
