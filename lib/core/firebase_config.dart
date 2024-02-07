import 'package:firebase_core/firebase_core.dart';
import 'package:projetos_flutter_dio/firebase_options.dart';

class FirebaseConfig {
  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
