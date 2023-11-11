import 'dart:convert';
import 'dart:developer';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:project/controller/main_wrapper_controller.dart';
import 'package:project/pages/login_screen.dart';
import 'package:project/view/edit_profile_tab.dart';
import 'package:project/view/showfollowers.dart';
import 'package:project/view/showsfollowers.dart';
import 'package:video_player/video_player.dart';

import '../controller/bands_controller.dart';
import '../controller/profile_controller.dart';
import '../controller/videos_controller.dart';
import '../services/bandservice.dart';
import '../utils/color.constants.dart';
import '../utils/config.dart';
import 'changepassword_tab.dart';
import 'contentscreen_profile.dart';
import 'contentscreen_profilevideo.dart';

// import '../core/authentication_manager.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final BandService bandService = Get.find();
  final VideosController videocontroller = Get.find<VideosController>();
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final TextEditingController _editvideoController = TextEditingController();
  final MainWrapperController _mainWrapperController =
      Get.find<MainWrapperController>();
  // ! อันเดิม
  // final ProfileController profileController = Get.find<ProfileController>();
  // final BandsController bandController = Get.find<BandsController>();
  // final ProfileController profileController = Get.put(ProfileController());
  // final BandsController bandController = Get.put(BandsController());
  @override
  void initState() {
    // profileController.followerstest();
    super.initState();
    if (bandService.bandsController.isBand.value == false) {
      bandService.profileController.getProfile();
      videocontroller
          .getVideosbyUserid(bandService.profileController.profileid.value);
    } else if (bandService.bandsController.isBand.value == true) {
      bandService.bandsController.getBand();
      videocontroller
          .getVideosbyBandid(bandService.bandsController.bandid.value);
    }

    print("bandService.bandsController.isBand.value");
    print(bandService.bandsController.isBand.value);
    print("========== Bandid Value ===============");
    print(bandService.bandsController.bandid.value);
    // bandService.profileController.anotherprofileid.value = 0;
    bandService.profileController.anotherProfileType.value = '';
    // print("bandService.profileController.anotherprofileid.value");
    // print(bandService.profileController.anotherprofileid.value);
    // print("bandService.profileController.anotherProfileType.value");
    // print(bandService.profileController.anotherProfileType.value);
    // bandService.profileController.getProfile();
    // print(bandController.isBand.value);
    // print(bandController.bandid.value);
    bandService.profileController.isvideo.value = false;
    bandService.notificationController.getNotifications();
    print("bandService.profileController.profileList[0].userName profile tab");
    print(bandService.profileController.profileList[0].userName);
    bandService.profileController.followerstest();
    bandService.profileController.followingtest();
  }

  // ? void showCustomSnackBar(String title, String message, Color color)
  void showCustomSnackBar(
      String title, String message, Color color, ContentType contentType) {
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

  Future doEditVideo(
    BuildContext context,
    int videoid,
  ) async {
    var rs = await videocontroller.editVideo(
        videoid, _editvideoController.text.trim());
    print(rs.body);
    var jsonRes = jsonDecode(rs.body);
    if (rs.statusCode == 200) {
      if (jsonRes['success'] == 1) {
        showCustomSnackBar('Congratulations', 'EditVideo Successfully',
            ColorConstants.appColors, ContentType.success);
      }
      if (bandService.bandsController.isBand.value == false) {
        await videocontroller
            .getVideosbyUserid(bandService.profileController.profileid.value);
        setState(() {});
      } else if (bandService.bandsController.isBand.value == true) {
        await videocontroller
            .getVideosbyBandid(bandService.bandsController.bandid.value);
        setState(() {});
      }

      Get.back();
      // displaypost = _postsController.displaypost;
      // }
    } else if (rs.statusCode == 500) {
      showCustomSnackBar(
          'EditVideo Failed',
          'Database connection error',
          Colors.red, // สีแดงหรือสีที่คุณต้องการ
          ContentType.failure);
    } else if (rs.statusCode == 498) {
      _mainWrapperController.logOut();
      showCustomSnackBar(
          'EditVideo Failed',
          "Invalid token",
          Colors.red, // สีแดงหรือสีที่คุณต้องการ
          ContentType.failure);
      // การส่งข้อมูลไม่สำเร็จ
    }
  }

  Future doDeleteVideo(
    BuildContext context,
    int videoid,
  ) async {
    var rs = await videocontroller.deleteVideo(videoid);
    print(rs.body);
    var jsonRes = jsonDecode(rs.body);
    if (rs.statusCode == 200) {
      if (jsonRes['success'] == 1) {
        showCustomSnackBar('Congratulations', 'deleteVideo Successfully',
            ColorConstants.appColors, ContentType.success);
        // _videosController.isLoading.value = false;
      }
      if (bandService.bandsController.isBand.value == false) {
        await videocontroller
            .getVideosbyUserid(bandService.profileController.profileid.value);
        setState(() {});
      } else if (bandService.bandsController.isBand.value == true) {
        await videocontroller
            .getVideosbyBandid(bandService.bandsController.bandid.value);
        setState(() {});
      }
      Get.back();
    } else if (rs.statusCode == 500) {
      showCustomSnackBar(
          'deleteVideo Failed',
          'Database connection error',
          Colors.red, // สีแดงหรือสีที่คุณต้องการ
          ContentType.failure);
    } else if (rs.statusCode == 498) {
      _mainWrapperController.logOut();
      showCustomSnackBar(
          'deleteVideo Failed',
          "Invalid token",
          Colors.red, // สีแดงหรือสีที่คุณต้องการ
          ContentType.failure);
      // การส่งข้อมูลไม่สำเร็จ
    }
  }

  // static const List<String> videos = [
  //   'https://assets.mixkit.co/videos/preview/mixkit-taking-photos-from-different-angles-of-a-model-34421-large.mp4',
  //   'https://assets.mixkit.co/videos/preview/mixkit-young-mother-with-her-little-daughter-decorating-a-christmas-tree-39745-large.mp4',
  // ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Obx(() => (bandService.profileController.isLoading.value ||
                bandService.bandsController.isLoading.value)
            ? Center(
                child: LoadingAnimationWidget.dotsTriangle(
                  color: ColorConstants.appColors,
                  size: 50,
                ),
              )
            : (bandService.bandsController.isBand.value == false)
                // ? FutureBuilder<void>(
                //     future: bandService.profileController.getProfile(),
                //     builder: (context, snapshot) {
                //       if (snapshot.connectionState == ConnectionState.waiting) {
                //         return Center(
                //           child: LoadingAnimationWidget.dotsTriangle(
                //             color: ColorConstants.appColors,
                //             size: 50,
                //           ),
                //         );
                //       } else if (snapshot.hasError) {
                //         return Center(
                //           child: Text('Error: ${snapshot.error}'),
                //         );
                //       } else {
                ? SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 13,
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                            ),
                            // color: Colors.blue,
                            height: height / 18,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  borderRadius: BorderRadius.circular(30.0),
                                  onTap: () {
                                    Get.to(ChangePasswordTab(),
                                        transition: Transition.fadeIn);
                                  },
                                  child: Ink(
                                    decoration: ShapeDecoration(
                                      color: Color.fromARGB(255, 93, 233,
                                          144), // สีพื้นหลังเมื่อกด
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            30.0), // ปรับค่าตามความต้องการ
                                      ),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(IconlyBold.password,
                                              color: Colors
                                                  .white), // สีไอคอนเป็นสีขาว
                                          SizedBox(
                                              width:
                                                  4), // ระยะห่างระหว่างไอคอนกับตัวหนังสือ
                                          Text(
                                            'Change Password',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors
                                                  .white, // สีตัวหนังสือเป็นสีขาว
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.circular(30.0),
                                  onTap: () {
                                    Get.to(EditProfileTab(),
                                        transition:
                                            Transition.rightToLeftWithFade);
                                  },
                                  child: Ink(
                                    decoration: ShapeDecoration(
                                      color: Color.fromARGB(255, 247, 223,
                                          35), // สีพื้นหลังเมื่อกด
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            30.0), // ปรับค่าตามความต้องการ
                                      ),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(IconlyBold.editSquare,
                                              color: Colors
                                                  .white), // สีไอคอนเป็นสีขาว
                                          SizedBox(
                                              width:
                                                  4), // ระยะห่างระหว่างไอคอนกับตัวหนังสือ
                                          Text(
                                            'Edit Profile',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors
                                                  .white, // สีตัวหนังสือเป็นสีขาว
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // color: Colors.red,
                            height: height * 0.43,
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                double innerHeight = constraints.maxHeight;
                                double innerWidth = constraints.maxWidth;
                                return Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        height: innerHeight * 0.72,
                                        width: innerWidth,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? Colors.grey[
                                                  300] // สีสำหรับ Light Theme
                                              : ColorConstants
                                                  .appColors, // สีสำหรับ Dark Theme
                                        ),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 80,
                                            ),
                                            Text(
                                              bandService.profileController
                                                  .profileList[0].userName,
                                              style: const TextStyle(
                                                fontSize: 25,
                                              ),
                                            ),
                                            Text(
                                              bandService.profileController
                                                  .profileList[0].userCountry,
                                              style: const TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                            Text(
                                              bandService.profileController
                                                  .profileList[0].userPosition,
                                              style: const TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Obx(
                                              () => Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  // ! followers
                                                  Ink(
                                                    width: 70,
                                                    height: 50,
                                                    child: InkWell(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  20)),
                                                      splashColor:
                                                          ColorConstants
                                                              .gray100,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () {
                                                        print(
                                                            'followersbutton');
                                                        // print(profileController.personIdList);
                                                        bandService
                                                            .profileController
                                                            .selectedList
                                                            .value = 'followers';
                                                        Get.to(
                                                          () =>
                                                              ShowsFollowers(),
                                                          transition: Transition
                                                              .downToUp,
                                                        );
                                                      },
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(bandService
                                                              .profileController
                                                              .countFollowers
                                                              .toString()),
                                                          Text(
                                                            'followers',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyLarge,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const Align(
                                                    alignment: Alignment.center,
                                                    child: SizedBox(
                                                      width: 20,
                                                      child: Text(
                                                        '|',
                                                        textAlign: TextAlign
                                                            .center, // ตั้งค่าการจัดวางให้เป็นกลาง
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          // fontWeight: FontWeight.w600,
                                                          // ปรับขนาดตามความต้องการ
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Ink(
                                                    width: 70,
                                                    height: 50,
                                                    child: InkWell(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  20)),
                                                      splashColor:
                                                          ColorConstants
                                                              .gray100,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () {
                                                        // print(profileController.following());
                                                        print(
                                                            'followeringbutton');
                                                        // print(profileController.personIdList);
                                                        bandService
                                                            .profileController
                                                            .selectedList
                                                            .value = 'following';
                                                        Get.to(
                                                          () =>
                                                              ShowsFollowers(),
                                                          transition: Transition
                                                              .downToUp,
                                                        );
                                                      },
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(bandService
                                                              .profileController
                                                              .countFollowing
                                                              .toString()),
                                                          Text(
                                                            'follwing',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyLarge,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: width / 4.7,
                                      child: Container(
                                        width: width / 2,
                                        height: height / 5,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(170.0),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                '${Config.getImage}${bandService.profileController.profileList[0].userAvatar}'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Reel',
                                  style: TextStyle(
                                    color: Color.fromRGBO(39, 105, 171, 1),
                                    fontSize: 27,
                                    fontFamily: 'Nunito',
                                  ),
                                ),
                                Divider(
                                  thickness: 2.5,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height,
                                    child: GridView.builder(
                                        itemCount:
                                            videocontroller.videos.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                mainAxisSpacing: 5,
                                                crossAxisSpacing: 5,
                                                childAspectRatio: 9 / 16),
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          var reverseindex =
                                              videocontroller.videos.length -
                                                  1 -
                                                  index;
                                          return InkWell(
                                              onLongPress: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (context) =>
                                                            AlertDialog(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30)),
                                                              contentPadding: EdgeInsets.all(
                                                                  MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.06),
                                                              title: Text(
                                                                  'SETTING'),
                                                              content: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(10),
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.1,
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.1,
                                                                  child: Column(
                                                                      children: [
                                                                        InkWell(
                                                                          splashColor:
                                                                              Colors.transparent, // สีเมื่อถูกแตะ
                                                                          highlightColor:
                                                                              Colors.transparent,
                                                                          onTap:
                                                                              () {
                                                                            _editvideoController.clear();
                                                                            Get.defaultDialog(
                                                                              title: '',
                                                                              content: Form(
                                                                                key: _keyForm,
                                                                                child: Column(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    TextFormField(
                                                                                      cursorColor: ColorConstants.appColors,
                                                                                      // validator:
                                                                                      //     _checkeditPostValidator,
                                                                                      controller: _editvideoController,
                                                                                      keyboardType: TextInputType.text,
                                                                                      maxLines: 1,
                                                                                      decoration: const InputDecoration(
                                                                                        labelText: 'Message',
                                                                                        hintMaxLines: 1,
                                                                                        border: OutlineInputBorder(
                                                                                          borderSide: BorderSide(color: Colors.green, width: 4.0),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 30.0,
                                                                                    ),
                                                                                    ElevatedButton(
                                                                                      onPressed: () async {
                                                                                        if (_keyForm.currentState!.validate()) {
                                                                                          await doEditVideo(context, videocontroller.videos[reverseindex].videoId!);
                                                                                          Get.back();
                                                                                        }
                                                                                      },
                                                                                      style: ButtonStyle(
                                                                                        padding: MaterialStateProperty.all<EdgeInsets>(
                                                                                          const EdgeInsets.symmetric(horizontal: 20.0),
                                                                                        ),
                                                                                        backgroundColor: MaterialStateProperty.all<Color>(
                                                                                          Color.fromARGB(255, 35, 236, 193),
                                                                                        ),
                                                                                      ),
                                                                                      child: const Text(
                                                                                        'EDIT SAVE',
                                                                                        style: TextStyle(
                                                                                          color: Colors.white,
                                                                                          fontSize: 16.0,
                                                                                        ),
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              radius: 10.0,
                                                                            );
                                                                          },
                                                                          child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                Text('EDIT'),
                                                                                SizedBox(width: 5),
                                                                                Icon(Icons.settings),
                                                                              ]),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(top: 30),
                                                                          child:
                                                                              InkWell(
                                                                            splashColor:
                                                                                Colors.transparent, // สีเมื่อถูกแตะ
                                                                            highlightColor:
                                                                                Colors.transparent,
                                                                            onTap:
                                                                                () async {
                                                                              await doDeleteVideo(context, videocontroller.videos[reverseindex].videoId!);
                                                                            },
                                                                            child:
                                                                                Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                                                              Text('DELETE'),
                                                                              Icon(Icons.delete),
                                                                            ]),
                                                                          ),
                                                                        )
                                                                      ]),
                                                                ),
                                                              ),
                                                            ));
                                              },
                                              onTap: () => {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            contentPadding:
                                                                EdgeInsets.all(
                                                                    1),
                                                            content:
                                                                AspectRatio(
                                                              aspectRatio:
                                                                  9 / 16,
                                                              // child: SingleChildScrollView(
                                                              child: Column(
                                                                  children: [
                                                                    AspectRatio(
                                                                      aspectRatio:
                                                                          9 / 16,
                                                                      child:
                                                                          Container(
                                                                        child: ContentScreenprofileVideo(
                                                                            src:
                                                                                videocontroller.videos[reverseindex]),
                                                                      ),
                                                                    ),
                                                                  ]),
                                                              // ), ของSinglechildScrollView
                                                            ),
                                                          );
                                                        })
                                                  },
                                              child: Obx(() {
                                                if (videocontroller
                                                    .isLoading.value) {
                                                  return Center(
                                                    child:
                                                        LoadingAnimationWidget
                                                            .dotsTriangle(
                                                      color: ColorConstants
                                                          .appColors,
                                                      size: 50,
                                                    ),
                                                  );
                                                } else {
                                                  return ContentScreenprofile(
                                                      src: videocontroller
                                                              .videos[
                                                          reverseindex]);
                                                }
                                              }));
                                        })),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                //   ),
                // )
                //   ],
                // );
                // }
                // },
                // )

                // FutureBuilder<void>(
                //     future: bandService.bandsController.getBand(),
                //     builder: (context, snapshot) {
                //       if (snapshot.connectionState == ConnectionState.waiting) {
                //         return Center(
                //           child: LoadingAnimationWidget.dotsTriangle(
                //             color: ColorConstants.appColors,
                //             size: 50,
                //           ),
                //         );
                //       } else if (snapshot.hasError) {
                //         return Center(
                //           child: Text('Error: ${snapshot.error}'),
                //         );
                //       } else {
                //         return
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 13),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            // color: Colors.blue,
                            height: height / 18,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  borderRadius: BorderRadius.circular(30.0),
                                  onTap: () {
                                    Get.to(EditProfileTab(),
                                        transition:
                                            Transition.rightToLeftWithFade);
                                  },
                                  child: Ink(
                                    decoration: ShapeDecoration(
                                      color: Color.fromARGB(255, 247, 223,
                                          35), // สีพื้นหลังเมื่อกด
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            30.0), // ปรับค่าตามความต้องการ
                                      ),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(IconlyBold.editSquare,
                                              color: Colors
                                                  .white), // สีไอคอนเป็นสีขาว
                                          SizedBox(
                                              width:
                                                  4), // ระยะห่างระหว่างไอคอนกับตัวหนังสือ
                                          Text(
                                            'Edit Profile',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors
                                                  .white, // สีตัวหนังสือเป็นสีขาว
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: height * 0.43,
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                double innerHeight = constraints.maxHeight;
                                double innerWidth = constraints.maxWidth;
                                return Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        height: innerHeight * 0.72,
                                        width: innerWidth,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? Colors.grey[
                                                  300] // สีสำหรับ Light Theme
                                              : ColorConstants
                                                  .appColors, // สีสำหรับ Dark Theme
                                        ),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 80,
                                            ),
                                            Text(
                                              bandService.bandsController
                                                  .bandList[0].bandName,
                                              style: const TextStyle(
                                                fontSize: 25,
                                              ),
                                            ),
                                            Text(
                                              bandService.bandsController
                                                  .bandList[0].bandCategory,
                                              style: const TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Obx(
                                              () => Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  // ! followers
                                                  Ink(
                                                    width: 70,
                                                    height: 50,
                                                    child: InkWell(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  20)),
                                                      splashColor:
                                                          ColorConstants
                                                              .gray100,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () {
                                                        print(
                                                            'followersbutton');
                                                        // print(profileController.personIdList);
                                                        bandService
                                                            .profileController
                                                            .selectedList
                                                            .value = 'followers';
                                                        Get.to(
                                                          () =>
                                                              ShowsFollowers(),
                                                          transition: Transition
                                                              .downToUp,
                                                        );
                                                      },
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(bandService
                                                              .profileController
                                                              .countFollowers
                                                              .toString()),
                                                          Text(
                                                            'followers',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyLarge,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const Align(
                                                    alignment: Alignment.center,
                                                    child: SizedBox(
                                                      width: 20,
                                                      child: Text(
                                                        '|',
                                                        textAlign: TextAlign
                                                            .center, // ตั้งค่าการจัดวางให้เป็นกลาง
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          // fontWeight: FontWeight.w600,
                                                          // ปรับขนาดตามความต้องการ
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Ink(
                                                    width: 70,
                                                    height: 50,
                                                    child: InkWell(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  20)),
                                                      splashColor:
                                                          ColorConstants
                                                              .gray100,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () {
                                                        // print(profileController.following());
                                                        print(
                                                            'followeringbutton');
                                                        // print(profileController.personIdList);
                                                        bandService
                                                            .profileController
                                                            .selectedList
                                                            .value = 'following';
                                                        Get.to(
                                                          () =>
                                                              ShowsFollowers(),
                                                          transition: Transition
                                                              .downToUp,
                                                        );
                                                      },
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(bandService
                                                              .profileController
                                                              .countFollowing
                                                              .toString()),
                                                          Text(
                                                            'follwing',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyLarge,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: width / 4.7,
                                      child: Container(
                                        width: width / 2,
                                        height: height / 5,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(170.0),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                '${Config.getImageBand}${bandService.bandsController.bandList[0].bandAvatar}'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Reel',
                                  style: TextStyle(
                                    color: Color.fromRGBO(39, 105, 171, 1),
                                    fontSize: 27,
                                    fontFamily: 'Nunito',
                                  ),
                                ),
                                Divider(
                                  thickness: 2.5,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height,
                                    child: GridView.builder(
                                        itemCount:
                                            videocontroller.videos.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                mainAxisSpacing: 5,
                                                crossAxisSpacing: 5,
                                                childAspectRatio: 9 / 16),
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          var reverseindex =
                                              videocontroller.videos.length -
                                                  1 -
                                                  index;
                                          return InkWell(
                                            onLongPress: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (context) => AlertDialog(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30)),
                                                            contentPadding: EdgeInsets
                                                                .all(MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.06),
                                                            title:
                                                                Text('SETTING'),
                                                            content: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              child: Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.1,
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.1,
                                                                child: Column(
                                                                    children: [
                                                                      InkWell(
                                                                        splashColor:
                                                                            Colors.transparent, // สีเมื่อถูกแตะ
                                                                        highlightColor:
                                                                            Colors.transparent,
                                                                        onTap:
                                                                            () {
                                                                          _editvideoController
                                                                              .clear();
                                                                          Get.defaultDialog(
                                                                            title:
                                                                                '',
                                                                            content:
                                                                                Form(
                                                                              key: _keyForm,
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  TextFormField(
                                                                                    cursorColor: ColorConstants.appColors,
                                                                                    // validator:
                                                                                    //     _checkeditPostValidator,
                                                                                    controller: _editvideoController,
                                                                                    keyboardType: TextInputType.text,
                                                                                    maxLines: 1,
                                                                                    decoration: const InputDecoration(
                                                                                      labelText: 'Message',
                                                                                      hintMaxLines: 1,
                                                                                      border: OutlineInputBorder(
                                                                                        borderSide: BorderSide(color: Colors.green, width: 4.0),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 30.0,
                                                                                  ),
                                                                                  ElevatedButton(
                                                                                    onPressed: () async {
                                                                                      if (_keyForm.currentState!.validate()) {
                                                                                        await doEditVideo(context, videocontroller.videos[reverseindex].videoId!);
                                                                                        Get.back();
                                                                                      }
                                                                                    },
                                                                                    style: ButtonStyle(
                                                                                      padding: MaterialStateProperty.all<EdgeInsets>(
                                                                                        const EdgeInsets.symmetric(horizontal: 20.0),
                                                                                      ),
                                                                                      backgroundColor: MaterialStateProperty.all<Color>(
                                                                                        Color.fromARGB(255, 35, 236, 193),
                                                                                      ),
                                                                                    ),
                                                                                    child: const Text(
                                                                                      'EDIT SAVE',
                                                                                      style: TextStyle(
                                                                                        color: Colors.white,
                                                                                        fontSize: 16.0,
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            radius:
                                                                                10.0,
                                                                          );
                                                                        },
                                                                        child: Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                            children: [
                                                                              Text('EDIT'),
                                                                              SizedBox(width: 5),
                                                                              Icon(Icons.settings),
                                                                            ]),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(top: 30),
                                                                        child:
                                                                            InkWell(
                                                                          splashColor:
                                                                              Colors.transparent, // สีเมื่อถูกแตะ
                                                                          highlightColor:
                                                                              Colors.transparent,
                                                                          onTap:
                                                                              () async {
                                                                            await doDeleteVideo(context,
                                                                                videocontroller.videos[reverseindex].videoId!);
                                                                            // await videocontroller.getVideosbyBandid(bandService.bandsController.bandid.value);
                                                                            setState(() {});
                                                                            Get.back();
                                                                          },
                                                                          child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                Text('DELETE'),
                                                                                Icon(Icons.delete),
                                                                              ]),
                                                                        ),
                                                                      )
                                                                    ]),
                                                              ),
                                                            ),
                                                          ));
                                            },
                                            onTap: () => {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      contentPadding:
                                                          EdgeInsets.all(1),
                                                      content: AspectRatio(
                                                        aspectRatio: 9 / 16,
                                                        // child: SingleChildScrollView(
                                                        child:
                                                            Column(children: [
                                                          AspectRatio(
                                                            aspectRatio: 9 / 16,
                                                            child: Container(
                                                              child: ContentScreenprofileVideo(
                                                                  src: videocontroller
                                                                          .videos[
                                                                      reverseindex]),
                                                            ),
                                                          ),
                                                        ]),
                                                        // ), ของSinglechildScrollView
                                                      ),
                                                    );
                                                  })
                                            },
                                            child: Obx(() {
                                              if (videocontroller
                                                  .isLoading.value) {
                                                return Center(
                                                  child: LoadingAnimationWidget
                                                      .dotsTriangle(
                                                    color: ColorConstants
                                                        .appColors,
                                                    size: 50,
                                                  ),
                                                );
                                              } else {
                                                return ContentScreenprofile(
                                                    src: videocontroller
                                                        .videos[reverseindex]);
                                              }
                                            }),
                                          );
                                        })),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )

        //   ),
        // )
        //   ],
        // );
        //     }
        //   },
        // )
        // ),
        );
  }
}
