import 'dart:convert';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:video_player/video_player.dart';
import '../components/Textcustom.dart';
import '../controller/main_wrapper_controller.dart';
import '../controller/videos_controller.dart';
import '../utils/color.constants.dart';

class UploadVideo extends StatefulWidget {
  const UploadVideo({super.key});

  @override
  State<UploadVideo> createState() => _UploadVideoState();
}

class _UploadVideoState extends State<UploadVideo> {
  final VideosController _videosController = Get.find<VideosController>();
  final MainWrapperController _mainWrapperController =
      Get.find<MainWrapperController>();
  bool _saving = false;
  VideoPlayerController? videocontroller;
  XFile? videoFile;
  final ImagePicker _picker = ImagePicker();
  final _keyForm = GlobalKey<FormState>();
  final TextEditingController _messagecontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    // _isMounted = true; // Set the flag to true when the widget is mounted
    print(videoFile?.path);
  }

  @override
  void dispose() {
    super.dispose();
    // _isMounted = false;
    videocontroller?.pause();
    videocontroller?.dispose();
    _messagecontroller.dispose();
  }

  String? _messageValidator(String? fieldContent) {
    RegExp nameRegExp = RegExp(r"^[a-zA-Z0-9_\-]*$");
    if (fieldContent?.isEmpty == true ||
        fieldContent?.trim() == "" ||
        fieldContent!.trim().length < 5) {
      return "Please enter a Message";
    } else if (!nameRegExp.hasMatch(fieldContent)) {
      return 'Message is not a valid';
    }
    return null;
  }

  Future _submituploadVideo() async {
    if (_keyForm.currentState!.validate()) {
      if (videoFile != null) {
        setState(() {
          _saving = true;
        });
        var rs = await _videosController.doUploadvideo(
            _messagecontroller.text.trim(), videoFile!.path);
        var jsonRes = jsonDecode(rs.body);
        if (rs.statusCode == 200) {
          print("rs.statusCode == 200");
          print(rs.body);
          // ! redirect
          if (mounted) {
            showCustomSnackBar('Congratulations', 'UploadVideo Successfully',
                ColorConstants.appColors, ContentType.success);
            Future.delayed(const Duration(seconds: 4), () async {
              setState(() {
                _saving = false;
              });
              Navigator.of(context).pop();
              await _loadData();
            });
          }
        } else if (rs.statusCode == 498) {
          showCustomSnackBar(
              'POST FAILED',
              "Invalid token",
              Colors.red, // สีแดงหรือสีที่คุณต้องการ
              ContentType.failure);
          _mainWrapperController.logOut();
        } else if (rs.statusCode == 400) {
          switch (jsonRes['message']) {
            case "Video upload is required":
              showCustomSnackBar(
                  'Upload Video Failed',
                  ' Please select video',
                  Colors.red, // สีแดงหรือสีที่คุณต้องการ
                  ContentType.failure);
              break;
            case "Error Cloudinary":
              showCustomSnackBar(
                  'Upload Video Failed',
                  'Error api upload video',
                  Colors.red, // สีแดงหรือสีที่คุณต้องการ
                  ContentType.failure);
              break;
          }
        } else if (rs.statusCode == 409) {
          showCustomSnackBar(
              'Upload Video Failed',
              'Please fill a message',
              Colors.red, // สีแดงหรือสีที่คุณต้องการ
              ContentType.failure);
        }
      } else {
        showCustomSnackBar(
            'Upload Video Failed',
            ' Please select video',
            Colors.red, // สีแดงหรือสีที่คุณต้องการ
            ContentType.failure);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _saving,
      progressIndicator: LoadingAnimationWidget.bouncingBall(
        size: 50,
        color: ColorConstants.appColors,
      ),
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: _keyForm,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                  child: Column(
                children: [
                  _appBarPost(context, _keyForm),
                  const SizedBox(height: 10.0),
                  Expanded(
                    child: Container(
                      // color: Colors.amber,
                      height: double.infinity,
                      // width: size.width * .78,
                      // color: ColorConstants.gray900,

                      child: SingleChildScrollView(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              // color: ColorConstants.gray100,
                              // width: MediaQuery.of(context).size.width / 1.5,
                              // height: MediaQuery.of(context).size.height / 3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  videoFile == null
                                      ? ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                ColorConstants.appColors,
                                            elevation: 5,
                                            shadowColor: Color.fromARGB(
                                                255, 38, 255, 175),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                            ),
                                          ),
                                          onPressed: () {
                                            chooseVideo();
                                          },
                                          icon: const Icon(IconlyBold.video),
                                          label: const Text('Pick Video'))
                                      : ConstrainedBox(
                                          constraints: BoxConstraints(
                                              minWidth: double.infinity,
                                              maxHeight: 500,
                                              minHeight: MediaQuery.of(context)
                                                          .size
                                                          .height >
                                                      600
                                                  ? 30 +
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.05
                                                  : 50),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {});
                                              videocontroller!.value.isPlaying
                                                  ? videocontroller!.pause()
                                                  : videocontroller!.play();
                                            },
                                            child: AspectRatio(
                                              aspectRatio: videocontroller!
                                                  .value.aspectRatio,
                                              child: Stack(
                                                children: [
                                                  VideoPlayer(videocontroller!),
                                                  Positioned(
                                                    top: 15,
                                                    right: 15,
                                                    child: InkWell(
                                                      child: Icon(
                                                        IconlyBold.delete,
                                                        color: ColorConstants
                                                            .unfollow,
                                                        size: 20,
                                                      ),
                                                      onTap: () {
                                                        setState(() {
                                                          if (videocontroller !=
                                                              null) {
                                                            videocontroller!
                                                                .pause(); // หยุดการเล่นวิดีโอ (ถ้ากำลังเล่น)
                                                            videocontroller!
                                                                .dispose(); // ล้าง videocontroller
                                                            videocontroller =
                                                                null; // เซ็ต videocontroller เป็น null
                                                            videoFile =
                                                                null; // เซ็ต videoFile เป็น null
                                                          }
                                                        });
                                                        print(videoFile?.path);
                                                        // chooseVideo(); // เรียกใหม่เพื่อเลือกวิดีโอใหม่
                                                      },
                                                    ),
                                                  ),
                                                  Center(
                                                      child: videocontroller!
                                                              .value.isPlaying
                                                          ? const SizedBox()
                                                          : const Icon(
                                                              Icons.stop_circle,
                                                              size: 50,
                                                              color:
                                                                  Colors.white,
                                                            )),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 5.0),
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                // ! ยังไม่ได้ทำ validator
                                style: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors
                                            .grey[10] // สีสำหรับ Light Theme
                                        : ColorConstants.appColors),
                                validator: _messageValidator,
                                controller: _messagecontroller,
                                obscureText: false,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: "Message",
                                  hintStyle: const TextStyle(
                                      color:
                                          Color.fromARGB(255, 192, 192, 192)),
                                  fillColor:
                                      const Color.fromARGB(255, 237, 237, 237),
                                  filled: true,
                                  prefixIcon: const Icon(
                                    IconlyBold.chat,
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }

  // ! Function pick video in gallery
  Future<void> chooseVideo() async {
    try {
      final XFile? pickedFile =
          await _picker.pickVideo(source: ImageSource.gallery);
      setState(() {
        _saving = true;
      });
      print('before setstep');
      if (pickedFile != null) {
        // setState(() {
        //   videoFile = pickedFile;
        //   print(videoFile?.path);
        // });
        // เช็คขนาดของไฟล์
        final int fileLength = await File(pickedFile.path).length();
        print(fileLength);
        // ตรวจสอบขนาดไฟล์วิดีโอ
        // เช็คว่าไฟล์มีขนาดเกิน 50 MB หรือไม่
        if (fileLength > 100 * 1024 * 1024) {
          // setState(() {
          //   pickedFile = null;
          // });
          showCustomSnackBar(
              'Upload Video Failed',
              ' The file is too large.',
              Colors.red, // สีแดงหรือสีที่คุณต้องการ
              ContentType.failure);
          Future.delayed(const Duration(seconds: 2), () {
            setState(() {
              _saving = false;
            });
          });
        } else {
          // ตรวจสอบ MIME type
          // ตรวจสอบนามสกุลของไฟล์ว่าเป็น .mp4 หรือไม่
          if (pickedFile.path.toLowerCase().endsWith('.mp4')) {
            setState(() {
              videoFile = pickedFile;
              print(videoFile!.path);
              // _saving = true;
            });
            videocontroller = VideoPlayerController.file(File(videoFile!.path))
              ..initialize().then((_) {
                setState(() {});
                videocontroller!.play();
                videocontroller!.setLooping(true);
              });
            // สามารถแจ้งเตือนหรือทำอะไรก็ตามที่คุณต้องการที่นี่

            Future.delayed(const Duration(seconds: 2), () {
              setState(() {
                _saving = false;
              });
            });
          } else {
            showCustomSnackBar(
                'Upload Video Failed',
                'The file extension must be mp4.',
                Colors.red, // สีแดงหรือสีที่คุณต้องการ
                ContentType.failure);
            // สามารถแจ้งเตือนหรือทำอะไรก็ตามที่คุณต้องการที่นี่
            Future.delayed(const Duration(seconds: 2), () {
              setState(() {
                _saving = false;
              });
            });
          }
        }
      }
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
            _loadData();
          },
          icon: const Icon(Icons.close_rounded)),
      TextButton(
          style: TextButton.styleFrom(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              backgroundColor: ColorConstants.appColors,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0))),
          onPressed: () {
            _submituploadVideo();
          },
          child: const TextCustom(
            text: 'UPLOAD',
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w500,
            letterSpacing: 2,
          )),
    ]);
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

  Future _loadData() async {
    await _videosController.getVideos();
    // setState(() {}); // รีเรนเดอร์หน้าจอ
    // print(_postsController.posts.length);
  }
}
