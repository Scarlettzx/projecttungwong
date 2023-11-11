import 'dart:convert';
import 'dart:io';
// import 'dart:developer';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
import 'package:project/pages/login_screen.dart';
import 'package:project/utils/color.constants.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../data/models/dropdown_province_model.dart';
import 'api_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _saving = false;
  XFile? imageFile;
  final ImagePicker _picker = ImagePicker();
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  final _formKey = GlobalKey<FormState>();
  String? selectedValueProvince;
  String? selectedValuePosition = "none";
  // ! Text editing controllers
  final GlobalKey<FormState> _otpFormKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final countryController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  ApiProvider apiProvider = ApiProvider();

  @override
  void initState() {
    super.initState();
  }

  String? _provinceValidator(String? fieldContent) {
    if (fieldContent?.isEmpty == true || fieldContent == null) {
      return 'Please select on Province ';
    }
    return null;
  }

  String? _usernameValidator(String? fieldContent) {
    RegExp usernameRegExp = RegExp(r"^[a-zA-Z0-9_\.\-]*$");
    if (fieldContent?.isEmpty == true || fieldContent?.trim() == "") {
      return "Please enter a username";
    } else if (!usernameRegExp.hasMatch(fieldContent!)) {
      return 'username is not a valid';
    }
    return null;
  }

  String? _emailValidator(String? fieldContent) {
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

  String? _otplValidator(String? fieldContent) {
    if (fieldContent == null || fieldContent.isEmpty) {
      return 'Please enter otp';
    }
    RegExp otpRegExp =
        RegExp(r'^[0-9]{6}$'); // OTP ต้องประกอบด้วยตัวเลข 6 หลักเท่านั้น
    if (!otpRegExp.hasMatch(fieldContent)) {
      return 'Please enter a valid OTP (6 digits)';
    }
    return null;
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

  String? _confrimpasswordValidator(String? fieldContent) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (fieldContent!.isEmpty) {
      return 'Please enter password';
    } else if (!regex.hasMatch(fieldContent)) {
      return 'Enter valid password';
    } else if (fieldContent != passwordController.text) {
      return 'Password must be same as above';
    } else {
      return null;
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

  Future doCreateOtp(BuildContext context) async {
    final otpController = TextEditingController();
    if (_formKey.currentState!.validate()) {
      if (imageFile != null) {
        var rs = await apiProvider
            .doCreateOtp(emailController.text.trim().toLowerCase());
        var jsonRes = json.decode(rs.body);
        if (jsonRes['success'] == 1) {
          setState(() {
            _saving = true;
          });
          showCustomSnackBar('Otp', 'Please check the otp code at gmail.',
              ColorConstants.appColors, ContentType.warning);
          Future.delayed(new Duration(seconds: 4), () {
            setState(() {
              _saving = false;
            });
            otpController.clear();
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Otp'),
                content: Form(
                  key: _otpFormKey,
                  child: TextFormField(
                    cursorColor: ColorConstants.appColors,
                    validator: _otplValidator,
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      labelText: 'Otp',
                      hintMaxLines: 1,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 4.0),
                      ),
                    ),
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_otpFormKey.currentState!.validate()) {
                        doRegister(otpController.text);
                      }
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          });
        } else if (jsonRes['success'] == 0) {
          showCustomSnackBar(
              'Otp Failed',
              'That Email Address is already in use! Please try with a different one.',
              Colors.red, // สีแดงหรือสีที่คุณต้องการ
              ContentType.failure);
        }
      } else {
        showCustomSnackBar(
            'Sign Up Failed',
            "You haven't added a picture yet! Please include a picture.",
            Colors.red, // สีแดงหรือสีที่คุณต้องการ
            ContentType.failure);
      }
    }
  }

  Future doRegister(String otp) async {
    if (_formKey.currentState!.validate()) {
      if (imageFile != null) {
        var rs = await apiProvider.doRegister(
            usernameController.text,
            selectedValueProvince!,
            selectedValuePosition!,
            emailController.text.trim().toLowerCase(),
            passwordController.text.trim(),
            imageFile!.path, otp);
        if (rs.statusCode == 200) {
          print(rs.body);
          var jsonRes = json.decode(rs.body);
          if (jsonRes['success'] == 1) {
            // ! redirect
            if (mounted) {
              showCustomSnackBar('Congratulations', 'Sign up Successfully',
                  ColorConstants.appColors, ContentType.success);

              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            }
          }
          // }
        } else if (rs.statusCode == 409) {
          showCustomSnackBar(
              'Sign Up Failed',
              'That Email Address is already in use! Please try with a different one.',
              Colors.red, // สีแดงหรือสีที่คุณต้องการ
              ContentType.failure);
        } else if (rs.statusCode == 400) {
          var jsonRes = json.decode(rs.body);
          print(rs.body);
          if (jsonRes['success'] == 0) {
            if(jsonRes['message'] == 'Missing verification code'){
            showCustomSnackBar(
                'Sign Up Failed',
                "Missing verification code",
                Colors.red, // สีแดงหรือสีที่คุณต้องการ
                ContentType.failure);
            }else{
            showCustomSnackBar(
                'Sign Up Failed',
                "You haven't added a picture yet! Please include a picture.",
                Colors.red, // สีแดงหรือสีที่คุณต้องการ
                ContentType.failure);

            }
          } else if (jsonRes['message'] == 'Invalid image file type') {
            showCustomSnackBar(
                'Sign Up Failed',
                "Invalid image file type",
                Colors.red, // สีแดงหรือสีที่คุณต้องการ
                ContentType.warning);
          }
        } else if (rs.statusCode == 500) {
          showCustomSnackBar(
              'Sign Up Failed',
              "Invalid file type. Only JPEG and PNG and JPG files are allowed.",
              Colors.red, // สีแดงหรือสีที่คุณต้องการ
              ContentType.failure);
        }
      } else {
        showCustomSnackBar(
            'Sign Up Failed',
            "You haven't added a picture yet! Please include a picture.",
            Colors.red, // สีแดงหรือสีที่คุณต้องการ
            ContentType.failure);
      }
    }
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
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFF7F5F4),
        body: SafeArea(
          child: ModalProgressHUD(
            inAsyncCall: _saving,
            progressIndicator: LoadingAnimationWidget.bouncingBall(
              size: 50,
              color: ColorConstants.appColors,
            ),
            child: SingleChildScrollView(
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      //! HEADER (SIGNUP)
                      const Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      Stack(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.transparent,
                            backgroundImage: imageFile == null
                                ? Image.asset('assets/default.jpg').image
                                : Image.file(File(imageFile!.path).absolute,
                                        fit: BoxFit.cover)
                                    .image,
                          ),
                          Positioned(
                            bottom: 15,
                            right: 15,
                            child: InkWell(
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.teal,
                                size: 20,
                              ),
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: ((builder) => bottomsheet()));
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // ! USERNAME
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          // ! ยังไม่ได้ทำ validator
                          validator: _usernameValidator,
                          controller: usernameController,
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "Username",
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 192, 192, 192)),
                            fillColor: const Color.fromARGB(255, 237, 237, 237),
                            filled: true,
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Color(0xFFB3B3B3),
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
                      // ! DROPDOWN SELECT PROVINCE
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: FutureBuilder<List<ProvinceDropdownModel>>(
                          future: apiProvider.fetchProvinceData(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return DropdownButtonFormField(
                                  validator: _provinceValidator,
                                  menuMaxHeight: 700,
                                  style: TextStyle(
                                    color: ColorConstants.gray600,
                                  ),
                                  // autofocus: true,
                                  icon: Icon(
                                    Icons.arrow_drop_down_circle,
                                    color: ColorConstants.appColors,
                                  ),
                                  // value: selectedValue,
                                  decoration: InputDecoration(
                                    hintText: "Select Province",
                                    hintStyle: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 192, 192, 192)),
                                    fillColor: const Color.fromARGB(
                                        255, 237, 237, 237),
                                    filled: true,
                                    prefixIcon: const Icon(
                                      Icons.location_on,
                                      color: Color(0xFFB3B3B3),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 52, 230, 168),
                                        width: 3,
                                      ),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  items: snapshot.data?.map((e) {
                                    return DropdownMenuItem(
                                        value: e.nameTh.toString(),
                                        child: Text(e.nameTh.toString()));
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValueProvince = value;
                                      print(selectedValueProvince);
                                    });
                                  });
                            }
                            return const CircularProgressIndicator();
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      // !Postion
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: DropdownButtonFormField(
                          menuMaxHeight: 700,
                          style: TextStyle(
                            color: ColorConstants.gray600,
                          ),
                          // autofocus: true,
                          icon: Icon(
                            Icons.arrow_drop_down_circle,
                            color: ColorConstants.appColors,
                          ),
                          // value: selectedValue,
                          decoration: InputDecoration(
                            hintText: "Select Position",
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 192, 192, 192)),
                            fillColor: const Color.fromARGB(255, 237, 237, 237),
                            filled: true,
                            prefixIcon: const Icon(
                              Icons.api,
                              color: Color(0xFFB3B3B3),
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
                          value: selectedValuePosition,
                          items: <String>[
                            'none',
                            'Guitar',
                            'Drum',
                            'Vocal',
                            'Bass',
                            'Piano'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                ));
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              selectedValuePosition = value;
                              print(selectedValuePosition);
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      // ! EMAIL
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: TextFormField(
                          validator: _emailValidator,
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
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // ! PASSWORD
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: TextFormField(
                          validator: _passwordValidator,
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
                          validator: _confrimpasswordValidator,
                          controller: confirmpasswordController,
                          obscureText: hideConfirmPassword,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            hintText: "ConfirmPassword",
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
                      const SizedBox(height: 30),
                      // borderRadius: BorderRadius.all(Radius.circular(25)),
                      // ! buttonอันเก่า
                      Center(
                        child: ElevatedButton(
                          // onPressed: doRegister,
                          onPressed: () => doCreateOtp(context),
                          // showDialog<String>(
                          //   context: context,
                          //   builder: (BuildContext context) => AlertDialog(
                          //     title: const Text('Otp'),
                          //     content: TextFormField(
                          //       cursorColor: ColorConstants.appColors,
                          //       validator: _otplValidator,
                          //       controller: otpController,
                          //       keyboardType: TextInputType.number,
                          //       maxLines: 1,
                          //       decoration: const InputDecoration(
                          //         labelText: 'Otp',
                          //         hintMaxLines: 1,
                          //         border: OutlineInputBorder(
                          //           borderSide: BorderSide(
                          //               color: Colors.green, width: 4.0),
                          //         ),
                          //       ),
                          //     ),
                          //     actions: <Widget>[
                          //       TextButton(
                          //         onPressed: () =>
                          //             Navigator.pop(context, 'Cancel'),
                          //         child: const Text('Cancel'),
                          //       ),
                          //       TextButton(
                          //         onPressed: () => Navigator.pop(context, 'OK'),
                          //         child: const Text('OK'),
                          //       ),
                          //     ],
                          //   ),

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
                                'SignUp',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // ! GO TO SCREEN LOGIN
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(
                              color: Color(0xFF6D798E),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Sign In',
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
        ),
      ),
    );
  }

  Widget bottomsheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            'Choose Picked Photo',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Ink(
                decoration: ShapeDecoration(
                  color: Colors.teal, // สีพื้นหลังเมื่อกด
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(30.0), // ปรับค่าตามความต้องการ
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    chooseImage(ImageSource.gallery);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.image,
                            color: Colors.white), // สีไอคอนเป็นสีขาว
                        SizedBox(width: 8), // ระยะห่างระหว่างไอคอนกับตัวหนังสือ
                        Text(
                          'Gallery',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white, // สีตัวหนังสือเป็นสีขาว
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  // ฟังก์ชันเรียกใช้กล้องหรือแกลเรียมเพื่อเลือกรูปภาพ
  // Function to take a photo or pick an image from the gallery
  Future<void> chooseImage(ImageSource source) async {
    BuildContext? contextRef = context;
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      print('before setstep');
      if (pickedFile != null) {
        setState(() {
          imageFile = pickedFile;
          _saving = true;
        });
      }

      Navigator.pop(contextRef);
      Future.delayed(new Duration(seconds: 4), () {
        setState(() {
          _saving = false;
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
