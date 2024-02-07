import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class SharedPreferencesConfig {
  String userId = '';
  late SharedPreferences prefs;

  Future<void> getUserId() async {
    prefs = await SharedPreferences.getInstance();
    if (userId.isEmpty) {
      var uuid = const Uuid();
      userId = uuid.v4();
      prefs.setString('user_id', userId);
    } else {
      userId = prefs.getString('user_id')!;
    }
  }
}
