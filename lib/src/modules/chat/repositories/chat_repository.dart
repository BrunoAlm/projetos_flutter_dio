import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projetos_flutter_dio/src/modules/chat/chat_message_model.dart';

abstract interface class ChatRepository {
  Future<void> create(ChatMessageModel chat);
  Stream<QuerySnapshot> listen();
}
