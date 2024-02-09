import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:projetos_flutter_dio/core/shared_preferences_config.dart';
import 'package:projetos_flutter_dio/main.dart';
import 'package:projetos_flutter_dio/src/modules/chat/repositories/room_repository.dart';
import 'package:projetos_flutter_dio/src/modules/chat/models/room_model.dart';
import 'package:uuid/uuid.dart';

class RoomController {
  final _sharedPrefs = di<SharedPreferencesConfig>();
  // final _chatRepository = di<ChatRepository>();
  final _roomRepository = di<RoomRepository>();

  init() {
    _sharedPrefs.getUserId();
  }

  Future<void> createRoom(String roomName, String createdBy) async {
    try {
      var uuid = const Uuid();

      var room = RoomModel(
        id: uuid.v4(),
        name: roomName,
        createdBy: createdBy,
      );

      await _roomRepository.create(room);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Stream<QuerySnapshot> listen() {
    return _roomRepository.getAllRooms();
  }
}
