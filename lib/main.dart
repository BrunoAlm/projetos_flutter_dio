import 'package:first_proj_flutter_dio/src/app_module.dart';
import 'package:first_proj_flutter_dio/src/app_widget.dart';
import 'package:first_proj_flutter_dio/src/calculate_imc/imc_hive_config.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

final di = GetIt.asNewInstance();

void main() async {
  AppModule.start();
  await Hive.initFlutter();

  final ImcHiveConfig hiveConfig = di();
  await hiveConfig.initDB();

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const AppWidget());
}
