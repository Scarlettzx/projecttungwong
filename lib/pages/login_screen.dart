import 'dart:convert';
import 'dart:developer';
// import 'dart:js';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:project/core/authentication_manager.dart';
import 'package:project/main_wrapper.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:project/pages/api_provider.dart';
import 'package:project/pages/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:project/pages/home_tab.dart';

import '../controller/main_wrapper_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // late final AuthenticationManager _authManager;
  // ! Text editing controllers
  final MainWrapperController _mainWrapperController =
      Get.find<MainWrapperController>();

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPref();
    // _authManager = Get.find();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  bool hidePassword = true;
  ApiProvider apiProvider = ApiProvider();
  Future doLogin() async {
    if (_formKey.currentState!.validate()) {
      try {
        var rs = await apiProvider.doLogin(
            emailController.text.trim(), passwordController.text.trim());
        var jsonRes = json.decode(rs.body);
        if (rs.statusCode == 200) {
          print(rs.body);
          if (jsonRes['success'] == 1) {
            var mytoken = jsonRes['token'];
            print(mytoken);
            print(mytoken.runtimeType);
            // _authManager.login(mytoken);
            prefs.setString('token', mytoken);
            // _mainWrapperController.setToken(mytoken);
            // ! redirect
            try {
              if (mounted) {
                final snackBar = SnackBar(
                  /// need to set following properties for best effect of awesome_snackbar_content
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: 'Congratulations',
                    message: 'Login Successfully',

                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                    contentType: ContentType.success,
                  ),
                );
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
                  // ! อันเเดิม
                Get.offAll(MainWrapper());
                
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => MainWrapper()),
                // );
              }
            } catch (e) {
              print(e.toString());
            }
            // }
          } else {
            print(jsonRes['data']);
          }
        } else if (rs.statusCode == 401) {
          final snackBar = SnackBar(
            /// need to set following properties for best effect of awesome_snackbar_content
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Login Failed',
              message: 'Please enter your email or password correctly.',

              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
              contentType: ContentType.failure,
            ),
          );
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
          print(jsonRes['data']);
        }
      } catch (error) {
        log(error.toString());
      }
    }
  }

//  String? usernameValidator(String? fieldContent) => fieldContent!.isEmpty ? 'โปรดกรอก Username': null;
  String? emailValidator(String? fieldContent) {
    if (fieldContent!.isEmpty) {
      return 'Please enter Email';
    }
    RegExp emailRegExp =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegExp.hasMatch(fieldContent)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? passwordValidator(String? fieldContent) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (fieldContent!.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(fieldContent)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }

//  String? comfirmpasswordValidator(String? fieldContent) => fieldContent!.isEmpty ? 'โปรด ConfirmPassword': null;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFF7F5F4),
        body: SafeArea(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 180),
                  const Text(
                    "Sign In",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 60),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: emailValidator,
                      controller: emailController,
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 192, 192, 192)),
                        fillColor: const Color.fromARGB(255, 237, 237, 237),
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Color(0xFFB3B3B3),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 52, 230, 168),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                  // ! Fill Password (TextFromField to be used validation)
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: passwordValidator,
                      controller: passwordController,
                      obscureText: hidePassword,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 192, 192, 192)),
                        fillColor: const Color.fromARGB(255, 237, 237, 237),
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Color(0xFFB3B3B3),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(hidePassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                          color: Color(0xFFB3B3B3),
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 52, 230, 168),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                  // !Button Sign in (onPress to be used function future doLogin for passing to nodejs in Database to check Token)
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        doLogin();
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100))),
                      child: Ink(
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [
                              Color.fromARGB(255, 56, 202, 229),
                              Color.fromARGB(255, 93, 208, 1183)
                            ]),
                            borderRadius: BorderRadius.circular(100)),
                        child: Container(
                          width: 320,
                          height: 50,
                          alignment: Alignment.center,
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account",
                        style: TextStyle(
                          color: Color(0xFF6D798E),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()),
                          );
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Color.fromARGB(255, 52, 230, 168),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
