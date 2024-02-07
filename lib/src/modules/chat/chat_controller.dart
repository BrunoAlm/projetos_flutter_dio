import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projetos_flutter_dio/main.dart';
import 'package:projetos_flutter_dio/src/modules/chat/chat_message_model.dart';
import 'package:projetos_flutter_dio/src/modules/chat/repositories/chat_repository.dart';

class ChatController extends ChangeNotifier {
  final _chatRepository = di<ChatRepository>();

  Future<void> createChat(ChatMessageModel chat) async {
    try {
      await _chatRepository.create(chat);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  Stream<QuerySnapshot> listen() {
    return _chatRepository.listen();
  }
}
