import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projetos_flutter_dio/core/shared_preferences_config.dart';
import 'package:projetos_flutter_dio/main.dart';
import 'package:projetos_flutter_dio/src/modules/chat/models/message_model.dart';
import 'package:projetos_flutter_dio/src/modules/chat/repositories/chat_repository.dart';

class ChatController {
  final _chatRepository = di<ChatRepository>();
  final ScrollController chatScrollCt = ScrollController();
  final _sharedPrefs = di<SharedPreferencesConfig>();

  init() {
    _sharedPrefs.getUserId();
  }

  Future<void> createChat(MessageModel chat, String collection) async {
    try {
      await _chatRepository.create(chat, collection);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  Stream<QuerySnapshot> listen(String collection) {
    return _chatRepository.listen(collection);
  }

  sendMessage(TextEditingController messageEC, String username,
      String collection) async {
    var message = messageEC.text.trim();
    if (message.isEmpty) return;

    var chat = MessageModel(
      message: message,
      userId: _sharedPrefs.userId,
      username: username,
    );

    await createChat(chat, collection);
    messageEC.clear();
    chatScrollCt.jumpTo(chatScrollCt.position.maxScrollExtent);
  }

  bool isUserMessage(String userId) {
    return _sharedPrefs.userId == userId;
  }
}
