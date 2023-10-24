import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:project/utils/color.constants.dart';

import '../controller/bands_controller.dart';
import '../controller/profile_controller.dart';
import '../services/bandservice.dart';
import '../utils/config.dart';
import 'another_profile_tab.dart';

class ShowsFollowers extends StatelessWidget {
  ShowsFollowers({Key? key}) : super(key: key);
  final BandService bandService = Get.find();
  // !อันเดิม
  // final ProfileController profileController = Get.put(ProfileController());
  // final BandsController bandsController = Get.put(BandsController());
  Future<void> getSelectedListData() async {
    if (bandService.profileController.selectedList.value == 'followers') {
      print("SELECT FOLLOWERS");
      print(bandService.profileController.selectedList.value);
      await bandService.profileController.followerstest();
    } else {
      print("SELECT FOLLOWING");
      print(bandService.profileController.selectedList.value);
      await bandService.profileController.followingtest();
    }
  }

  @override
  Widget build(BuildContext context) {
    print('================================================================');
    print(bandService.profileController.selectedList.value);
    print("showfollowersscreen==============");
    print(bandService.profileController.personIdList);
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                IconlyBold.arrow_left_square,
              ),
            ),
            backgroundColor: ColorConstants.appColors,
            centerTitle: true,
            title:
                bandService.profileController.selectedList.value == 'followers'
                    ? Text('Followers')
                    : Text('Following')),
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Material(
                child: Container(
                  height: 70,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.white // สีสำหรับ Light Theme
                      : Colors.black, // สีสำหรับ Dark Theme
                  child: TabBar(
                    physics: const ClampingScrollPhysics(),
                    padding: EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 10),
                    unselectedLabelColor: ColorConstants.appColors,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ColorConstants.appColors),
                    tabs: [
                      Tab(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Color.fromARGB(255, 1, 166, 114),
                                  width: 1)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Users"),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: Color.fromARGB(255, 1, 166, 114),
                                  width: 1)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Bands"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    FutureBuilder<void>(
                      // รอให้ข้อมูล profileController.personIdList ถูกอัปเดต
                      future:
                          getSelectedListData(), // หรือ profileController.following() ตามที่เหมาะสม
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // กำลังโหลดข้อมูล แสดง Indicator หรือข้อความ "กำลังโหลด..."
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          // กรณีเกิดข้อผิดพลาด
                          return Center(
                              child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'));
                        } else if (bandService
                            .profileController.personDetails.isEmpty) {
                          // ถ้าไม่มีข้อมูล
                          return Center(child: Text('ไม่มีผู้ติดตาม'));
                        } else {
                          // แสดงข้อมูลเมื่อได้รับข้อมูลเสร็จสมบูรณ์
                          return ListView.separated(
                            padding: EdgeInsets.all(15),
                            separatorBuilder: (BuildContext context, int i) =>
                                const Divider(),
                            itemCount: bandService
                                .profileController.personDetails.length,
                            itemBuilder: (context, i) {
                              var reverseindex = bandService
                                      .profileController.personDetails.length -
                                  1 -
                                  i;
                              final personDetail = bandService.profileController
                                  .personDetails[reverseindex];
                              // ทำสิ่งที่คุณต้องการด้วยข้อมูล personIdData
                              return ListTile(
                                leading: InkWell(
                                  onTap: () async {
                                    // ! user
                                    var userid = personDetail.userId;
                                    bandService.profileController
                                        .anotherprofileid.value = userid;
                                    bandService.profileController
                                        .anotherProfileType.value = "user";
                                    print(bandService.profileController
                                        .anotherProfileType.value);
                                    print(bandService.profileController
                                        .anotherprofileid.value);
                                    try {
                                      await bandService.profileController
                                          .checkfollow();
                                      await bandService.notificationController
                                          .checkInviteBand();
                                      await bandService.notificationController
                                          .checkSendEmail();
                                    } catch (e) {
                                      print("Error: $e");
                                      // Handle the error as needed
                                    }
                                    Get.to(
                                        transition: Transition.downToUp,
                                        AnotherProfileTab(
                                          anotherpofileid: userid,
                                        ));
                                  },
                                  borderRadius: BorderRadius.circular(40.0),
                                  child: Container(
                                    height: 60.0,
                                    width: 50.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40.0),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            '${Config.getImage}${personDetail.userAvatar}'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                title: Text(personDetail.userName),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(personDetail.userCountry),
                                    Text(personDetail.userPosition),
                                  ],
                                ),
                                trailing: Text('sss'),
                                visualDensity: VisualDensity.compact,
                                // dense: true,
                                isThreeLine: true,
                              );
                            },
                          );
                        }
                      },
                    ),
                    FutureBuilder<void>(
                      // รอให้ข้อมูล profileController.personIdList ถูกอัปเดต
                      future:
                          getSelectedListData(), // หรือ profileController.following() ตามที่เหมาะสม
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // กำลังโหลดข้อมูล แสดง Indicator หรือข้อความ "กำลังโหลด..."
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          // กรณีเกิดข้อผิดพลาด
                          return Center(
                              child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'));
                        } else if (bandService
                            .profileController.bandDetails.isEmpty) {
                          // ถ้าไม่มีข้อมูล
                          return Center(child: Text('ไม่มีผู้ติดตาม'));
                        } else {
                          // แสดงข้อมูลเมื่อได้รับข้อมูลเสร็จสมบูรณ์
                          return ListView.separated(
                            padding: EdgeInsets.all(15),
                            separatorBuilder: (BuildContext context, int i) =>
                                const Divider(),
                            itemCount: bandService
                                .profileController.bandDetails.length,
                            itemBuilder: (context, i) {
                              var reverseindex = bandService
                                      .profileController.bandDetails.length -
                                  1 -
                                  i;
                              final bandDetail = bandService
                                  .profileController.bandDetails[reverseindex];
                              // ทำสิ่งที่คุณต้องการด้วยข้อมูล personIdData
                              return ListTile(
                                leading: InkWell(
                                  onTap: () async {
                                    var bandid = bandDetail.bandId;
                                    // ! เอาค่าbandidเก็บใน anotherprofileid เพื่อจะเข้า method
                                    bandService.profileController
                                        .anotherprofileid.value = bandid;
                                    bandService.profileController
                                        .anotherProfileType.value = "band";
                                    print(bandService.profileController
                                        .anotherProfileType.value);
                                    print(bandService.profileController
                                        .anotherprofileid.value);
                                    try {
                                      await bandService.profileController
                                          .checkfollow();
                                      await bandService.notificationController
                                          .checkSendEmail();
                                    } catch (e) {
                                      print("Error: $e");
                                    }

                                    Get.to(
                                        transition: Transition.downToUp,
                                        AnotherProfileTab(
                                          anotherpofileid: bandid,
                                        ));
                                  },
                                  borderRadius: BorderRadius.circular(40.0),
                                  child: Container(
                                    height: 60.0,
                                    width: 50.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40.0),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            '${Config.getImageBand}${bandDetail.bandAvatar}'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                title: Text(bandDetail.bandName),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(bandDetail.bandCategory),
                                  ],
                                ),
                                trailing: Text('sss'),
                                visualDensity: VisualDensity.compact,
                                // dense: true,
                                isThreeLine: true,
                              );
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        )
        // FutureBuilder<void>(
        //   // รอให้ข้อมูล profileController.personIdList ถูกอัปเดต
        //   future:
        //       getSelectedListData(), // หรือ profileController.following() ตามที่เหมาะสม
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       // กำลังโหลดข้อมูล แสดง Indicator หรือข้อความ "กำลังโหลด..."
        //       return Center(child: CircularProgressIndicator());
        //     } else if (snapshot.hasError) {
        //       // กรณีเกิดข้อผิดพลาด
        //       return Center(child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'));
        //     } else {
        //       // แสดงข้อมูลเมื่อได้รับข้อมูลเสร็จสมบูรณ์
        //       return ListView.separated(
        //         padding: EdgeInsets.all(15),
        //  separatorBuilder: (BuildContext context, int i) =>
        //                  const Divider(),
        //         itemCount: profileController.personDetails.length,
        //         itemBuilder: (context, i) {
        //           var reverseindex =
        //               profileController.personDetails.length - 1 - i;
        //           final personDetail =
        //               profileController.personDetails[reverseindex];
        //           // ทำสิ่งที่คุณต้องการด้วยข้อมูล personIdData
        //           return ListTile(
        //             leading: Container(
        //               height: 60.0,
        //               width: 50.0,
        //               decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(40.0),
        //                 image: DecorationImage(
        //                   image: NetworkImage(
        //                       '${Config.getImage}${personDetail.userAvatar}'),
        //                   fit: BoxFit.cover,
        //                 ),
        //               ),
        //             ),
        //             title: Text(personDetail.userName),
        //             subtitle: Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Text(personDetail.userCountry),
        //                 Text(personDetail.userPosition),
        //               ],
        //             ),
        //             trailing: Text('sss'),
        //             visualDensity: VisualDensity.compact,
        //             // dense: true,
        //             isThreeLine: true,
        //           );
        //         },
        //       );
        //     }
        //   },
        // ),
        );
  }
}
