import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String userId;
  final String message;
  final String username;
  final DateTime? sendDate;

  MessageModel({
    this.sendDate,
    required this.message,
    required this.userId,
    required this.username,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      sendDate: (json['send_data'] as Timestamp).toDate(),
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
