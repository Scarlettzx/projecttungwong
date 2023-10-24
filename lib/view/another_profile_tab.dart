// import 'dart:ffi';
//

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/src/response.dart';
import 'package:iconly/iconly.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:page_transition/page_transition.dart';
import 'package:project/controller/poststest_controller.dart';
import 'package:project/view/post_tab.dart';
import 'package:project/view/showfollowers.dart';
import 'package:project/view/showsfollowers.dart';
import 'package:project/view/testpost.dart';
import '../controller/main_wrapper_controller.dart';
import '../controller/posts_controller.dart';
import '../controller/profile_controller.dart';
// import '../data/models/post_model.dart';
import '../services/bandservice.dart';
import '../utils/color.constants.dart';
import '../utils/config.dart';

class AnotherProfileTab extends StatefulWidget {
  final int anotherpofileid;

  const AnotherProfileTab({
    Key? key,
    required this.anotherpofileid,
  }) : super(key: key);

  @override
  State<AnotherProfileTab> createState() => _AnotherProfileTabState();
}

class _AnotherProfileTabState extends State<AnotherProfileTab> {
  final MainWrapperController _mainWrapperController =
      Get.find<MainWrapperController>();
  final BandService bandService = Get.find();
  final PoststestController _postsController = Get.find<PoststestController>();
  late bool checkbutton = false;
  late bool checkbuttoninvite = false;
  // late bool checkbuttonemail = false;
  // bool _saving = false;
  @override
  void initState() {
    super.initState();
    print("bandService.profileController.profileList[0]");
    print(bandService.profileController.profileList[0].bandType);
    print(widget.anotherpofileid);
    print(bandService.profileController.profileid.value);
    print("bandService.profileController.anotherprofileid.value");
    print(bandService.profileController.anotherprofileid.value);
    print("bandService.profileController.anotherProfileType.value");
    print(bandService.profileController.anotherProfileType.value);
    bandService.profileController.followerstest();
    bandService.profileController.followingtest();
    // profileController.followers();
    // profileController.following();
    // Call loadProfileData to fetch the profile data
  }

  _loadDataPost() async {
    _postsController.getPosts();
    print(_postsController.posts.length);
  }

  checkButtoninvite() {
    final isBand = bandService.bandsController.isBand.value;
    final anotherProfileType =
        bandService.profileController.anotherProfileType.value;
    final profileid = bandService.profileController.profileid.value;
    final anotherprofileid =
        bandService.profileController.anotherprofileid.value;
    final bandid = bandService.bandsController.bandid.value;
    final bandType = bandService.profileController.profileList[0].bandType;
    if (anotherProfileType == "user" &&
        (bandService.profileController.useranotherprofile[0].userPosition ==
                "none" ||
            bandService.profileController.useranotherprofile[0].userIsAdmin ==
                "true")) {
      return false;
    } else {
      if (bandType == '2') {
        if (isBand) {
          if (anotherProfileType == "user" &&
              profileid != anotherprofileid &&
              bandService.profileController.useranotherprofile[0].bandType ==
                  '0') {
            return true;
          } else if (anotherProfileType == "band" &&
              bandid != anotherprofileid) {
            return false;
          }
        } else {
          if (anotherProfileType == "user" &&
              profileid != anotherprofileid &&
              bandService.profileController.useranotherprofile[0].bandType ==
                  '0') {
            return true;
          } else if (anotherProfileType == "band" &&
              bandid != anotherprofileid) {
            return false;
          }
        }
      }
    }
    return false;
  }

