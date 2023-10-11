import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
// import 'package:project/components/band.dart';
// import 'package:project/components/user.dart';
import 'package:project/utils/color.constants.dart';
import 'package:project/view/create_band.dart';

import '../controller/bands_controller.dart';
import '../controller/profile_controller.dart';
import '../data/models/band_model.dart';
import '../services/bandservice.dart';
import '../utils/config.dart';

class BandTab extends StatefulWidget {
  const BandTab({super.key});

  @override
  State<BandTab> createState() => _BandTabState();
}

class _BandTabState extends State<BandTab> {
  // ! getxservice
  final BandService bandService = Get.find();
  // ! อันเดิม
  // final BandsController bandController = Get.find<BandsController>();
  // final ProfileController profileController = Get.find<ProfileController>();
  // ! อันใหม่
  // final BandsController bandController = Get.put(BandsController());
  // final ProfileController profileController = Get.put(ProfileController());
  @override
  void initState() {
    super.initState();
    // profileController.getProfile();
    bandService.bandsController.checkBand();
    print("profileController.profileList[0].bandType");
    print(bandService.profileController.profileList[0].bandType);
    print('userId');
    // print(profileController.profileDetail!['userId']);
    print(bandService.profileController.profileDetail!['userId']);
    // bandController.bandid.value = profileController.profileList[0].bandId;
    print(bandService.bandsController.isBand.value);

    // bandController.showMemberInBand(context);
    // bandController.getProfile();
    // bandController.profileMap!["userId"];
    // profileController.loadProfileData();
    // print("========== createBand Value ===============");
    // print(bandController.createBand.value);
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          child: (bandService.bandsController.createBand.value == true)
              ? FutureBuilder<void>(
                  future: bandService.bandsController.showMemberInBand(),
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
                      // Add 'return' statement here
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          (bandService.profileController.profileList[0]
                                      .bandType ==
                                  "1")
                              ? const Row(
                                  children: [],
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // ! Delete account(ยุบวง)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Ink(
                                        decoration: ShapeDecoration(
                                          color: Color.fromARGB(255, 229, 66,
                                              48), // สีพื้นหลังเมื่อกด
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                30.0), // ปรับค่าตามความต้องการ
                                          ),
                                        ),
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          onTap: () {
                                            Get.dialog(
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 40),
                                                    child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(20),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20.0),
                                                        child: Material(
                                                          child: Column(
                                                            children: [
                                                              const SizedBox(
                                                                  height: 10),
                                                              const Text(
                                                                "Do you want to disband the band?",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                              const SizedBox(
                                                                  height: 20),
                                                              //Buttons
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: ElevatedButton(
                                                                        child: const Text(
                                                                          'YES',
                                                                        ),
                                                                        style: ElevatedButton.styleFrom(
                                                                          minimumSize: const Size(
                                                                              0,
                                                                              45),
                                                                          primary:
                                                                              ColorConstants.appColors,
                                                                          onPrimary:
                                                                              const Color(0xFFFFFFFF),
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8),
                                                                          ),
                                                                        ),
                                                                        onPressed: () {
                                                                          bandService
                                                                              .bandsController
                                                                              .deleteBand()
                                                                              .then(
                                                                            (value) {
                                                                              Get.back();
                                                                              setState(() {});
                                                                            },
                                                                          );
                                                                        }),
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          10),
                                                                  Expanded(
                                                                    child:
                                                                        ElevatedButton(
                                                                      child:
                                                                          const Text(
                                                                        'NO',
                                                                      ),
                                                                      style: ElevatedButton
                                                                          .styleFrom(
                                                                        minimumSize: const Size(
                                                                            0,
                                                                            45),
                                                                        primary:
                                                                            ColorConstants.unfollow,
                                                                        onPrimary:
                                                                            const Color(0xFFFFFFFF),
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                        ),
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        Get.back();
                                                                      },
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
                                                ],
                                              ),
                                            );
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(IconlyBold.delete,
                                                    color: Colors
                                                        .white), // สีไอคอนเป็นสีขาว
                                                SizedBox(
                                                    width:
                                                        4), // ระยะห่างระหว่างไอคอนกับตัวหนังสือ
                                                Text(
                                                  'Delete band',
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
                                    ),
                                    // ! Switch account
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Ink(
                                        decoration: ShapeDecoration(
                                          color: Color.fromARGB(255, 72, 173,
                                              255), // สีพื้นหลังเมื่อกด
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                30.0), // ปรับค่าตามความต้องการ
                                          ),
                                        ),
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          onTap: () {
                                            (bandService.bandsController.isBand
                                                    .value)
                                                ? bandService.bandsController
                                                    .isBand.value = false
                                                : bandService.bandsController
                                                    .isBand.value = true;
                                            print(bandService
                                                .bandsController.isBand.value);
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                    Icons
                                                        .switch_account_rounded,
                                                    color: Colors
                                                        .white), // สีไอคอนเป็นสีขาว
                                                SizedBox(
                                                    width:
                                                        8), // ระยะห่างระหว่างไอคอนกับตัวหนังสือ
                                                Text(
                                                  'Switch account',
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
                                    ),
                                  ],
                                ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 20),
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.grey[300] // สีสำหรับ Light Theme
                                  : ColorConstants
                                      .appColors, // สีสำหรับ Dark Theme,
                              borderRadius: BorderRadius.circular(70.0),
                            ),
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 7,
                                  width: MediaQuery.of(context).size.width / 3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          '${Config.getImageBand}${bandService.bandsController.bandModelData.value!.band.bandAvatar}'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  ' ${bandService.bandsController.bandModelData.value!.band.bandName}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  ' ${bandService.bandsController.bandModelData.value!.band.bandCategory}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              child: ListView.builder(
                                itemCount: bandService
                                    .bandsController.memberList.length,
                                itemBuilder: (context, i) {
                                  var reverseindex = bandService
                                          .bandsController.memberList.length -
                                      1 -
                                      i;
                                  final memberListdata = bandService
                                      .bandsController.memberList[reverseindex];
                                  String bandTypeText = '';
                                  if (memberListdata.bandType == "1") {
                                    bandTypeText = 'Member';
                                  } else if (memberListdata.bandType == "2") {
                                    bandTypeText = 'Founder';
                                  }
                                  return ListTile(
                                    leading: Container(
                                      height: 60.0,
                                      width: 50.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              '${Config.getImage}${memberListdata.userAvatar}'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    title: Text(memberListdata.userName),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(memberListdata.userCountry),
                                        Text(memberListdata.userPosition),
                                      ],
                                    ),
                                    trailing: Text(bandTypeText),
                                    visualDensity: VisualDensity.compact,
                                    isThreeLine: true,
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                )
              : Container(
                  alignment: Alignment.center,
                  child: Ink(
                    decoration: ShapeDecoration(
                      color: ColorConstants.appColors,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        bandService.bandsController.createBand.value = false;
                        Get.to(
                          const CreateBand(),
                          transition: Transition.leftToRight,
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.add_circle_outline_rounded,
                              color: Colors.white,
                              size: 50,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Create Band',
                              style: TextStyle(
                                  color: Colors.amberAccent, fontSize: 30),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ));
  }
}
