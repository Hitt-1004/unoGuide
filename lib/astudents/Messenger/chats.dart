import 'package:flutter/material.dart';
import 'package:unoquide/config/shared-services.dart';
import 'package:unoquide/models/apiToken.dart';
import 'package:unoquide/models/chatModel.dart';
import 'package:unoquide/models/users.dart';
import 'package:unoquide/services/chats.dart';
import 'package:unoquide/services/studentData.dart';
import 'package:unoquide/astudents/Messenger/chatMessages.dart';


class Chats extends StatefulWidget {
  const Chats({Key? key, }) : super(key: key);

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {

  List<Chat>? chats;
  bool loading = true;
  late String authToken;
  List<User> searchResults = [];
  String? chatName;
  String? name;
  String _searchText = ''; // State variable to hold the search text

  // Function to handle search text changes
  void _onSearchTextChanged(String searchText) {
    setState(() {
      _searchText = searchText;
    });
  }

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
        print(name),
      }),});
    getEmailFromGlobal().then((value) async{
      print(value);
      authToken = await sendEmailAndGetToken(value);
      print(authToken);
      getChats(authToken).then((value) => {
        setStateIfMounted(() {
          chats = value;
          print(chats);
          loading = false;
          setState(() {});
        })
      });
    });
  }

  void _searchUsers() {
    // Call the API to get users with the entered search text
    getUsers(authToken, _searchText).then((users) {
      setState(() {
        searchResults = users;
      });
    });
  }

  @override
  void dispose() {
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
            title: const Text("Chats",
              style: TextStyle(color: Colors.black),),
              actions: <Widget>[
          // Search bar in the AppBar
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Container(
                    width: 100,
                    child: TextField(
                      onChanged: _onSearchTextChanged,
                      decoration: const InputDecoration(
                        hintText: 'Search User',
                        hintStyle: TextStyle(color: Colors.black),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                IconButton(icon: const Icon(Icons.search),
                  onPressed: () {
                    print("calling search users");
                    _searchUsers();
                    setState(() {});
                    if (searchResults.isNotEmpty) {
                      showMenu(context: context,
                        position: RelativeRect.fromLTRB(
                          MediaQuery.of(context).size.width - 150,
                          MediaQuery.of(context).size.height - 80, 0.0, 0.0,),
                        items: searchResults.map((user) {
                          return PopupMenuItem(
                            child: Text(user.name),
                            onTap: () {
                              // Handle onTap action for the selected user
                              addChats(authToken, user.id).then((chat) {
                                chats?.add(chat);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatMessages(
                                      id: chat.id,
                                      chatName: user.name,
                                      authToken: authToken,
                                    ),
                                  ),
                                );
                                setState(() {});
                              });
                            },
                          );
                        }).toList(),
                      );
                    }else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("No users found")),
                      );
                    }
                  },)
              ],
          ),
        key: scaffoldKey,
        backgroundColor: Colors.white,
        //backgroundColor: const Color.fromARGB(255, 253, 244, 220),
        body: SafeArea(
        top: true,
        child:
            // Expanded(child:
            ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: chats?.length,
              itemBuilder: (context, index){
                final chat = chats?[index];
                print(chat);
                var chatName = chat!.isGroupChat ? chat.chatName
                    : (chat.users[1].name != name ? chat.users[1].name : chat.users[0].name);
                return InkWell(
                  onTap: () {
                    print("Next page");
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatMessages(id: chat.id,
                      chatName: chatName,
                      authToken: authToken,))); },
                  child: ListTile(
                    //tileColor: Colors.grey[200],
                    selectedColor: Colors.grey[200],
                    title: Text(chatName),
                  )
                );
              }
            ),//),
      ),
    );
  }
}
