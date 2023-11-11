import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../data/models/allband_model.dart' as allbandmodel;
import '../data/models/users_model.dart';
import '../data/models/dropdown_province_model.dart';
import '../pages/api_provider.dart';
import '../services/bandservice.dart';
import '../utils/color.constants.dart';
import '../utils/config.dart';
import 'another_profile_tab.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({Key? key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  List<User> displayUser = [];
  List<allbandmodel.Band> displayBand = [];
  List<String> itemsRole = ['All', 'Guitar', 'Vocal', 'Drum', 'Bass'];

  List<String> itemType = ['Band', 'User'];

  String selectedProvince = 'All';
  String selectedUsername = '';
  String selectedRole = 'All';
  String selectType = 'User';
  @override
  void initState() {
    super.initState();
    (selectType == "User")
        ? bandService.profileController.getAllProfie()
        : bandService.bandsController.getAllBand();

    displayUser = bandService.profileController.displayallUsers;
    displayBand = bandService.bandsController.allbands;
    bandService.profileController.isvideo.value = false;
    print('displayUser +++++ ${displayUser.length}');
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    (selectType == "User")
        ? await bandService.profileController.getAllProfie()
        : await bandService.bandsController.getAllBand();
    displayUser = bandService.profileController.displayallUsers;
    displayBand = bandService.bandsController.allbands;
  }

  void updateFindUser(String value) {
    setState(() {
      print('updateFindUser is already runing');
      if (selectedProvince == 'All' &&
          selectedRole == 'All' &&
          selectType == 'User') {
        print(
            'updateFindUser first conditiong that all role & province is already runing');
        displayUser = bandService.profileController.displayallUsers
            .where((element) =>
                (element.userName)
                    ?.toLowerCase()
                    .contains(value.toLowerCase()) ??
                false)
            .cast<User>()
            .toList();
      } else if (selectedProvince == 'All' && selectType == 'User') {
        print('updateFindUser other condition is already runing');
        displayUser = bandService.profileController.displayallUsers
            .where((element) => ((element.userName)!
                    .toLowerCase()
                    .contains(value.toLowerCase()) &&
                (element.userPosition
                        ?.toLowerCase()
                        .contains(selectedRole.toLowerCase()) ??
                    false)))
            .cast<User>()
            .toList();
      } else if (selectedRole == 'All' && selectType == 'User') {
        print('updateFindUser other condition is already runing');
        displayUser = bandService.profileController.displayallUsers
            .where((element) => ((element.userName)!
                    .toLowerCase()
                    .contains(value.toLowerCase()) &&
                (element.userCountry
                        ?.toLowerCase()
                        .contains(selectedProvince.toLowerCase()) ??
                    false)))
            .cast<User>()
            .toList();
      } else if (selectType == 'User') {
        print('updateFindUser other condition is already runing');
        displayUser = bandService.profileController.displayallUsers
            .where((element) => ((element.userName)!
                    .toLowerCase()
                    .contains(value.toLowerCase()) &&
                (element.userPosition!
                    .toLowerCase()
                    .contains(selectedRole.toLowerCase())) &&
                (element.userCountry!
                    .toLowerCase()
                    .contains(selectedProvince.toLowerCase()))))
            .cast<User>()
            .toList();
      }
    });
  }

  void updateFindUser_Role(String value) {
    setState(() {
      print('updateFindUser is already runing');
      if (selectedProvince == 'All' &&
          selectedRole == 'All' &&
          selectType == 'User') {
        print(
            'updateFindUser first conditiong that all role & province is already runing');
        displayUser = bandService.profileController.displayallUsers
            .where((element) =>
                (element.userName)
                    ?.toLowerCase()
                    .contains(selectedUsername.toLowerCase()) ??
                false)
            .cast<User>()
            .toList();
      } else if (selectedProvince == 'All' && selectType == 'User') {
        print('updateFindUser other condition is already runing');
        displayUser = bandService.profileController.displayallUsers
            .where((element) => ((element.userName)!
                    .toLowerCase()
                    .contains(selectedUsername.toLowerCase()) &&
                (element.userPosition
                        ?.toLowerCase()
                        .contains(value.toLowerCase()) ??
                    false)))
            .cast<User>()
            .toList();
      } else if (selectedRole == 'All' && selectType == 'User') {
        print('updateFindUser other condition is already runing');
        displayUser = bandService.profileController.displayallUsers
            .where((element) => ((element.userName)!
                    .toLowerCase()
                    .contains(selectedUsername.toLowerCase()) &&
                (element.userCountry
                        ?.toLowerCase()
                        .contains(selectedProvince.toLowerCase()) ??
                    false)))
            .cast<User>()
            .toList();
      } else if (selectType == 'User') {
        print('updateFindUser other condition is already runing');
        displayUser = bandService.profileController.displayallUsers
            .where((element) => ((element.userName)!
                    .toLowerCase()
                    .contains(selectedUsername.toLowerCase()) &&
                (element.userPosition!
                    .toLowerCase()
                    .contains(value.toLowerCase())) &&
                (element.userCountry!
                    .toLowerCase()
                    .contains(selectedProvince.toLowerCase()))))
            .cast<User>()
            .toList();
      }
    });
  }

  void updateFindUser_city(String value) {
    setState(() {
      print('updateFindUser is already runing');
      if (selectedProvince == 'All' &&
          selectedRole == 'All' &&
          selectType == 'User') {
        print(
            'updateFindUser first conditiong that all role & province is already runing');
        displayUser = bandService.profileController.displayallUsers
            .where((element) =>
                (element.userName)
                    ?.toLowerCase()
                    .contains(selectedUsername.toLowerCase()) ??
                false)
            .cast<User>()
            .toList();
      } else if (selectedProvince == 'All' && selectType == 'User') {
        print('updateFindUser other condition is already runing');
        displayUser = bandService.profileController.displayallUsers
            .where((element) => ((element.userName)!
                    .toLowerCase()
                    .contains(selectedUsername.toLowerCase()) &&
                (element.userPosition
                        ?.toLowerCase()
                        .contains(selectedRole.toLowerCase()) ??
                    false)))
            .cast<User>()
            .toList();
      } else if (selectedRole == 'All' && selectType == 'User') {
        print('updateFindUser other condition is already runing');
        displayUser = bandService.profileController.displayallUsers
            .where((element) => ((element.userName)!
                    .toLowerCase()
                    .contains(selectedUsername.toLowerCase()) &&
                (element.userCountry
                        ?.toLowerCase()
                        .contains(value.toLowerCase()) ??
                    false)))
            .cast<User>()
            .toList();
      } else if (selectType == 'User') {
        print('updateFindUser other condition is already runing');
        displayUser = bandService.profileController.displayallUsers
            .where((element) => ((element.userName)!
                    .toLowerCase()
                    .contains(selectedUsername.toLowerCase()) &&
                (element.userPosition!
                    .toLowerCase()
                    .contains(selectedRole.toLowerCase())) &&
                (element.userCountry!
                    .toLowerCase()
                    .contains(value.toLowerCase()))))
            .cast<User>()
            .toList();
      }
    });
  }

  void updateFindBand(String value) {
    setState(() {
      print('updateFindUser is already runing');
      if (selectType == 'Band') {
        print(
            'updateFindBand first conditiong that all role & province is already runing');
        displayBand = bandService.bandsController.allbands
            .where((element) =>
                (element.bandName)
                    ?.toLowerCase()
                    .contains(value.toLowerCase()) ??
                false)
            .cast<allbandmodel.Band>()
            .toList();
      }
    });
  }

  static final ScrollController _scrollController = ScrollController();
  final BandService bandService = Get.find();
  // List<String> itemsRole = ['All', 'Guitar', 'Vocal', 'Drum', 'Bass'];

  // List<String> itemType = ['Band', 'User'];

  // String selectedProvince = 'All';
  // String selectedUsername = '';
  // String selectedRole = 'All';
  ApiProvider apiProvider = ApiProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LiquidPullToRefresh(
      // showChildOpacityTransition: true,
      backgroundColor: Colors.white70,
      borderWidth: 5,
      height: 200,
      onRefresh: _handleRefresh,
      color: ColorConstants.appColors,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: ColorConstants.appColors,
            title: Padding(
              padding: const EdgeInsets.all(10.00),
              child: TextFormField(
                style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black // สีสำหรับ Light Theme
                        : ColorConstants.appColors),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  hintText: 'ค้นหาเพื่อนๆของคุณได้เลย!',
                  hintStyle: TextStyle(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black // สีสำหรับ Light Theme
                          : ColorConstants.appColors),
                  contentPadding: EdgeInsets.only(
                    left: 15.0,
                  ),
                ),
                onChanged: (value) => {
                  selectedUsername = value,
                  if (bandService.profileController.selectType.value == 'User')
                    {updateFindUser(value)}
                  else if (bandService.profileController.selectType.value ==
                      'Band')
                    {
                      {updateFindBand(value)}
                    }
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 20, left: 20, right: 10),
              child: FutureBuilder<List<ProvinceDropdownModel>>(
                future: apiProvider.fetchProvinceData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Row(
                      children: [
                        Container(
                          width: 200,
                          child: DropdownButtonFormField(
                            menuMaxHeight: 700,
                            style: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.black // สีสำหรับ Light Theme
                                    : ColorConstants.appColors),
                            decoration: InputDecoration(
                              hintText: "Select Province",
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 192, 192, 192)),
                              fillColor:
                                  const Color.fromARGB(255, 237, 237, 237),
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
                                  color: Color.fromARGB(255, 52, 230, 168),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 5.0),
                            ),
                            items: snapshot.data?.map((e) {
                              return DropdownMenuItem(
                                  value: e.nameTh.toString(),
                                  child: Text(e.nameTh.toString()));
                            }).toList(),
                            value: selectedProvince,
                            onChanged: (val) {
                              print(val);
                              setState(() {
                                selectedProvince = val!;
                              });
                              updateFindUser_city(val!);
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 116,
                          child: DropdownButtonFormField(
                            style: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.black // สีสำหรับ Light Theme
                                    : ColorConstants.appColors),
                            menuMaxHeight: 200,
                            value: selectedRole,
                            items: itemsRole.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 16),
                                ),
                              );
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                selectedRole = val!;
                                print(selectedRole);
                                updateFindUser_Role(val);
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "Select Role",
                              hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 192, 192, 192),
                              ),
                              fillColor:
                                  const Color.fromARGB(255, 237, 237, 237),
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
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 5.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 30,
                          child: DropdownButtonFormField(
                            menuMaxHeight: 200,
                            value: selectType,
                            items: itemType.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 16),
                                ),
                              );
                            }).toList(),
                            onChanged: (val) {
                              bandService.profileController.selectType.value =
                                  val!;
                              selectType = val;
                              // print(
                              //     'bandService.profileController.selectType.value =====${bandService.profileController.selectType.value}');
                              if (selectType == "User") {
                                bandService.profileController.getAllProfie();
                              } else {
                                bandService.bandsController.getAllBand();
                                setState(() {
                                  selectedRole = 'All';
                                  selectedProvince = 'All';
                                });
                              }
                            },
                            decoration: InputDecoration(
                              hintText: "",
                              hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 192, 192, 192),
                              ),
                              fillColor:
                                  const Color.fromARGB(255, 237, 237, 237),
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
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 5.0),
                            ),
                          ),
                        )
                      ],
                    );
                  }
                  return LoadingAnimationWidget.dotsTriangle(
                    size: 50,
                    color: ColorConstants.appColors,
                  );
                },
              ),
            ),
          ),
          Obx(() => (bandService.profileController.selectType.value == "User")
              ? (bandService.profileController.isLoading.value)
                  ? SliverToBoxAdapter(
                      child: Container(
                        height: 400,
                        child: Center(
                          child: LoadingAnimationWidget.dotsTriangle(
                            color: ColorConstants.appColors,
                            size: 50,
                          ),
                        ),
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          var reverseindex = displayUser.length - 1 - index;
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                            margin: EdgeInsets.all(
                                MediaQuery.of(context).size.width * 0.015),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                if (displayUser[reverseindex].userIsAdmin ==
                                    true.toString()) {
                                  null;
                                } else {
                                  var userid = displayUser[reverseindex].userId;
                                  bandService.profileController.anotherprofileid
                                      .value = userid!;
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
                                }
                              },
                              child: Container(
                                decoration: (displayUser[reverseindex]
                                            .userIsAdmin !=
                                        true.toString())
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: ColorConstants.appColors,
                                          width: 0.8,
                                        ))
                                    : BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color(0xfff5af19),
                                            offset: Offset(5, 3),
                                            blurRadius: 15,
                                          )
                                        ],
                                        gradient: const LinearGradient(
                                            colors: [
                                              Color(0xff833ab4),
                                              Color(0xfff12711),
                                              Color(0xfff5af19)
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight),
                                        borderRadius: BorderRadius.circular(20),
                                        // border: Border.all(width: 1),
                                        color: Color.fromARGB(255, 255, 208,
                                            68), // สีสำหรับ Dark Theme,),
                                      ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 20, top: 20, bottom: 40),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundColor: Colors.transparent,
                                            backgroundImage: NetworkImage(
                                              '${Config.getImage}${displayUser[reverseindex].userAvatar}',
                                            ),
                                          ),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                displayUser[reverseindex]
                                                    .userName!,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: (displayUser[
                                                                    reverseindex]
                                                                .userIsAdmin ==
                                                            true.toString())
                                                        ? Colors.white
                                                        : null),
                                              ),
                                              (displayUser[reverseindex]
                                                          .userIsAdmin !=
                                                      true.toString())
                                                  ? Text(
                                                      'ตำแหน่ง :${displayUser[reverseindex].userPosition}',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.grey),
                                                    )
                                                  : Container(),
                                              (displayUser[reverseindex]
                                                          .userIsAdmin ==
                                                      true.toString())
                                                  ? Container()
                                                  : Text(
                                                      'จังหวัด :${displayUser[reverseindex].userCountry}',
                                                    ),
                                              (displayUser[reverseindex]
                                                          .bandName
                                                          ?.isNotEmpty ==
                                                      true)
                                                  ? Text(
                                                      'สังกัดอยู่ในวง : ${displayUser[reverseindex].bandName}',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.grey))
                                                  : Container()
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: displayUser.length,
                      ),
                    )
              : (bandService.bandsController.isLoading.value)
                  ? SliverToBoxAdapter(
                      child: Container(
                        height: 400,
                        child: Center(
                          child: LoadingAnimationWidget.dotsTriangle(
                            color: ColorConstants.appColors,
                            size: 50,
                          ),
                        ),
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          var displayallBands = displayBand;
                          var reverseindex = displayallBands.length - 1 - index;
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                            margin: EdgeInsets.all(
                                MediaQuery.of(context).size.width * 0.015),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                var bandid = displayallBands[reverseindex]
                                    .createBandBy!
                                    .bandId;
                                // ! เอาค่าbandidเก็บใน anotherprofileid เพื่อจะเข้า method
                                bandService.profileController.anotherprofileid
                                    .value = bandid!;
                                bandService.profileController.anotherProfileType
                                    .value = "band";
                                // bandService
                                //     .bandsController
                                //     .anotherbandid
                                //     .value = bandid;
                                print(bandService.profileController
                                    .anotherProfileType.value);
                                print(bandService
                                    .profileController.anotherprofileid.value);
                                try {
                                  await bandService.profileController
                                      .checkfollow();
                                  await bandService.notificationController
                                      .checkSendEmail();
                                } catch (e) {
                                  print("Error: $e");
                                  // Handle the error as needed
                                }

                                // bandService.notificationController
                                //     .checkInviteBand();
                                Get.to(
                                    transition: Transition.downToUp,
                                    AnotherProfileTab(
                                      anotherpofileid: bandid,
                                    ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: ColorConstants.appColors,
                                    width: 0.8,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 20, top: 20, bottom: 40),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundColor: Colors.transparent,
                                            backgroundImage: NetworkImage(
                                              '${Config.getImageBand}${displayallBands[reverseindex].bandAvatar}',
                                            ),
                                          ),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                displayallBands[reverseindex]
                                                    .bandName!,
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              Text(
                                                'วงประเภท : ${displayallBands[reverseindex].bandCategory}',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: displayBand.length,
                      ),
                    ))
          //     }
          //   },
          // ),
        ],
      ),
    ));
  }
}
