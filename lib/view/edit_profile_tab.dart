import 'dart:convert';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/Textcustom.dart';
import '../controller/main_wrapper_controller.dart';
import '../data/models/dropdown_province_model.dart';
import '../pages/api_provider.dart';
import '../services/bandservice.dart';
import '../utils/color.constants.dart';
import '../utils/config.dart';

class EditProfileTab extends StatefulWidget {
  const EditProfileTab({super.key});

  @override
  State<EditProfileTab> createState() => _EditProfileTabState();
}

class _EditProfileTabState extends State<EditProfileTab> {
  bool _saving = false;
  final nameController = TextEditingController();
  final categoryController = TextEditingController();
  final BandService bandService = Get.find();
  XFile? imageFile;
  final ImagePicker _picker = ImagePicker();
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  final _formKey = GlobalKey<FormState>();
  String? selectedValueProvince;
  String? selectedValuePosition;
  // ! Text editing controllers
  final usernameController = TextEditingController();
  // final emailController = TextEditingController();
  // final countryController = TextEditingController();
  // final passwordController = TextEditingController();
  // final confirmpasswordController = TextEditingController();
  ApiProvider apiProvider = ApiProvider();
  final MainWrapperController _mainWrapperController =
      Get.find<MainWrapperController>();
  @override
  void initState() {
    super.initState();
    // _assetImagesDevice();
    // กำหนดค่าเริ่มต้นให้ usernameController
    if (bandService.bandsController.isBand.value == false) {
      usernameController.text =
          bandService.profileController.profileList[0].userName;
      selectedValueProvince =
          bandService.profileController.profileList[0].userCountry;
      selectedValuePosition =
          bandService.profileController.profileList[0].userPosition;
    } else if (bandService.bandsController.isBand.value == true) {
      nameController.text = bandService.bandsController.bandList[0].bandName;
      categoryController.text =
          bandService.bandsController.bandList[0].bandCategory;
    }
  }
  // usernameController = TextEditingController();
  // _textcommentController.addListener(() {
  //   if (_textcommentController.text.isNotEmpty) {
  //     print(_textcommentController.text);
  //     _commentspostscontroller.isIconButtonEnabled.value =
  //         true; // ถ้ามีข้อความ กำหนดให้ปุ่มสามารถกดได้
  //   } else {
  //     _commentspostscontroller.isIconButtonEnabled.value =
  //         false; // ถ้าไม่มีข้อความ กำหนดให้ปุ่มไม่สามารถกดได้
  //   }
  // });

