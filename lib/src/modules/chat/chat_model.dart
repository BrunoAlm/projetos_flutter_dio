class ChatModel {
  final String username;
  final String message;

  ChatModel({required this.username, required this.message});

  ChatModel copyWith({String? username, String? message}) {
    return ChatModel(
      username: username ?? this.username,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "message": message,
      };

  ChatModel.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        message = json['message'];
}
