class User {
  String id;
  String name;
  String email;
  String pic;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.pic,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      pic: json['pic'],
    );
  }
}

class chatMessages {
  String id;
  User sender;
  String content;
  String chatId;
  DateTime createdAt;
  DateTime updatedAt;

  chatMessages({
    required this.id,
    required this.sender,
    required this.content,
    required this.chatId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory chatMessages.fromJson(Map<String, dynamic> json) {
    return chatMessages(
      id: json['_id'],
      sender: User.fromJson(json['sender']),
      content: json['content'],
      chatId: json['chat']['users'][0],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class FetchDataException implements Exception {
  final String message;

  FetchDataException(this.message);

  @override
  String toString() {
    return 'FetchDataException: $message';
  }
}


