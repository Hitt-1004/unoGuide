import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:unoquide/ateachers/services/data_controller.dart';
import 'package:unoquide/common/config/color_palette.dart.dart';
import 'package:unoquide/common/config/shared-services.dart';
import 'package:unoquide/common/services/login.dart';
import 'package:http/http.dart' as http;

class TeacherLogin extends StatefulWidget {
  const TeacherLogin({Key? key}) : super(key: key);

  @override
  State<TeacherLogin> createState() => _TeacherLoginState();
}

class _TeacherLoginState extends State<TeacherLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  String? authToken;
  bool isVisible = false;
  teacherLogin() async {
    final provider = Provider.of<TeacherClassProvider>(context, listen: false);
    if (_emailController.text != "" && _passwordController.text != "") {
      var response =
          await teacher_login(_emailController.text, _passwordController.text);
      if (response.message == "Logged In Successfully") {
        //  provider.setUserType(UserType.teacher);
        putUserTypeToGLobal(user: "teacher");
        provider.setCurrentUserType("teacher");
        setState(() {
          isLoading = false;
          authToken = response.token?.split(' ')[1];
          putTokenToGlobal(token: authToken);
          // putUserTypeToGLobal(user: UserType.teacher);
        });
        Fluttertoast.showToast(
            msg: 'Login Successful',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);

        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } else {
        setState(() {
          isLoading = false;
          _emailController.clear();
          _passwordController.clear();
        });

        Fluttertoast.showToast(
            msg: response.message as String,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Please enter your credentials",
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
    final size = MediaQuery.of(context).size;
    // final provider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppTheme().backgroundColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/Images/Authentication/teacher_login.png',
                ),
                fit: BoxFit.contain)),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.85,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: size.height * 0.1),
                        width: size.width * 0.2,
                        height: size.height * 0.15,
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
                            width: size.width * 0.4,
                            height: size.height * 0.55,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(100, 217, 217, 217),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            margin: const EdgeInsets.only(top: 2),
                            child: SingleChildScrollView(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: size.width * 0.30,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 217, 217, 217),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: TextFormField(
                                        controller: _emailController,
                                        decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    top: 2, left: 65),
                                            hintStyle: const TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w900,
                                              fontSize: 20,
                                            ),
                                            hintText: 'Teacher UID',
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30.0))),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Container(
                                      width: size.width * 0.30,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 217, 217, 217),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: TextFormField(
                                        obscureText: isVisible ? false : true,
                                        controller: _passwordController,
                                        decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  isVisible = !isVisible;
                                                });
                                              },
                                              icon: Icon(
                                                isVisible
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: Colors.black,
                                              ),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.only(
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
                                                    BorderRadius.circular(
                                                        30.0))),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        await teacherLogin();
                                        if (authToken != null) {
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              '/home',
                                              (route) => false);
                                        }

                                        /// TODO: Implement Tap
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 30),
                                        width: size.width * 0.20,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 48, 38, 38),
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: const Center(
                                          child: AutoSizeText(
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
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
