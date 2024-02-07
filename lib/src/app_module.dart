import 'package:projetos_flutter_dio/core/firebase_config.dart';
import 'package:projetos_flutter_dio/core/shared_preferences_config.dart';
import 'package:projetos_flutter_dio/main.dart';
import 'package:projetos_flutter_dio/src/modules/cep/interceptors/back4app_cep_dio_interceptor.dart';
import 'package:projetos_flutter_dio/src/modules/cep/repositories/back4app_cep_repository.dart';
import 'package:projetos_flutter_dio/src/modules/cep/repositories/viacep_repository.dart';
import 'package:projetos_flutter_dio/src/modules/chat/chat_controller.dart';
import 'package:projetos_flutter_dio/src/modules/chat/repositories/chat_repository.dart';
import 'package:projetos_flutter_dio/src/modules/chat/repositories/chat_repository_v1.dart';
import 'package:projetos_flutter_dio/src/modules/counter/counter_mobx_service.dart';
import 'package:projetos_flutter_dio/src/modules/counter/counter_mobx_store.dart';
import 'package:projetos_flutter_dio/src/modules/imc/imc_hive_config.dart';
import 'package:projetos_flutter_dio/src/modules/marvel/marvel_repository.dart';
import 'package:projetos_flutter_dio/src/modules/posts/repositories/dio/posts_dio_repository.dart';
import 'package:projetos_flutter_dio/src/modules/tarefas/back4app_tarefas_dio_interceptor.dart';
import 'package:projetos_flutter_dio/src/modules/tarefas/tarefas_repository.dart';

class AppModule {
  static void start() {
    // IMC Hive box config
    di.registerLazySingleton(() => ImcHiveConfig());

    // Shared Preferencecs
    di.registerLazySingleton(() => SharedPreferencesConfig());

    // Firebase | FireStore configs
    di.registerLazySingleton(() => FirebaseConfig());

    // Services | Store
    di.registerLazySingleton(() => CounterMobxService());
    di.registerLazySingleton(() => CounterMobXStore());

    // Repositories
    di.registerLazySingleton(() => ViaCepRepository());
    di.registerLazySingleton(() => Back4AppCepRepository());
    di.registerLazySingleton(() => TasksRepository());
    di.registerLazySingleton(() => PostsDioRepository());
    di.registerLazySingleton(() => MarvelRepository());
    di.registerLazySingleton<ChatRepository>(() => ChatRepositoryV1());

    // Controllers
    di.registerLazySingleton(() => ChatController());

    // DIO Interceptors
    di.registerLazySingleton(() => Back4AppTarefasDioInterceptor());
    di.registerLazySingleton(() => Back4AppCepDioInterceptor());
  }
}
