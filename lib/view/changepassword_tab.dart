import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../controller/main_wrapper_controller.dart';
import '../services/bandservice.dart';
import '../utils/color.constants.dart';

class ChangePasswordTab extends StatefulWidget {
  const ChangePasswordTab({super.key});

  @override
  State<ChangePasswordTab> createState() => _ChangePasswordTabState();
}

class _ChangePasswordTabState extends State<ChangePasswordTab> {
  final MainWrapperController _mainWrapperController =
      Get.find<MainWrapperController>();
  final BandService bandService = Get.find();
  final _oldpasswordController = TextEditingController();
  final _newpasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  bool _saving = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // _textcommentController.dispose();
    _oldpasswordController.dispose();
    _newpasswordController.dispose();
  }

  String? _passwordValidator(String? fieldContent) {
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

// ? void showCustomSnackBar(String title, String message, Color color)
  void showCustomSnackBar(
      String title, String message, Color color, ContentType contentType) {
    // late final ContentType contentType;
    final snackBar = SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: contentType,
        color: color,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  Widget _appBarPost(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      IconButton(
          splashRadius: 20,
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.close_rounded)),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: _saving,
        progressIndicator: LoadingAnimationWidget.bouncingBall(
          size: 50,
          color: ColorConstants.appColors,
        ),
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Center(
                  child: Column(
                    children: [
                      _appBarPost(context),
                      const SizedBox(height: 70.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: TextFormField(
                          style: TextStyle(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.black // สีสำหรับ Light Theme
                                  : ColorConstants.appColors),
                          validator: _passwordValidator,
                          controller: _oldpasswordController,
                          obscureText: hidePassword,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            hintText: "Old Password",
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
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // ! CONFIRM PASSWORD
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: TextFormField(
                          style: TextStyle(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.black // สีสำหรับ Light Theme
                                  : ColorConstants.appColors),
                          validator: _passwordValidator,
                          controller: _newpasswordController,
                          obscureText: hideConfirmPassword,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            hintText: "New Password",
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 192, 192, 192)),
                            fillColor: const Color.fromARGB(255, 237, 237, 237),
                            filled: true,
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Color(0xFFB3B3B3),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(hideConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              color: Color(0xFFB3B3B3),
                              onPressed: () {
                                setState(() {
                                  hideConfirmPassword = !hideConfirmPassword;
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
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: () {
                          changePassword(context);
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
                            width: 350,
                            height: 50,
                            alignment: Alignment.center,
                            child: const Text(
                              'Saved',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> changePassword(BuildContext context) async {
    print(_oldpasswordController.text);
    print(_newpasswordController.text);
    if (_formKey.currentState!.validate()) {
      try {
        var rs = await bandService.profileController.changePassword(
          _oldpasswordController.text.trim(),
          _newpasswordController.text.trim(),
        );
        var jsonRes = json.decode(rs.body);
        print(rs.body);
        if (rs.statusCode == 200) {
          if (jsonRes['success'] == 1) {
            if (mounted) {
              setState(() {
                _saving = true;
              });
              showCustomSnackBar(
                  'Congratulations',
                  'ChangePassword Successfully',
                  ColorConstants.appColors,
                  ContentType.success);
              Future.delayed(const Duration(seconds: 4), () async {
                if (mounted) {
                  setState(() {
                    _saving = false;
                  });
                  Get.back();
                }
              });
            }
          }
        } else if (rs.statusCode == 498) {
          showCustomSnackBar('Changepassword FAILED', 'Invalid token',
              Colors.red, ContentType.failure);
          _mainWrapperController.logOut();
          // การส่งข้อมูลไม่สำเร็จ
        } else if (jsonRes['success'] == 0) {
          if (jsonRes['data'] == 'Please Check old password') {
            showCustomSnackBar('Changepassword FAILED',
                'Please Check old password', Colors.red, ContentType.failure);
          } else if (jsonRes['data'] ==
              'Old password and new password must not be duplicated.') {
            showCustomSnackBar(
                'Changepassword FAILED',
                'Old password and new password must not be duplicated.',
                Colors.red,
                ContentType.failure);
          }
        } else {
          print('Failed to update profile. Status code: ${rs.statusCode}');
          print(rs.body);
        }
      } catch (e) {
        // เกิดข้อผิดพลาดในการเชื่อมต่อ
        print('Error update profilet: $e');
      }
    }
  }
}
