import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projetos_flutter_dio/src/modules/chat/models/message_model.dart';
import 'package:projetos_flutter_dio/src/modules/chat/repositories/chat_repository.dart';

class ChatRepositoryV1 implements ChatRepository {
  var db = FirebaseFirestore.instance;

  @override
  Future<void> create(MessageModel chat, String collection) async {
    await db.collection(collection).add(chat.toJson());
  }

  @override
  Stream<QuerySnapshot> listen(String collection) {
    return db.collection(collection).orderBy('send_data').snapshots();
  }
}
