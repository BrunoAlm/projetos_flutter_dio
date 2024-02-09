import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projetos_flutter_dio/src/modules/chat/models/room_model.dart';

abstract interface class RoomRepository {
  Future<void> create(RoomModel room);
  Stream<QuerySnapshot> getAllRooms();
}
