import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projetos_flutter_dio/src/modules/chat/repositories/room_repository.dart';
import 'package:projetos_flutter_dio/src/modules/chat/models/room_model.dart';

class RoomRepositoryV1 implements RoomRepository {
  final String _collection = 'rooms';
  var db = FirebaseFirestore.instance;

  @override
  Future<void> create(RoomModel room) async {
    await db.collection("$_collection\\${room.name}").add(room.toJson());

    // Obtém a contagem de documentos na coleção "all_rooms"
    final allRoomsCount = (await db.collection('all_rooms').get()).docs.length;
    final roomId = allRoomsCount + 1;
    await db.collection("all_rooms").add(
      {"room_name": "$_collection\\${room.name}", "room_id": roomId},
    );
  }

  @override
  Stream<QuerySnapshot> getAllRooms() {
    return db.collection('all_rooms').snapshots();
  }
}
