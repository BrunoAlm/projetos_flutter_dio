import 'package:projetos_flutter_dio/core/firebase_config.dart';
import 'package:projetos_flutter_dio/src/app_module.dart';
import 'package:projetos_flutter_dio/app_widget.dart';
import 'package:projetos_flutter_dio/src/modules/imc/imc_hive_config.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final di = GetIt.asNewInstance();

void main() async {
  AppModule.start();
  await dotenv.load(fileName: ".env");
  await Hive.initFlutter();
  await di<FirebaseConfig>().init();
  await di<ImcHiveConfig>().initDB();

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const AppWidget());
}
