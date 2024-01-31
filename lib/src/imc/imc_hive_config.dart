import 'package:hive_flutter/hive_flutter.dart';

class ImcHiveConfig {
  late Box<dynamic> box;

  Future<void> initDB() async {
    box = await Hive.openBox('imc');
  }
}
