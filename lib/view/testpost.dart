import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:project/data/models/posts_model.dart';
import 'package:flutter/material.dart';

// import '../controller/poststest_postsController.dart';
import '../controller/poststest_controller.dart';
import '../data/models/dropdown_province_model.dart';
import '../pages/api_provider.dart';
import '../services/bandservice.dart';
import '../utils/color.constants.dart';
import '../utils/config.dart';
import 'add_posttest.dart';
import 'another_profile_tab.dart';

class TestsPostTab extends StatefulWidget {
  const TestsPostTab({super.key});

  @override
  State<TestsPostTab> createState() => _TestsPostTabState();
}

class _TestsPostTabState extends State<TestsPostTab> {
  ApiProvider apiProvider = ApiProvider();
  final BandService bandService = Get.find();
  // static final ScrollController _scrollController = ScrollController();
  final PoststestController _postsController = Get.put(PoststestController());
  List<Post> displaypost = []; // Initialize as an empty list
  List<String> itemsRole = ['All', 'Guitar', 'Vocal', 'Drum', 'Bass'];
  final ScrollController _scrollController = ScrollController();

  String selectedRole = 'All';
  String selectedProvince = 'กรุงเทพมหานคร';
  String selectedUsername = '';
  // ! TextFormfield Search
  // void updatePost(String value) {
  //   print(displaypost.length);
  //   print(_postsController.posts.length);
  //   setState(() {
  //     if (selectedProvince == 'All' && selectedRole == 'All') {
  //       displaypost = _postsController.posts
  //           .where((element) => element.personDetails!.userName
  //               .toLowerCase()
  //               .contains(value.toLowerCase()))
  //           .toList();
  //     } else if (selectedProvince == 'All') {
  //       displaypost = _postsController.posts
  //           .where((element) =>
  //               element.personDetails!.userName
  //                   .toLowerCase()
  //                   .contains(value.toLowerCase()) &&
  //               element.personDetails!.userPosition
  //                   .toLowerCase()
  //                   .contains(selectedRole.toLowerCase()))
  //           .toList();
  //     } else if (selectedRole == 'All') {
  //       displaypost = _postsController.posts
  //           .where((element) =>
  //               element.personDetails!.userName
  //                   .toLowerCase()
  //                   .contains(value.toLowerCase()) &&
  //               element.personDetails!.userCountry
  //                   .toLowerCase()
  //                   .contains(selectedProvince.toLowerCase()))
  //           .toList();
  //     } else {
  //       displaypost = _postsController.posts
  //           .where((element) =>
  //               element.personDetails!.userName
  //                   .toLowerCase()
  //                   .contains(value.toLowerCase()) &&
  //               element.personDetails!.userCountry
  //                   .toLowerCase()
  //                   .contains(selectedProvince.toLowerCase()) &&
  //               element.personDetails!.userPosition
  //                   .toLowerCase()
  //                   .contains(selectedRole.toLowerCase()))
  //           .toList();
  //     }
  //   });
  // }

  void updatePost_Role(String value) {
    print(displaypost.length);
    print(_postsController.posts.value.length);
    setState(() {
      if (value == 'All' && selectedProvince == 'All') {
        displaypost = _postsController.posts
            .where((element) => element.personDetails!.userName!
                .toLowerCase()
                .contains(selectedUsername.toLowerCase()))
            .toList();
      } else if (value == 'All') {
        displaypost = _postsController.posts
            .where((element) =>
                element.personDetails!.userCountry!
                    .toLowerCase()
                    .contains(selectedProvince.toLowerCase()) &&
                element.personDetails!.userName!
                    .toLowerCase()
                    .contains(selectedUsername.toLowerCase()))
            .toList();
      } else if (selectedProvince == 'All') {
        displaypost = _postsController.posts
            .where((element) =>
                element.personDetails!.userPosition!
                    .toLowerCase()
                    .contains(value.toLowerCase()) &&
                element.personDetails!.userName!
                    .toLowerCase()
                    .contains(selectedUsername.toLowerCase()))
            .toList();
      } else {
        displaypost = _postsController.posts
            .where((element) =>
                element.personDetails!.userPosition!
                    .toLowerCase()
                    .contains(value.toLowerCase()) &&
                element.personDetails!.userCountry!
                    .toLowerCase()
                    .contains(selectedProvince.toLowerCase()) &&
                element.personDetails!.userName!
                    .toLowerCase()
                    .contains(selectedUsername.toLowerCase()))
            .toList();
      }
    });
  }

