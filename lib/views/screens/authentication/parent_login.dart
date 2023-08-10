import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unoquide/common/config/shared-services.dart';
import 'package:unoquide/common/services/login.dart';

import '../../../common/config/color_palette.dart.dart';



class ParentLogin extends StatefulWidget {
  const ParentLogin({Key? key}) : super(key: key);

  @override
  State<ParentLogin> createState() => _ParentLoginState();
}

class _ParentLoginState extends State<ParentLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  String? authToken;
  bool isVisible = false;
  parentLogin() async {
    if (_emailController.text != '' && _passwordController.text != '') {
      isLoading = true;
      var response =
          await parent_login(_emailController.text, _passwordController.text);
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      putParentTokenToGlobal(response.token);
      Fluttertoast.showToast(
          msg: response.message as String,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);

      isLoading = false;
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
    return isLoading
        ? Container(
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            backgroundColor: AppTheme().backgroundColor,
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          'assets/Images/Authentication/parent_login.png'))),
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
                                            hintText: 'Parent UID',
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30.0))),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 217, 217, 217),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: TextFormField(
                                        controller: _passwordController,
                                        obscureText: true,
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
                                            hintText: 'Password',
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
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30.0))),
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    /// TODO: Implement Tap
                                    parentLogin();
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 15),
                                    width: MediaQuery.of(context).size.width *
                                        0.20,
                                    height: 25,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 48, 38, 38),
                                        borderRadius:
                                            BorderRadius.circular(30)),
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
          );
  }
}
