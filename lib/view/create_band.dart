import 'dart:convert';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../controller/bands_controller.dart';
// import '../pages/api_provider.dart';
import '../controller/main_wrapper_controller.dart';
import '../services/bandservice.dart';
import '../utils/color.constants.dart';

class CreateBand extends StatefulWidget {
  const CreateBand({super.key});

  @override
  State<CreateBand> createState() => _CreateBandState();
}

class _CreateBandState extends State<CreateBand> {
  // ! อันเดิม
  final BandService bandService = Get.find();
  // final BandsController bandService.bandsController = Get.find<BandsController>();
  // final BandsController bandService.bandsController = Get.put(BandsController());
  final MainWrapperController _mainWrapperController =
      Get.find<MainWrapperController>();
  bool _saving = false;
  XFile? imageFile;
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  // ! Text editing controllers
  final nameController = TextEditingController();
  final categoryController = TextEditingController();
  // ApiProvider apiProvider = ApiProvider();
  @override
  void initState() {
    super.initState();
    print(categoryController.text);
    print(nameController.text);
    print(imageFile?.path);
    print(bandService.bandsController.createBand.value);
  }

  @override
  void dispose() {
    categoryController.dispose();
    nameController.dispose();
    super.dispose();
  }

  String? _nameValidator(String? fieldContent) {
    RegExp nameRegExp = RegExp(r"^[a-zA-Z0-9_\.\-]*$");
    if (fieldContent?.isEmpty == true || fieldContent?.trim() == "") {
      return "Please enter a Name";
    } else if (!nameRegExp.hasMatch(fieldContent!)) {
      return 'name is not a valid';
    }
    return null;
  }

  String? _categoryValidator(String? fieldContent) {
    RegExp nameRegExp = RegExp(r"^[a-zA-Z0-9_\.\-]*$");
    if (fieldContent?.isEmpty == true || fieldContent?.trim() == "") {
      return "Please enter a Category";
    } else if (!nameRegExp.hasMatch(fieldContent!)) {
      return 'Category is not a valid';
    }
    return null;
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

  Future doCreateBand(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      print(bandService.bandsController.createBand.value);
      if (imageFile != null) {
        var rs = await bandService.bandsController.doCreateBand(
            nameController.text.trim(),
            categoryController.text.trim(),
            imageFile!.path);
        var jsonRes = jsonDecode(rs.body);
        print(rs.body);
        if (rs.statusCode == 200) {
          if (jsonRes['success'] == 1) {
            setState(() {
              _saving = true;
            });
            bandService.bandsController.createBand.value = true;
            print("Success");
            print(bandService.bandsController.createBand.value);
            print(bandService.bandsController.bandid.value);
            print(jsonRes['data']['createBandResults']['band_id']);
            bandService.bandsController.bandid.value =
                jsonRes['data']['createBandResults']['band_id'];
            print(bandService.bandsController.bandid.value);
            await bandService.profileController.getProfile();
            await bandService.bandsController.showMemberInBand();
            // ! redirect
            if (mounted) {
              showCustomSnackBar('Congratulations', 'CreateBand Successfully',
                  ColorConstants.appColors, ContentType.success);
              Future.delayed(const Duration(seconds: 4), () {
                setState(() {
                  _saving = false;
                });
                Get.back();
              });
              // Navigator.of(context).pushReplacement(
              //     MaterialPageRoute(builder: (context) => const LoginScreen()));
            }
          }
          // }
        } else if (rs.statusCode == 409) {
          switch (jsonRes['message']) {
            // !  มีชื่อวงนี้อยู่ใน DB Table Bands อยู่แล้ว
            case "band is already":
              showCustomSnackBar(
                  'Create Band Failed',
                  'That Bands is already in use! Please try with a different one.',
                  Colors.red, // สีแดงหรือสีที่คุณต้องการ
                  ContentType.failure);
              break;
            // ! สามารถสร้างได้วงเดียว
            case "Only one band can be created.":
              showCustomSnackBar(
                  'Create Band Failed',
                  'You Only one band can be created.',
                  Colors.red, // สีแดงหรือสีที่คุณต้องการ
                  ContentType.failure);
              break;
            case "You cannot create a band because you are currently a member of a band.":
              showCustomSnackBar(
                  'Create Band Failed',
                  'You cannot create a band because you are currently a member of a band.',
                  Colors.red, // สีแดงหรือสีที่คุณต้องการ
                  ContentType.failure);
              break;
          }
          // showCustomSnackBar(
          //     'Create Band Failed',
          //     'That Bands is already in use! Please try with a different one.',
          //     Colors.red, // สีแดงหรือสีที่คุณต้องการ
          //     ContentType.failure);
        } else if (rs.statusCode == 400) {
          var jsonRes = json.decode(rs.body);
          print(rs.body);
          if (jsonRes['success'] == 0) {
            showCustomSnackBar(
                'Sign Up Failed',
                "You haven't added a picture yet! Please include a picture.",
                Colors.red, // สีแดงหรือสีที่คุณต้องการ
                ContentType.failure);
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
        } else if (rs.statusCode == 498) {
          showCustomSnackBar(
              'POST FAILED',
              "Invalid token",
              Colors.red, // สีแดงหรือสีที่คุณต้องการ
              ContentType.failure);
          _mainWrapperController.logOut();
          // การส่งข้อมูลไม่สำเร็จ
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
      child: ModalProgressHUD(
        inAsyncCall: _saving,
        progressIndicator: LoadingAnimationWidget.bouncingBall(
          size: 50,
          color: ColorConstants.appColors,
        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text(
              'Create Band',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            leading: IconButton(
              splashRadius: 20,
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.close_rounded,
                color: Colors.black,
              ),
            ),
          ),
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color(0xFFF7F5F4),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
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
                      const SizedBox(height: 30),
                      // ! USERNAME
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          // ! ยังไม่ได้ทำ validator
                          validator: _nameValidator,
                          controller: nameController,
                          obscureText: false,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: "Name",
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 192, 192, 192)),
                            fillColor: const Color.fromARGB(255, 237, 237, 237),
                            filled: true,
                            prefixIcon: const Icon(
                              IconlyBold.profile,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          // ! ยังไม่ได้ทำ validator
                          validator: _categoryValidator,
                          controller: categoryController,
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Category",
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 192, 192, 192)),
                            fillColor: const Color.fromARGB(255, 237, 237, 237),
                            filled: true,
                            prefixIcon: const Icon(
                              IconlyBold.category,
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
                      const SizedBox(height: 30),
                      // borderRadius: BorderRadius.all(Radius.circular(25)),
                      // ! buttonอันเก่า
                      Center(
                        child: ElevatedButton(
                          onPressed: () => doCreateBand(context),
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
                                'Create Band',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
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
                  borderRadius: BorderRadius.circular(30.0),
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
