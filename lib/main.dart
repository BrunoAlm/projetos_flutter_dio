import 'package:first_proj_flutter_dio/src/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box<dynamic> box;

Future<void> initDB() async {
  box = await Hive.openBox('imc');
}

void main() async {
  await Hive.initFlutter();
  await initDB();
  runApp(const AppWidget());
}