  @override
  void dispose() {
    super.dispose();
    // _textcommentController.dispose();
    usernameController.dispose();
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

  String? _usernameValidator(String? fieldContent) {
    RegExp usernameRegExp = RegExp(r"^[a-zA-Z0-9_\.\-]*$");
    if (fieldContent?.isEmpty == true || fieldContent?.trim() == "") {
      return "Please enter a username";
    } else if (!usernameRegExp.hasMatch(fieldContent!)) {
      return 'username is not a valid';
    }
    return null;
  }

  String? _provinceValidator(String? fieldContent) {
    if (fieldContent?.isEmpty == true || fieldContent == null) {
      return 'Please select on Province ';
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
                  child: (bandService.bandsController.isBand.value == false)
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Column(
                              children: [
                                _appBarPost(context, _formKey),
                                const SizedBox(height: 10.0),
                                Stack(
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: bandService
                                                      .profileController
                                                      .profileList[0]
                                                      .userAvatar !=
                                                  "" &&
                                              imageFile == null
                                          ? Image.network(
                                                  '${Config.getImage}${bandService.profileController.profileList[0].userAvatar}')
                                              .image
                                          : Image.file(
                                                  File(imageFile!.path)
                                                      .absolute,
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
                                              builder: ((builder) =>
                                                  bottomsheet()));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 40),
                                // ! USERNAME
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    // ! ยังไม่ได้ทำ validator
                                    // initialValue:
                                    //     'Complete the story from here...', // <-- SEE HERE
                                    validator: _usernameValidator,
                                    controller: usernameController,
                                    obscureText: false,
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      hintText: "Username",
                                      hintStyle: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 192, 192, 192)),
                                      fillColor: const Color.fromARGB(
                                          255, 237, 237, 237),
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
                                          color:
                                              Color.fromARGB(255, 52, 230, 168),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: FutureBuilder<
                                      List<ProvinceDropdownModel>>(
                                    future: apiProvider.fetchProvinceDatad(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return DropdownButtonFormField(
                                            validator: _provinceValidator,
                                            value: selectedValueProvince,
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
                                                  color: Color.fromARGB(
                                                      255, 192, 192, 192)),
                                              fillColor: const Color.fromARGB(
                                                  255, 237, 237, 237),
                                              filled: true,
                                              prefixIcon: const Icon(
                                                Icons.location_on,
                                                color: Color(0xFFB3B3B3),
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 52, 230, 168),
                                                  width: 3,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                            ),
                                            items: snapshot.data?.map((e) {
                                              return DropdownMenuItem(
                                                  value: e.nameTh.toString(),
                                                  child: Text(
                                                      e.nameTh.toString()));
                                            }).toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                selectedValueProvince = value;
                                                print(selectedValueProvince);
                                              });
                                            });
                                      }
                                      return LoadingAnimationWidget
                                          .dotsTriangle(
                                        size: 50,
                                        color: ColorConstants.appColors,
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 20),
                                // !Postion
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: DropdownButtonFormField(
                                    value: selectedValuePosition,
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
                                          color: Color.fromARGB(
                                              255, 192, 192, 192)),
                                      fillColor: const Color.fromARGB(
                                          255, 237, 237, 237),
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
                                          color:
                                              Color.fromARGB(255, 52, 230, 168),
                                          width: 3,
                                        ),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                    items: <String>[
                                      'none',
                                      'Guitar',
                                      'Drum',
                                      'Vocal',
                                      'Bass',
                                      'Piano'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
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
                                ElevatedButton(
                                  onPressed: () => editProfile(context),
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100))),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(colors: [
                                          Color.fromARGB(255, 56, 202, 229),
                                          Color.fromARGB(255, 93, 208, 1183)
                                        ]),
                                        borderRadius:
                                            BorderRadius.circular(100)),
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
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Column(
                              children: [
                                _appBarPost(context, _formKey),
                                const SizedBox(height: 10.0),
                                Stack(
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: bandService
                                                      .bandsController
                                                      .bandList[0]
                                                      .bandAvatar !=
                                                  "" &&
                                              imageFile == null
                                          ? Image.network(
                                                  '${Config.getImageBand}${bandService.bandsController.bandList[0].bandAvatar}')
                                              .image
                                          : Image.file(
                                                  File(imageFile!.path)
                                                      .absolute,
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
                                              builder: ((builder) =>
                                                  bottomsheet()));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 30),
                                // ! USERNAME
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    // ! ยังไม่ได้ทำ validator
                                    validator: _nameValidator,
                                    controller: nameController,
                                    obscureText: false,
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      hintText: "Name",
                                      hintStyle: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 192, 192, 192)),
                                      fillColor: const Color.fromARGB(
                                          255, 237, 237, 237),
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
                                          color:
                                              Color.fromARGB(255, 52, 230, 168),
                                          width: 3,
                                        ),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    // ! ยังไม่ได้ทำ validator
                                    validator: _categoryValidator,
                                    controller: categoryController,
                                    obscureText: false,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: "Category",
                                      hintStyle: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 192, 192, 192)),
                                      fillColor: const Color.fromARGB(
                                          255, 237, 237, 237),
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
                                          color:
                                              Color.fromARGB(255, 52, 230, 168),
                                          width: 3,
                                        ),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () => editBand(context),
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100))),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(colors: [
                                          Color.fromARGB(255, 56, 202, 229),
                                          Color.fromARGB(255, 93, 208, 1183)
                                        ]),
                                        borderRadius:
                                            BorderRadius.circular(100)),
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
                        )),
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

  Widget _appBarPost(BuildContext context, GlobalKey<FormState> keyForm) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      IconButton(
          splashRadius: 20,
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.close_rounded)),
    ]);
  }

  Future<void> editProfile(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        var rs = await bandService.profileController.editProfile(
            usernameController.text.trim(),
            selectedValueProvince!,
            selectedValuePosition!,
            imageFile?.path);

        var jsonRes = json.decode(rs.body);
        if (rs.statusCode == 200) {
          if (jsonRes['success'] == 1) {
            if (mounted) {
              setState(() {
                _saving = true;
              });
              showCustomSnackBar('Congratulations', 'CreateBand Successfully',
                  ColorConstants.appColors, ContentType.success);
              Future.delayed(const Duration(seconds: 4), () async {
                if (mounted) {
                  // await bandService.profileController.getProfile();
                  // ตรวจสอบว่า State ยังคงอยู่ใน tree
                  setState(() {
                    _saving = false;
                  });
                  _loadData();
                  Get.back();
                }
              });
            }

            print(rs.body);
            // การส่งข้อมูลสำเร็จ
            print('update profile successfully');
            // Get.back();
            // setState(() {});
          } else if (rs.statusCode == 498) {
            showCustomSnackBar('UPADTE PROFILE FAILED', 'Invalid token',
                Colors.red, ContentType.failure);
            _mainWrapperController.logOut();
            // การส่งข้อมูลไม่สำเร็จ
          } else {
            print('Failed to update profile. Status code: ${rs.statusCode}');
            print(rs.body);
          }
        }
      } catch (e) {
        // เกิดข้อผิดพลาดในการเชื่อมต่อ
        print('Error update profilet: $e');
      }
    }
  }

  Future<void> editBand(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        var rs = await bandService.bandsController.editProfileBand(
            nameController.text.trim(),
            categoryController.text.trim(),
            imageFile?.path);

        var jsonRes = json.decode(rs.body);
        if (rs.statusCode == 200) {
          if (jsonRes['success'] == 1) {
            if (mounted) {
              setState(() {
                _saving = true;
              });
              showCustomSnackBar('Congratulations', 'EditProfile Successfully',
                  ColorConstants.appColors, ContentType.success);
              Future.delayed(const Duration(seconds: 4), () async {
                if (mounted) {
                  // await bandService.profileController.getProfile();
                  // ตรวจสอบว่า State ยังคงอยู่ใน tree
                  setState(() {
                    _saving = false;
                  });
                  loadDataBand();
                  Get.back();
                }
              });
            }

            print(rs.body);
            // การส่งข้อมูลสำเร็จ
            print('update profile successfully');
            // Get.back();
            // setState(() {});
          } else if (rs.statusCode == 498) {
            showCustomSnackBar('UPADTE PROFILE FAILED', 'Invalid token',
                Colors.red, ContentType.failure);
            _mainWrapperController.logOut();
            // การส่งข้อมูลไม่สำเร็จ
          } else {
            print('Failed to update profile. Status code: ${rs.statusCode}');
            print(rs.body);
          }
        }
      } catch (e) {
        // เกิดข้อผิดพลาดในการเชื่อมต่อ
        print('Error update profilet: $e');
      }
    }
  }

  _loadData() async {
    setState(() {}); // รีเรนเดอร์หน้าจอ
    await bandService.profileController.getProfile();
    print("bandService.profileController.profileList[0].userName");
    print(bandService.profileController.profileList[0].userName);
  }

  loadDataBand() async {
    setState(() {}); // รีเรนเดอร์หน้าจอ
    await bandService.bandsController.getBand();
    print("bandService.profileController.bandList[0].bandName");
    print(bandService.bandsController.bandList[0].bandName);
  }
}
