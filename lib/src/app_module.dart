import 'package:projetos_flutter_dio/main.dart';
import 'package:projetos_flutter_dio/src/modules/imc/imc_hive_config.dart';

class AppModule {
  static void start() {
    // IMC Hive config
    di.registerLazySingleton(() => ImcHiveConfig());
  }
}