  void updatePost_city(String value) {
    print(displaypost.length);
    print(_postsController.posts.value.length);
    setState(() {
      if (value == 'All' && selectedRole == 'All') {
        displaypost = _postsController.posts
            .where((element) => element.personDetails!.userName!
                .toLowerCase()
                .contains(selectedUsername.toLowerCase()))
            .toList();
      } else if (value == 'All') {
        displaypost = _postsController.posts
            .where((element) =>
                element.personDetails!.userPosition!
                    .toLowerCase()
                    .contains(selectedRole.toLowerCase()) &&
                element.personDetails!.userName!
                    .toLowerCase()
                    .contains(selectedUsername.toLowerCase()))
            .toList();
      } else if (selectedRole == 'All') {
        displaypost = _postsController.posts
            .where((element) =>
                element.personDetails!.userCountry!
                    .toLowerCase()
                    .contains(value.toLowerCase()) &&
                element.personDetails!.userName!
                    .toLowerCase()
                    .contains(selectedUsername.toLowerCase()))
            .toList();
      } else {
        displaypost = _postsController.posts
            .where((element) =>
                element.personDetails!.userCountry!
                    .toLowerCase()
                    .contains(value.toLowerCase()) &&
                element.personDetails!.userPosition!
                    .toLowerCase()
                    .contains(selectedRole.toLowerCase()) &&
                element.personDetails!.userName!
                    .toLowerCase()
                    .contains(selectedUsername.toLowerCase()))
            .toList();
      }
    });
  }

  // static void scrollToTop() {
  //   _scrollController.animateTo(
  //     0.0,
  //     duration: const Duration(milliseconds: 500), // ระยะเวลาในการเลื่อน
  //     curve: Curves.easeInOut, // โครงรูปการเลื่อน
  //   );
  // }

