import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessageModel {
  final DateTime? sendData;
  final String message;
  final String userId;
  final String username;

  ChatMessageModel({
    this.sendData,
    required this.message,
    required this.userId,
    required this.username,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      sendData: (json['send_data'] as Timestamp).toDate(),
      message: json['message'],
      userId: json['user_id'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'send_data': Timestamp.fromDate(DateTime.now()),
      'message': message,
      'user_id': userId,
      'username': username,
    };
  }
}
