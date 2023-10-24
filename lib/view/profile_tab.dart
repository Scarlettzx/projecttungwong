import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:project/controller/main_wrapper_controller.dart';
import 'package:project/pages/login_screen.dart';
import 'package:project/view/edit_profile_tab.dart';
import 'package:project/view/showfollowers.dart';
import 'package:project/view/showsfollowers.dart';

import '../controller/bands_controller.dart';
import '../controller/profile_controller.dart';
import '../services/bandservice.dart';
import '../utils/color.constants.dart';
import '../utils/config.dart';

// import '../core/authentication_manager.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final BandService bandService = Get.find();
  // ! อันเดิม
  // final ProfileController profileController = Get.find<ProfileController>();
  // final BandsController bandController = Get.find<BandsController>();
  // final ProfileController profileController = Get.put(ProfileController());
  // final BandsController bandController = Get.put(BandsController());
  @override
  void initState() {
    // profileController.followerstest();
    super.initState();
    (bandService.bandsController.isBand.value == false)
        ? bandService.profileController.getProfile()
        : bandService.bandsController.getBand();

    // print("bandService.bandsController.isBand.value");
    // print(bandService.bandsController.isBand.value);
    // print("========== Bandid Value ===============");
    // print(bandService.bandsController.bandid.value);
    // bandService.profileController.anotherprofileid.value = 0;
    // bandService.profileController.anotherProfileType.value = '';
    // print("bandService.profileController.anotherprofileid.value");
    // print(bandService.profileController.anotherprofileid.value);
    // print("bandService.profileController.anotherProfileType.value");
    // print(bandService.profileController.anotherProfileType.value);
    // bandService.profileController.getProfile();
    // print(bandController.isBand.value);
    // print(bandController.bandid.value);
    bandService.notificationController.getNotifications();
    print("bandService.profileController.profileList[0].userName profile tab");
    print(bandService.profileController.profileList[0].userName);
    bandService.profileController.followerstest();
    bandService.profileController.followingtest();
  }

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
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 13,
                    ),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(30.0),
                                onTap: () {},
                                child: Ink(
                                  decoration: ShapeDecoration(
                                    color: Color.fromARGB(
                                        255, 93, 233, 144), // สีพื้นหลังเมื่อกด
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
                                        Icon(IconlyBold.user_3,
                                            color: Colors
                                                .white), // สีไอคอนเป็นสีขาว
                                        SizedBox(
                                            width:
                                                4), // ระยะห่างระหว่างไอคอนกับตัวหนังสือ
                                        Text(
                                          'Show Bands',
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
                                    color: Color.fromARGB(
                                        255, 247, 223, 35), // สีพื้นหลังเมื่อกด
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
                                        borderRadius: BorderRadius.circular(30),
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
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                    splashColor:
                                                        ColorConstants.gray100,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () {
                                                      print('followersbutton');
                                                      // print(profileController.personIdList);
                                                      bandService
                                                          .profileController
                                                          .selectedList
                                                          .value = 'followers';
                                                      Get.to(
                                                        () => ShowsFollowers(),
                                                        transition:
                                                            Transition.downToUp,
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
                                                          style:
                                                              Theme.of(context)
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
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                    splashColor:
                                                        ColorConstants.gray100,
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
                                                        () => ShowsFollowers(),
                                                        transition:
                                                            Transition.downToUp,
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
                                                          style:
                                                              Theme.of(context)
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
                        const Padding(
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                //   ),
                // )
                //   ],
                // );
                // }
                // },
                // )
                :
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
                Padding(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(30.0),
                                onTap: () {},
                                child: Ink(
                                  decoration: ShapeDecoration(
                                    color: Color.fromARGB(
                                        255, 93, 233, 144), // สีพื้นหลังเมื่อกด
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
                                        Icon(IconlyBold.user_3,
                                            color: Colors
                                                .white), // สีไอคอนเป็นสีขาว
                                        SizedBox(
                                            width:
                                                4), // ระยะห่างระหว่างไอคอนกับตัวหนังสือ
                                        Text(
                                          'Show Bands',
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
                                    color: Color.fromARGB(
                                        255, 247, 223, 35), // สีพื้นหลังเมื่อกด
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
                                        borderRadius: BorderRadius.circular(30),
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
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                    splashColor:
                                                        ColorConstants.gray100,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () {
                                                      print('followersbutton');
                                                      // print(profileController.personIdList);
                                                      bandService
                                                          .profileController
                                                          .selectedList
                                                          .value = 'followers';
                                                      Get.to(
                                                        () => ShowsFollowers(),
                                                        transition:
                                                            Transition.downToUp,
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
                                                          style:
                                                              Theme.of(context)
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
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                    splashColor:
                                                        ColorConstants.gray100,
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
                                                        () => ShowsFollowers(),
                                                        transition:
                                                            Transition.downToUp,
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
                                                          style:
                                                              Theme.of(context)
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
                        const Padding(
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
                            ],
                          ),
                        ),
                      ],
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