  @override
  void initState() {
    super.initState();
    _postsController.getPosts(); // เรียกใช้ getPosts เมื่อหน้าถูกสร้าง
    displaypost = _postsController.posts;
    // print(_postsController.posts);
    // print(displaypost);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstants.appColors,
        child: const Icon(Icons.add), //child widget inside this button
        onPressed: () {
          Get.to(const AddPostTest(), transition: Transition.downToUp);
        },
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            floating: true, // เพื่อให้ SearchBar หายไปเมื่อเลื่อนลง
            backgroundColor: ColorConstants.appColors,
            title: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
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
                  hintText: 'ข้อมูลที่ต้องการค้นหา',
                  contentPadding: EdgeInsets.only(
                    left: 15.0,
                  ),
                ),
                onChanged: (value) => {
                  // print(value),
                  // updatePost(value),
                  // selectedUsername = value,
                  // setState(() {})
                },
                // controller: _searchController,
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
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
                    return Obx(() => Row(children: [
                          Container(
                            width: 200,
                            child: DropdownButtonFormField(
                              // validator: _provinceValidator,
                              menuMaxHeight: 700,
                              style: TextStyle(
                                color: ColorConstants.gray600,
                              ),
                              // autofocus: true,
                              // icon: Icon(
                              //   Icons.arrow_drop_down_circle,
                              //   color: ColorConstants.appColors,
                              // ),
                              // value: selectedValue,
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
                              value: _postsController.selectProvice.value != ''
                                  ? _postsController.selectProvice.value
                                  : null,
                              onChanged: (val) {
                                print(val);
                                setState(() => selectedProvince = val!);
                                updatePost_city(val!);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 150,
                            // height: 100,
                            child: DropdownButtonFormField(
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
                                setState(() => selectedRole = val.toString());
                                updatePost_Role(val.toString());
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
                          )
                        ]));
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ),
          Obx(() {
            return !_postsController.isLoading.value
                ? SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int i) {
                        var userPositionIcon;
                        var reverseindex = displaypost.length - 1 - i;
                        // var postid = displaypost[reverseindex].postId;
                        DateTime datetime =
                            displaypost[reverseindex].postCreateAt!;
                        // userPositionIcon:
                        // displaypost[reverseindex].personDetails!.userPosition ==
                        //         'Guitar'
                        //     ? Icon(
                        //         FontAwesomeIcons.guitar,
                        //         size: 30,
                        //       )
                        //     : displaypost[reverseindex]
                        //                 .personDetails!
                        //                 .userPosition ==
                        //             'Vocal'
                        //         ? Icon(
                        //             FontAwesomeIcons.microphone,
                        //             size: 30,
                        //           )
                        //         : displaypost[reverseindex]
                        //                     .personDetails!
                        //                     .userPosition ==
                        //                 'Drum'
                        //             ? Icon(
                        //                 FontAwesomeIcons.drum,
                        //                 size: 30,
                        //               )
                        //             : displaypost[reverseindex]
                        //                         .personDetails!
                        //                         .userPosition ==
                        //                     'Bass'
                        //                 ? Icon(
                        //                     FontAwesomeIcons.guitar,
                        //                     size: 30,
                        //                   )
                        //                 : null;
                        final isBand =
                            (_postsController.posts[reverseindex].bandDetails !=
                                null);
                        // ! showpostsBand
                        if (isBand) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            elevation: 8,
                            margin: const EdgeInsets.all(15),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: ColorConstants.appColors,
                                    width: 0.7),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 20, top: 10, left: 20, bottom: 20),
                                child: Column(children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 30),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () {
                                            var bandid =
                                                displaypost[reverseindex]
                                                    .bandDetails!
                                                    .bandId;
                                            // ! เอาค่าbandidเก็บใน anotherprofileid เพื่อจะเข้า method
                                            bandService
                                                .profileController
                                                .anotherprofileid
                                                .value = bandid!;
                                            bandService
                                                .profileController
                                                .anotherProfileType
                                                .value = "band";
                                            bandService.bandsController
                                                .anotherbandid.value = bandid;
                                            print(bandService.profileController
                                                .anotherProfileType.value);
                                            print(bandService.profileController
                                                .anotherprofileid.value);
                                            bandService.profileController
                                                .checkfollow();
                                            Get.to(
                                                transition: Transition.downToUp,
                                                AnotherProfileTab(
                                                  anotherpofileid: bandid,
                                                ));
                                            // _profilecontroller.profileid.value =
                                            //     displaypost[reverseindex]
                                            //         .personDetails!
                                            //         .userId;
                                            // _profilecontroller.checkfollow();
                                            // Get.to(
                                            //   AnotherProfileTab(
                                            //     userId:
                                            //         displaypost[reverseindex]
                                            //             .personDetails!
                                            //             .userId,
                                            //     userAvatar:
                                            //         displaypost[reverseindex]
                                            //             .personDetails!
                                            //             .userAvatar,
                                            //     userName:
                                            //         displaypost[reverseindex]
                                            //             .personDetails!
                                            //             .userName,
                                            //     userPosition:
                                            //         displaypost[reverseindex]
                                            //             .personDetails!
                                            //             .userPosition,
                                            //     userCountry:
                                            //         displaypost[reverseindex]
                                            //             .personDetails!
                                            //             .userCountry,
                                            //   ),
                                            //   transition: Transition.downToUp,
                                            // );
                                            // print(_controller.posts[reverseindex].personDetails!
                                            //     .userId.runtimeType);
                                            // print(_controller
                                            //     .posts[reverseindex].personDetails!.userId);
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            backgroundImage: NetworkImage(
                                                '${Config.getImageBand}${displaypost[reverseindex].bandDetails!.bandAvatar}'),
                                            radius: 30,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              width: 250,
                                              height: 30,
                                              color: Colors.transparent,
                                              child: Stack(children: [
                                                Text(
                                                  displaypost[reverseindex]
                                                      .bandDetails!
                                                      .bandName!,
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ])),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              displaypost[reverseindex]
                                                  .bandDetails!
                                                  .bandCategory!,
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        displaypost[reverseindex].postMessage!),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Divider(
                                    thickness: 2,
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.favorite_sharp,
                                          size: 30,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          // _commentcontroller.postid.value =
                                          //     postid;
                                          // print(
                                          //     _commentcontroller.postid.value);
                                          // _commentcontroller
                                          //     .getCommentsBypostid();
                                          // Get.to(
                                          //   PostDetail(
                                          //       displaypost[reverseindex]
                                          //           .postMessage),
                                          //   transition: Transition
                                          //       .downToUp, // ใช้ transition ตรงนี้
                                          // );
                                        },
                                        icon: Icon(
                                          Icons.comment_rounded,
                                          size: 30,
                                        ),
                                      ),
                                      SizedBox(width: 80),
                                      Text(GetTimeAgo.parse(datetime))
                                    ],
                                  )
                                ]),
                              ),
                            ),
                          );
                          // return ListTile(
                          //   leading: Container(
                          //     height: 60.0,
                          //     width: 50.0,
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(40.0),
                          //       image: DecorationImage(
                          //         image: NetworkImage(
                          //             '${Config.getImageBand}${_postsController.posts[reverseindex].bandDetails!.bandAvatar}'),
                          //         fit: BoxFit.cover,
                          //       ),
                          //     ),
                          //   ),
                          //   dense: true,
                          //   visualDensity: VisualDensity.compact,
                          //   isThreeLine: true,
                          //   title: Text(
                          //       '${_postsController.posts[reverseindex].bandDetails!.bandName}'),
                          //   subtitle: Text(
                          //       '${_postsController.posts[reverseindex].postMessage}'),
                          //   trailing: const Text('Band'),
                          // );
                          // ! Showpostuser
                        } else {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            elevation: 8,
                            margin: const EdgeInsets.all(15),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: ColorConstants.appColors,
                                    width: 0.7),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 20, top: 10, left: 20, bottom: 20),
                                child: Column(children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 30),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () {
                                            var userid =
                                                displaypost[reverseindex]
                                                    .personDetails!
                                                    .userId;
                                            bandService
                                                .profileController
                                                .anotherprofileid
                                                .value = userid!;
                                            bandService
                                                .profileController
                                                .anotherProfileType
                                                .value = "user";
                                            print(bandService.profileController
                                                .anotherProfileType.value);
                                            print(bandService.profileController
                                                .anotherprofileid.value);
                                            bandService.profileController
                                                .checkfollow();
                                            Get.to(
                                                transition: Transition.downToUp,
                                                AnotherProfileTab(
                                                  anotherpofileid: userid,
                                                ));
                                            // _profilecontroller.profileid.value =
                                            //     displaypost[reverseindex]
                                            //         .personDetails!
                                            //         .userId;
                                            // _profilecontroller.checkfollow();
                                            // Get.to(
                                            //   AnotherProfileTab(
                                            //     userId:
                                            //         displaypost[reverseindex]
                                            //             .personDetails!
                                            //             .userId,
                                            //     userAvatar:
                                            //         displaypost[reverseindex]
                                            //             .personDetails!
                                            //             .userAvatar,
                                            //     userName:
                                            //         displaypost[reverseindex]
                                            //             .personDetails!
                                            //             .userName,
                                            //     userPosition:
                                            //         displaypost[reverseindex]
                                            //             .personDetails!
                                            //             .userPosition,
                                            //     userCountry:
                                            //         displaypost[reverseindex]
                                            //             .personDetails!
                                            //             .userCountry,
                                            //   ),
                                            //   transition: Transition.downToUp,
                                            // );
                                            // print(_controller.posts[reverseindex].personDetails!
                                            //     .userId.runtimeType);
                                            // print(_controller
                                            //     .posts[reverseindex].personDetails!.userId);
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            backgroundImage: NetworkImage(
                                                '${Config.getImage}${displaypost[reverseindex].personDetails!.userAvatar}'),
                                            radius: 30,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              width: 250,
                                              height: 30,
                                              color: Colors.transparent,
                                              child: Stack(children: [
                                                Text(
                                                  displaypost[reverseindex]
                                                      .personDetails!
                                                      .userName!,
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                //   Positioned(
                                                //     right: 20,
                                                //     child: Container(
                                                //         child: userPositionIcon),
                                                //   )
                                              ])),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              displaypost[reverseindex]
                                                  .personDetails!
                                                  .userPosition!,
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              displaypost[reverseindex]
                                                  .personDetails!
                                                  .userCountry!,
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        displaypost[reverseindex].postMessage!),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Divider(
                                    thickness: 2,
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.favorite_sharp,
                                          size: 30,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          // _commentcontroller.postid.value =
                                          //     postid;
                                          // print(
                                          //     _commentcontroller.postid.value);
                                          // _commentcontroller
                                          //     .getCommentsBypostid();
                                          // Get.to(
                                          //   PostDetail(
                                          //       displaypost[reverseindex]
                                          //           .postMessage),
                                          //   transition: Transition
                                          //       .downToUp, // ใช้ transition ตรงนี้
                                          // );
                                        },
                                        icon: Icon(
                                          Icons.comment_rounded,
                                          size: 30,
                                        ),
                                      ),
                                      SizedBox(width: 80),
                                      Text(GetTimeAgo.parse(datetime))
                                    ],
                                  )
                                ]),
                              ),
                            ),
                          );
                          // return ListTile(
                          //   leading: Container(
                          //     height: 60.0,
                          //     width: 50.0,
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(40.0),
                          //       image: DecorationImage(
                          //         image: NetworkImage(
                          //             '${Config.getImage}${_postsController.posts[reverseindex].personDetails!.userAvatar}'),
                          //         fit: BoxFit.cover,
                          //       ),
                          //     ),
                          //   ),
                          //   title: Text(
                          //       '${_postsController.posts[reverseindex].personDetails!.userName}'),
                          //   subtitle: Text(
                          //       '${_postsController.posts[reverseindex].postMessage}'),
                          //   trailing: const Text('User'),
                          // );
                        }
                      },
                      childCount: displaypost.length,
                    ),
                  )
                : SliverToBoxAdapter(
                    child: Container(
                      height: 400,
                      child: Center(
                        child: LoadingAnimationWidget.dotsTriangle(
                          color: ColorConstants.appColors,
                          size: 50,
                        ),
                      ),
                    ),
                  );
          }),
        ],
      ),
    );
  }
}
