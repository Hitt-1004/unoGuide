import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unoquide/ateachers/services/data_controller.dart';

import 'package:unoquide/common/config/shared-services.dart';
import 'package:unoquide/common/services/login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unoquide/common/screens/homepage.dart';
import 'package:unoquide/config/shared-services.dart' as config;

import '../../common/config/color_palette.dart.dart';

class StudentLogin extends StatefulWidget {
  const StudentLogin({Key? key}) : super(key: key);

  @override
  State<StudentLogin> createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;
  String? authToken;
  bool isVisible = true;
  studentLogin() async {
    final provider = Provider.of<TeacherClassProvider>(context, listen: false);
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      student_login(_emailController.text, _passwordController.text)
          .then((value) {
        //  provider.setUserType(UserType.student);
        if (value.message.toString() == "Logged In Successfully") {
          putUserTypeToGLobal(user: "student");
          provider.setCurrentUserType("student");
          config.putEmailToGlobal(email: _emailController.text);
          setState(
            () {
              isLoading = false;
              authToken = value.token?.split(' ')[1];
              putTokenToGlobal(token: authToken);
              // putUserTypeToGLobal(user: UserType.student);
            },
          );
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
          Fluttertoast.showToast(
              msg: 'Login Successful',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          setState(() {
            isLoading = false;
            _emailController.clear();
            _passwordController.clear();
          });

          Fluttertoast.showToast(
              msg: value.message as String,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      });
    } else {
      Fluttertoast.showToast(
          msg: "Please fill all the fields",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<UserProvider>(context, listen: false);
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppTheme().backgroundColor,
          resizeToAvoidBottomInset: false,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'assets/Images/Authentication/student_login.png'))),
            child: Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.85,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.15,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/Icons/logo.png'),
                              fit: BoxFit.cover)),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.6,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(100, 217, 217, 217),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          margin: const EdgeInsets.only(top: 2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.30,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 217, 217, 217),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: TextFormField(
                                      controller: _emailController,
                                      //close keyboad on completeing 4 characters
                                      onFieldSubmitted: (value) {
                                        if (value.length == 4) {
                                          FocusScope.of(context).unfocus();
                                        }
                                      },
                                      decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.only(
                                              top: 2, left: 65),
                                          hintStyle: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w900,
                                            fontSize: 20,
                                          ),
                                          hintText: 'Student UID',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0))),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.30,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 217, 217, 217),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: TextFormField(
                                      obscureText: isVisible,
                                      controller: _passwordController,
                                      decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            icon: isVisible
                                                ? const Icon(
                                                    Icons.visibility_off)
                                                : const Icon(Icons.visibility),
                                            onPressed: () {
                                              setState(() {
                                                isVisible = !isVisible;
                                              });
                                            },
                                          ),
                                          contentPadding: const EdgeInsets.only(
                                              top: 2, left: 65),
                                          hintStyle: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w900,
                                            fontSize: 20,
                                          ),
                                          hintText: 'Password',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0))),
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  studentLogin();
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(top: 15),
                                  width:
                                      MediaQuery.of(context).size.width * 0.20,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 48, 38, 38),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: const AutoSizeText(
                                    'Login',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w900,
                                      fontSize: 20,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: isLoading,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }
}
