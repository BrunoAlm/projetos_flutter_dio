import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projetos_flutter_dio/src/modules/chat/chat_message_model.dart';
import 'package:projetos_flutter_dio/src/modules/chat/repositories/chat_repository.dart';

class ChatRepositoryV1 implements ChatRepository {
  final String _collection = 'chat';
  ChatMessageModel chat = ChatMessageModel(
    sendData: DateTime.now(),
    message: '',
    userId: '',
    username: '',
  );
  var db = FirebaseFirestore.instance;

  @override
  Future<void> create(ChatMessageModel chat) async {
    await db.collection(_collection).add(chat.toJson());
  }

  @override
  Stream<QuerySnapshot> listen() {
    return db.collection(_collection).orderBy('send_data').snapshots();
  }
}
