import 'package:projetos_flutter_dio/core/firebase_config.dart';
import 'package:projetos_flutter_dio/src/modules/chat/chat_model.dart';

class ChatRepository {
  final FirebaseConfig _firebaseConfig;

  ChatRepository(this._firebaseConfig);
  final String _collection = 'chat';
  ChatModel chat = ChatModel(username: '', message: '');

  Future<void> create() async {
    await _firebaseConfig.db.collection(_collection).add(chat.toJson());
  }

  // Future<List<ChatModel>> list() async {
  //   var result = await _firebaseConfig.db.collection(_collection).get();
  //   var test = Stream.fromIterable(result.docs);
  //   return ChatModel.fromJson();
  // }
}
