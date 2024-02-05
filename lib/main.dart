import 'package:projetos_flutter_dio/src/app_module.dart';
import 'package:projetos_flutter_dio/app_widget.dart';
import 'package:projetos_flutter_dio/src/modules/imc/imc_hive_config.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final di = GetIt.asNewInstance();

void main() async {
  await dotenv.load(fileName: ".env");
  AppModule.start();
  await Hive.initFlutter();

  final hiveConfig = di<ImcHiveConfig>();
  await hiveConfig.initDB();

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const AppWidget());
}
