import 'package:first_proj_flutter_dio/main.dart';
import 'package:first_proj_flutter_dio/src/calculate_imc/imc_hive_config.dart';

class AppModule {
  static void start() {
    // IMC Hive config
    di.registerLazySingleton(() => ImcHiveConfig());
  }
}
