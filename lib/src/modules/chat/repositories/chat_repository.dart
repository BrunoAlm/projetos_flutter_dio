import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projetos_flutter_dio/src/modules/chat/models/message_model.dart';

abstract interface class ChatRepository {
  Future<void> create(MessageModel chat, String collection);
  Stream<QuerySnapshot> listen(String collection);
}