  checkButton() async {
    switch (bandService.bandsController.isBand.value) {
      case true:
        if (bandService.bandsController.bandid.value ==
                bandService.profileController.anotherprofileid.value ||
            bandService.profileController.profileid.value ==
                bandService.profileController.anotherprofileid.value) {
          return checkbutton = false;
        } else {
          return checkbutton = true;
        }
      case false:
        if (bandService.profileController.profileid.value ==
                bandService.profileController.anotherprofileid.value ||
            bandService.bandsController.bandid.value ==
                bandService.profileController.anotherprofileid.value) {
          return checkbutton = false;
        } else {
          return checkbutton = true;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  splashRadius: 20,
                  onPressed: () {
                    _loadDataPost();
                    Get.back();
                  },
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            Obx(() {
              if (bandService.profileController.anotherProfileType.value ==
                  "user") {
                return FutureBuilder<void>(
                  future: bandService.profileController.getuserAnotherProfile(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: LoadingAnimationWidget.dotsTriangle(
                          color: ColorConstants.appColors,
                          size: 50,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 13),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 22,
                            ),
                            Container(
                              height: height * 0.5,
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
                                            color: Theme.of(context)
                                                        .brightness ==
                                                    Brightness.light
                                                ? Colors.grey[
                                                    300] // สีสำหรับ Light Theme
                                                : ColorConstants
                                                    .appColors, // สีสำหรับ Dark Theme
                                          ),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 80,
                                              ),
                                              Text(
                                                bandService
                                                    .profileController
                                                    .useranotherprofile[0]
                                                    .userName,
                                                style: TextStyle(
                                                  fontSize: 25,
                                                ),
                                              ),
                                              Text(
                                                bandService
                                                    .profileController
                                                    .useranotherprofile[0]
                                                    .userCountry,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                              Text(
                                                bandService
                                                    .profileController
                                                    .useranotherprofile[0]
                                                    .userPosition,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                              Text(
                                                bandService
                                                    .profileController
                                                    .useranotherprofile[0]
                                                    .bandType,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                              SizedBox(
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
                                                            BorderRadius.all(
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
                                                            transition:
                                                                Transition
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
                                                      alignment:
                                                          Alignment.center,
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
                                                            BorderRadius.all(
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
                                                            transition:
                                                                Transition
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
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Obx(() {
                                                    checkButton(); // เรียก checkButton เพื่ออัพเดตค่า checkbutton
                                                    final showFollowButton =
                                                        checkbutton;
                                                    return Visibility(
                                                      visible: showFollowButton,
                                                      child: ElevatedButton(
                                                        style: ButtonStyle(
                                                          padding:
                                                              MaterialStateProperty
                                                                  .all<
                                                                      EdgeInsets>(
                                                            const EdgeInsets
                                                                .symmetric(
                                                              horizontal: 20.0,
                                                            ),
                                                          ),
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(
                                                            bandService
                                                                    .profileController
                                                                    .isFollowing
                                                                    .value
                                                                ? ColorConstants
                                                                    .unfollow
                                                                : ColorConstants
                                                                    .appColors,
                                                          ),
                                                          foregroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(
                                                            Colors.white,
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          if (bandService
                                                              .profileController
                                                              .isFollowing
                                                              .value) {
                                                            //! ถ้ากำลัง Following ให้ทำ Unfollow
                                                            //! ทำการ Unfollow ที่นี่
                                                            bandService
                                                                .profileController
                                                                .doUnfollow();
                                                          } else {
                                                            //! ถ้าไม่ได้ Following ให้ทำ Follow
                                                            bandService
                                                                .profileController
                                                                .dofollow();
                                                            // profileController.toggleFollow();
                                                          }
                                                        },
                                                        child: Text(
                                                          bandService
                                                                  .profileController
                                                                  .isFollowing
                                                                  .value
                                                              ? 'Unfollow'
                                                              : 'Follow',
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Obx(() {
                                                    final notificationController =
                                                        bandService
                                                            .notificationController;
                                                    final isVisible =
                                                        checkButtoninvite() &&
                                                            !notificationController
                                                                .isInvited
                                                                .value;

                                                    return Visibility(
                                                      visible: isVisible,
                                                      child: ElevatedButton(
                                                        style: ButtonStyle(
                                                          padding:
                                                              MaterialStateProperty
                                                                  .all<
                                                                      EdgeInsets>(
                                                            const EdgeInsets
                                                                .symmetric(
                                                              horizontal: 20.0,
                                                            ),
                                                          ),
                                                        ),
                                                        onPressed: () async {
                                                          await doInviteband(
                                                              context);
                                                        },
                                                        child: const Text(
                                                            "Invite"),
                                                      ),
                                                    );
                                                  }),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Obx(() {
                                                    if (bandService
                                                            .profileController
                                                            .profileList
                                                            .isNotEmpty &&
                                                        bandService
                                                                .profileController
                                                                .profileList[0]
                                                                .userPosition ==
                                                            "none" &&
                                                        bandService
                                                                .profileController
                                                                .useranotherprofile[
                                                                    0]
                                                                .userId !=
                                                            bandService
                                                                .profileController
                                                                .profileid
                                                                .value &&
                                                        !bandService
                                                            .notificationController
                                                            .sendOffer
                                                            .value) {
                                                      return ElevatedButton(
                                                        style: ButtonStyle(
                                                          padding:
                                                              MaterialStateProperty
                                                                  .all<
                                                                      EdgeInsets>(
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    20.0),
                                                          ),
                                                        ),
                                                        onPressed: () async {
                                                          print(bandService
                                                              .notificationController
                                                              .sendOffer
                                                              .value);
                                                          await doSendOffer(
                                                              context);
                                                        },
                                                        child:
                                                            const Text("Email"),
                                                      );
                                                    } else {
                                                      return Container(); // หรือใส่ Widget ที่เปลี่ยนแปลงอื่น ๆ ของคุณที่คุณต้องการแสดง
                                                    }
                                                  })
                                                ],
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
                                                  '${Config.getImage}${bandService.profileController.useranotherprofile[0].userAvatar}'),
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
                            SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
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
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                      //   ),
                      // )
                      //   ],
                      // );
                    }
                  },
                );
              } else if (bandService
                      .profileController.anotherProfileType.value ==
                  "band") {
                return FutureBuilder<void>(
                  future: bandService.profileController.getbandAnotherprofile(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: LoadingAnimationWidget.dotsTriangle(
                          color: ColorConstants.appColors,
                          size: 50,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 13),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 22,
                            ),
                            Container(
                              height: height * 0.5,
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
                                            color: Theme.of(context)
                                                        .brightness ==
                                                    Brightness.light
                                                ? Colors.grey[
                                                    300] // สีสำหรับ Light Theme
                                                : ColorConstants
                                                    .appColors, // สีสำหรับ Dark Theme
                                          ),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 80,
                                              ),
                                              Text(
                                                bandService
                                                    .profileController
                                                    .bandanotherprofile[0]
                                                    .bandName,
                                                style: TextStyle(
                                                  fontSize: 25,
                                                ),
                                              ),
                                              Text(
                                                bandService
                                                    .profileController
                                                    .bandanotherprofile[0]
                                                    .bandCategory,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                              SizedBox(
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
                                                            BorderRadius.all(
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
                                                            transition:
                                                                Transition
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
                                                      alignment:
                                                          Alignment.center,
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
                                                            BorderRadius.all(
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
                                                            transition:
                                                                Transition
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
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Obx(() {
                                                    checkButton();
                                                    final showFollowButton =
                                                        checkbutton;
                                                    return Visibility(
                                                      visible: showFollowButton,
                                                      child: ElevatedButton(
                                                        style: ButtonStyle(
                                                          padding:
                                                              MaterialStateProperty
                                                                  .all<
                                                                      EdgeInsets>(
                                                            const EdgeInsets
                                                                .symmetric(
                                                              horizontal: 20.0,
                                                            ),
                                                          ),
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(
                                                            bandService
                                                                    .profileController
                                                                    .isFollowing
                                                                    .value
                                                                ? ColorConstants
                                                                    .unfollow
                                                                : ColorConstants
                                                                    .appColors,
                                                          ),
                                                          foregroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(
                                                            Colors.white,
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          if (bandService
                                                              .profileController
                                                              .isFollowing
                                                              .value) {
                                                            //! ถ้ากำลัง Following ให้ทำ Unfollow
                                                            //! ทำการ Unfollow ที่นี่
                                                            bandService
                                                                .profileController
                                                                .doUnfollow();
                                                          } else {
                                                            //! ถ้าไม่ได้ Following ให้ทำ Follow
                                                            bandService
                                                                .profileController
                                                                .dofollow();
                                                            // profileController.toggleFollow();
                                                          }
                                                        },
                                                        child: Text(
                                                          bandService
                                                                  .profileController
                                                                  .isFollowing
                                                                  .value
                                                              ? 'Unfollow'
                                                              : 'Follow',
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Visibility(
                                                    visible:
                                                        checkButtoninvite(),
                                                    child: ElevatedButton(
                                                      style: ButtonStyle(
                                                        padding:
                                                            MaterialStateProperty
                                                                .all<
                                                                    EdgeInsets>(
                                                          const EdgeInsets
                                                              .symmetric(
                                                            horizontal: 20.0,
                                                          ),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        // Handle button click
                                                      },
                                                      child:
                                                          const Text("Invite"),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Obx(() {
                                                    if (bandService
                                                            .profileController
                                                            .profileList
                                                            .isNotEmpty &&
                                                        bandService
                                                                .profileController
                                                                .profileList[0]
                                                                .userPosition ==
                                                            "none"  &&
                                                        !bandService
                                                            .notificationController
                                                            .sendOffer
                                                            .value) {
                                                      return ElevatedButton(
                                                        style: ButtonStyle(
                                                          padding:
                                                              MaterialStateProperty
                                                                  .all<
                                                                      EdgeInsets>(
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    20.0),
                                                          ),
                                                        ),
                                                        onPressed: () async {
                                                          print(bandService
                                                              .notificationController
                                                              .sendOffer
                                                              .value);
                                                          await doSendOffer(
                                                              context);
                                                        },
                                                        child:
                                                            const Text("Email"),
                                                      );
                                                    } else {
                                                      return Container(); // หรือใส่ Widget ที่เปลี่ยนแปลงอื่น ๆ ของคุณที่คุณต้องการแสดง
                                                    }
                                                  })
                                                ],
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
                                                  '${Config.getImageBand}${bandService.profileController.bandanotherprofile[0].bandAvatar}'),
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
                            SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
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
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                      //   ),
                      // )
                      //   ],
                      // );
                    }
                  },
                );
              }
              return const Center(child: Text('error'));
            })
          ],
        ),
      ),
    );
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

  Future doInviteband(BuildContext context) async {
    print(bandService.bandsController.createBand.value);
    var rs = await bandService.notificationController.createNoti();
    var jsonRes = jsonDecode(rs.body);
    print(rs.body);
    if (rs.statusCode == 200) {
      if (jsonRes['success'] == 1) {
        // setState(() {
        //   _saving = true;
        // });
        // ! redirect
        if (mounted) {
          showCustomSnackBar('Congratulations', 'InvitedBand Successfully',
              ColorConstants.appColors, ContentType.success);
          bandService.notificationController.isInvited.value = true;
          // setState(() {
          //   _saving = false;
          // });
        }
      }
      // }
    } else if (rs.statusCode == 404) {
      switch (jsonRes['message']) {
        // !  มีชื่อวงนี้อยู่ใน DB Table Bands อยู่แล้ว
        case "You invited this person":
          showCustomSnackBar(
              'Invite Failed',
              'You invited this person',
              Colors.red, // สีแดงหรือสีที่คุณต้องการ
              ContentType.failure);
          break;
        // ! สามารถสร้างได้วงเดียว
        case "The band members are full.":
          showCustomSnackBar(
              'Invite Failed',
              'The band members are full',
              Colors.red, // สีแดงหรือสีที่คุณต้องการ
              ContentType.failure);
          break;
      }
    } else if (rs.statusCode == 500) {
      showCustomSnackBar(
          'Invite Failed',
          "Database Error",
          Colors.red, // สีแดงหรือสีที่คุณต้องการ
          ContentType.failure);
    } else if (rs.statusCode == 498) {
      showCustomSnackBar(
          'Invite FAILED',
          "Invalid token",
          Colors.red, // สีแดงหรือสีที่คุณต้องการ
          ContentType.failure);
      _mainWrapperController.logOut();
      // การส่งข้อมูลไม่สำเร็จ
    }
  }

  Future doSendOffer(BuildContext context) async {
    var rs;
    print(bandService.bandsController.createBand.value);
    if (bandService.profileController.anotherProfileType.value == "user") {
      rs = await bandService.notificationController.createSendEmailtoUser();
    } else if (bandService.profileController.anotherProfileType.value ==
        "band") {
      rs = await bandService.notificationController.createSendEmailtoBand();
    }
    print(rs.body);
    var jsonRes = jsonDecode(rs!.body);
    if (rs.statusCode == 200) {
      if (jsonRes['success'] == 1) {
        showCustomSnackBar('Congratulations', 'SendOffer Successfully',
            ColorConstants.appColors, ContentType.success);
        bandService.notificationController.sendOffer.value = true;
      }
      // }
    } else if (rs.statusCode == 404) {
      switch (jsonRes['message']) {
        // !  มีชื่อวงนี้อยู่ใน DB Table Bands อยู่แล้ว
        case "You dont sent Offer to him":
          showCustomSnackBar(
              'Invite Failed',
              'You dont sent Offer to him',
              Colors.red, // สีแดงหรือสีที่คุณต้องการ
              ContentType.failure);
          break;
        // ! สามารถสร้างได้วงเดียว
        case "Record not Found":
          showCustomSnackBar(
              'Invite Failed',
              'Record not Found',
              Colors.red, // สีแดงหรือสีที่คุณต้องการ
              ContentType.failure);
          break;
      }
    } else if (rs.statusCode == 403) {
      showCustomSnackBar(
          'Invite Failed',
          "You offered this person",
          Colors.red, // สีแดงหรือสีที่คุณต้องการ
          ContentType.failure);
    } else if (rs.statusCode == 498) {
      _mainWrapperController.logOut();
      showCustomSnackBar(
          'Invite FAILED',
          "Invalid token",
          Colors.red, // สีแดงหรือสีที่คุณต้องการ
          ContentType.failure);
      // การส่งข้อมูลไม่สำเร็จ
    }
  }
}
