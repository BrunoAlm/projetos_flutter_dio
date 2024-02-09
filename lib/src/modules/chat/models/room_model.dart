import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projetos_flutter_dio/src/modules/chat/models/message_model.dart';

class RoomModel {
  final String id;
  final String name;
  final String createdBy;
  final List<MessageModel>? messages;
  final DateTime? createdAt;

  RoomModel({
    required this.id,
    required this.name,
    required this.createdBy,
    this.messages,
    this.createdAt,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id'],
      name: json['name'],
      createdBy: json['created_by'],
      messages: convertToMessageModel(json['messages']),
      createdAt: (json['created_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'room_id': id,
      'name': name,
      'created_by': createdBy,
      'messages': messages,
      'created_at': Timestamp.fromDate(DateTime.now())
    };
  }

  static List<MessageModel> convertToMessageModel(
      Map<String, dynamic> messages) {
    return (messages as List<Map<String, dynamic>>)
        .map(
          (e) => MessageModel.fromJson(e),
        )
        .toList();
  }
}
