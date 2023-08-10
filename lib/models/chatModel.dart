import 'dart:convert';

class User {
  String id;
  String name;
  String email;
  String school;
  String pic;
  // DateTime createdAt;
  // DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.school,
    required this.pic,
    // required this.createdAt,
    // required this.updatedAt,
  });

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['_id'],
//       name: json['name'],
//       email: json['email'],
//       school: json['school'],
//       pic: json['pic'],
//       // createdAt: DateTime.parse(json['createdAt']),
//       // updatedAt: DateTime.parse(json['updatedAt']),
//     );
//   }
// }
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '', // Handle null value with default empty string
      name: json['name'] ?? '', // Handle null value with default empty string
      email: json['email'] ?? '', // Handle null value with default empty string
      school: json['school'] ?? '', // Handle null value with default empty string
      pic: json['pic'] ?? '', // Handle null value with default empty string
    );
  }
}


class Message {
  String id;
  User sender;
  String content;
  String chat;
  // DateTime createdAt;
  // DateTime updatedAt;

  Message({
    required this.id,
    required this.sender,
    required this.content,
    required this.chat,
    // required this.createdAt,
    // required this.updatedAt,
  });

//   factory Message.fromJson(Map<String, dynamic> json) {
//     return Message(
//       id: json['_id'],
//       sender: User.fromJson(json['sender']),
//       content: json['content'],
//       chat: json['chat'],
//       // createdAt: DateTime.parse(json['createdAt']),
//       // updatedAt: DateTime.parse(json['updatedAt']),
//     );
//   }
// }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['_id'] ?? '', // Handle null value with default empty string
      sender: User.fromJson(json['sender'] ?? {}), // Handle null value with default empty map
      content: json['content'] ?? '', // Handle null value with default empty string
      chat: json['chat'] ?? '', // Handle null value with default empty string
    );
  }
}

class Chat {
  String id;
  String chatName;
  bool isGroupChat;
  List<User> users;
  // DateTime createdAt;
  // DateTime updatedAt;
  // Message latestMessage;

  Chat({
    required this.id,
    required this.chatName,
    required this.isGroupChat,
    required this.users,
    // required this.createdAt,
    // required this.updatedAt,
    // required this.latestMessage,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['_id'],
      chatName: json['chatName'],
      isGroupChat: json['isGroupChat'],
      users: List<User>.from(json['users'].map((user) => User.fromJson(user))),
      // createdAt: DateTime.parse(json['createdAt']),
      // updatedAt: DateTime.parse(json['updatedAt']),
      // latestMessage: Message.fromJson(json['latestMessage']),
    );
  }
}

