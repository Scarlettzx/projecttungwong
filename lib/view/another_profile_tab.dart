// import 'dart:ffi';
//

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:project/controller/poststest_controller.dart';
import 'package:project/view/post_tab.dart';
import 'package:project/view/showfollowers.dart';
import 'package:project/view/showsfollowers.dart';
import 'package:project/view/testpost.dart';
import '../controller/posts_controller.dart';
import '../controller/profile_controller.dart';
// import '../data/models/post_model.dart';
import '../services/bandservice.dart';
import '../utils/color.constants.dart';
import '../utils/config.dart';

class AnotherProfileTab extends StatefulWidget {
  final int anotherpofileid;
  // final String userName;
  // final String userPosition;
  // final String userCountry;
  // final String userAvatar;

  const AnotherProfileTab({
    Key? key,
    // required this.userAvatar,
    // required this.userName,
    // required this.userPosition,
    // required this.userCountry,
    required this.anotherpofileid,
  }) : super(key: key);

  @override
  State<AnotherProfileTab> createState() => _AnotherProfileTabState();
}

class _AnotherProfileTabState extends State<AnotherProfileTab> {
  final BandService bandService = Get.find();
  final PoststestController _postsController = Get.find<PoststestController>();
  @override
  void initState() {
    super.initState();
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
                                                bandService.profileController
                                                    .profileList[0].userName,
                                                style: TextStyle(
                                                  fontSize: 25,
                                                ),
                                              ),
                                              Text(
                                                bandService.profileController
                                                    .profileList[0].userCountry,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                              Text(
                                                bandService
                                                    .profileController
                                                    .profileList[0]
                                                    .userPosition,
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
                                                    // final bool
                                                    //     shouldShowButton =
                                                    //     widget.anotherpofileid !=
                                                    //         bandService
                                                    //             .profileController
                                                    //             .profileid
                                                    //             .value;
                                                    // return Visibility(
                                                    //   visible: shouldShowButton,
                                                    return ElevatedButton(
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
                                                    );
                                                    // );
                                                  }),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  ElevatedButton(
                                                    style: ButtonStyle(
                                                      padding:
                                                          MaterialStateProperty
                                                              .all<EdgeInsets>(
                                                        const EdgeInsets
                                                            .symmetric(
                                                          horizontal: 20.0,
                                                        ),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      // Handle button click
                                                    },
                                                    child: const Text("Invite"),
                                                  ),
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
                                                    // final bool
                                                    //     shouldShowButton =
                                                    //     widget.anotherpofileid !=
                                                    //         bandService
                                                    //             .profileController
                                                    //             .profileid
                                                    //             .value;
                                                    // return Visibility(
                                                    //   visible: shouldShowButton,
                                                    return ElevatedButton(
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
                                                    );
                                                    // );
                                                  }),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  ElevatedButton(
                                                    style: ButtonStyle(
                                                      padding:
                                                          MaterialStateProperty
                                                              .all<EdgeInsets>(
                                                        const EdgeInsets
                                                            .symmetric(
                                                          horizontal: 20.0,
                                                        ),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      // Handle button click
                                                    },
                                                    child: const Text("Invite"),
                                                  ),
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
}
