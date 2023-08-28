import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:http/http.dart' as http;

import '../../../config/shared-services.dart';
import '../../../constants/constants.dart';
import '../../../../astudents/services/studentData.dart';
import 'chatMessagesModel.dart';
import 'messages.dart';


class ChatMessages extends StatefulWidget {
  const ChatMessages({Key? key, required this.id, required this.chatName, required this.authToken}) : super(key: key);
  final String id;
  final String chatName;
  final String authToken;

  @override
  _ChatMessagesState createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {

  List<chatMessages> messages = [];
  bool loading = true;
  late String name;
  late String email;
  late String id;
  final TextEditingController _messageController = TextEditingController();

  setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // loading = false;
    getTokenFromGlobal().then((value) => {
      getStudentData(value).then((value) => {
        name = "${value.firstName} ${value.lastName}",
        email = value.email!,
        id = value.id!
    }),});
      getMessages(widget.authToken, widget.id).then((value) => {
        setStateIfMounted(() {
          messages = value;
          print("Messages: $messages");
          loading = false;
        })
      });
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(
          child: CircularProgressIndicator(),
    )
        : Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(widget.chatName,
          style: const TextStyle(color: Colors.black),),
        ),
        key: scaffoldKey,
        backgroundColor: Colors.white,
        //backgroundColor: const Color.fromARGB(255, 253, 244, 220),
        body: SafeArea(
          top: true,
          child:
              Column(
                children: [
                  Expanded(child: GroupedListView<chatMessages, DateTime>(
                    padding: const EdgeInsets.all(8),
                    reverse: true,
                    order: GroupedListOrder.DESC,
                    elements: messages,
                    groupBy: (message) => DateTime(DateTime.now().year),
                    groupHeaderBuilder: (chatMessages message) => const SizedBox(),
                    itemBuilder: (context, chatMessages message) => Align(
                      alignment: message.chatId == message.sender.id
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                      child: Card(
                        color: message.chatId == message.sender.id? Colors.grey[200] : Colors.blue[800],
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(message.content),
                        ),
                      ),
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Container(
                        color: Colors.grey[200],
                        child: TextField(
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all((12)),
                            hintText: "Type your message here..."
                          ),
                          controller: _messageController,
                          onSubmitted: (text) {
                            var message = chatMessages(
                              content: text,
                              chatId: widget.id,
                              sender: User(
                                id: id,
                                name: name,
                                pic:
                                "https://uno-guide-bucket-0.s3.ap-south-1.amazonaws.com/1668365481442%7C%7C360_F_229758328_7x8jwCwjtBMmC6rgFzLFhZoEpLobB6L8.jpg",
                                email: email,
                              ), id: '', createdAt: DateTime.now(), updatedAt: DateTime.now()
                            );

                            postChatMessage(widget.authToken, text, widget.id).then((_) {
                              setState(() => messages.add(message));
                              _messageController.clear();
                            }).catchError((error) {
                              // Handle the error if message posting fails
                              print('Error posting message: $error');
                            });
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
        ),
      );
  }
}

Future<void> postChatMessage(String authToken, String content, String id) async {
  final String url = '$baseURL/api/message';
  Uri uri = Uri.parse(url);

  final payload = {
    'content': content,
    'chatId': id
  };

  try {
    var response = await http.post(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "Bearer $authToken",
    }, body: jsonEncode(payload));
    if (response.statusCode == 200) {
      // Successfully posted the message
      print('Message posted successfully');
    } else {
      throw FetchDataException('Failed to post message');
    }
  } catch (e) {
    throw FetchDataException('Error: $e');
  }
}