import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:iconly/iconly.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:project/data/models/posts_model.dart';
import 'package:flutter/material.dart';
import 'package:project/view/post_message.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
// import '../controller/poststest_postsController.dart';
import '../controller/comments_post_controller.dart';
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
  static final ScrollController _scrollController = ScrollController();
  final PoststestController _postsController = Get.put(PoststestController());
  final CommentsPostController _commentspostscontroller =
      Get.put(CommentsPostController());
  List<Post> displaypost = []; // Initialize as an empty list
  List<String> itemsRole = ['All', 'Guitar', 'Vocal', 'Drum', 'Bass'];
  // final ScrollController _scrollController = ScrollController();

  String selectedRole = 'All';
  String selectedProvince = 'All';
  String selectedUsername = '';
  Future<void> _handleRefresh() async {
    await _postsController.getPosts();
    displaypost = _postsController.displaypost;
    print(_postsController.posts);
    print(_postsController.displaypost);
    print(displaypost);
  }

  static void scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500), // ระยะเวลาในการเลื่อน
      curve: Curves.easeInOut, // โครงรูปการเลื่อน
    );
  }

  @override
  void initState() {
    super.initState();
    _postsController.getPosts();
    // _postsController.update_displaypost();
    displaypost = _postsController.displaypost;
    // print(_postsController.posts);
    print("displaypost");
    print(displaypost);
  }

  void updatePost(String value) {
    // print(displaypost.length);
    // print(displaypost.length);
    setState(() {
      if (selectedProvince == 'All' && selectedRole == 'All') {
        displaypost = _postsController.displaypost
            .where((element) =>
                (element.personDetails?.userName ??
                        element.bandDetails?.bandName)
                    ?.toLowerCase()
                    .contains(value.toLowerCase()) ??
                false)
            .toList();
      } else if (selectedProvince == 'All') {
        displaypost = _postsController.displaypost
            .where((element) => ((element.personDetails?.userName ??
                        element.bandDetails?.bandName)!
                    .toLowerCase()
                    .contains(value.toLowerCase()) &&
                (element.personDetails?.userPosition
                        ?.toLowerCase()
                        .contains(selectedRole.toLowerCase()) ??
                    false)))
            .toList();
      } else if (selectedRole == 'All') {
        displaypost = _postsController.displaypost
            .where((element) => ((element.personDetails?.userName ??
                        element.bandDetails?.bandName)!
                    .toLowerCase()
                    .contains(value.toLowerCase()) &&
                (element.personDetails?.userCountry
                        ?.toLowerCase()
                        .contains(selectedProvince.toLowerCase()) ??
                    false)))
            .toList();
      } else {
        displaypost = _postsController.displaypost
            .where((element) => ((element.personDetails?.userName ??
                        element.bandDetails?.bandName)!
                    .toLowerCase()
                    .contains(value.toLowerCase()) &&
                (element.personDetails?.userPosition
                        ?.toLowerCase()
                        .contains(selectedRole.toLowerCase()) ??
                    false) &&
                (element.personDetails?.userCountry
                        ?.toLowerCase()
                        .contains(selectedProvince.toLowerCase()) ??
                    false)))
            .toList();
      }
    });
  }

  void updatePost_Role(String value) {
    setState(() {
      if (selectedRole == 'All' && selectedProvince == 'All') {
        displaypost = _postsController.displaypost
            .where((element) =>
                (element.personDetails?.userName ??
                        element.bandDetails?.bandName)
                    ?.toLowerCase()
                    .contains(selectedUsername.toLowerCase()) ??
                false)
            .toList();
      } else if (selectedRole == 'All') {
        displaypost = _postsController.displaypost
            .where((element) => ((element.personDetails?.userName ??
                        element.bandDetails?.bandName)!
                    .toLowerCase()
                    .contains(selectedUsername.toLowerCase()) &&
                (element.personDetails?.userCountry
                        ?.toLowerCase()
                        .contains(selectedProvince.toLowerCase()) ??
                    false)))
            .toList();
      } else if (selectedProvince == 'All') {
        displaypost = _postsController.displaypost
            .where((element) => ((element.personDetails?.userName ??
                        element.bandDetails?.bandName)!
                    .toLowerCase()
                    .contains(selectedUsername.toLowerCase()) &&
                (element.personDetails?.userPosition
                        ?.toLowerCase()
                        .contains(selectedRole.toLowerCase()) ??
                    false)))
            .toList();
      } else {
        displaypost = _postsController.displaypost
            .where((element) => ((element.personDetails?.userName ??
                        element.bandDetails?.bandName)!
                    .toLowerCase()
                    .contains(selectedUsername.toLowerCase()) &&
                (element.personDetails?.userPosition
                        ?.toLowerCase()
                        .contains(selectedRole.toLowerCase()) ??
                    false) &&
                (element.personDetails?.userCountry
                        ?.toLowerCase()
                        .contains(selectedProvince.toLowerCase()) ??
                    false)))
            .toList();
      }
    });
  }

  void updatePost_city(String value) {
    // print(displaypost.length);
    // print(_postsController.posts.value.length);

    setState(() {
      if (value == 'All' && selectedProvince == 'All') {
        displaypost = _postsController.displaypost
            .where((element) =>
                (element.personDetails?.userName ??
                        element.bandDetails?.bandName)
                    ?.toLowerCase()
                    .contains(selectedUsername.toLowerCase()) ??
                false)
            .toList();
      } else if (selectedProvince == 'All') {
        displaypost = _postsController.displaypost
            .where((element) => ((element.personDetails?.userName ??
                        element.bandDetails?.bandName)!
                    .toLowerCase()
                    .contains(selectedUsername.toLowerCase()) &&
                (element.personDetails?.userPosition
                        ?.toLowerCase()
                        .contains(selectedRole.toLowerCase()) ??
                    false)))
            .toList();
      } else if (selectedRole == 'All') {
        displaypost = _postsController.displaypost
            .where((element) => ((element.personDetails?.userName ??
                        element.bandDetails?.bandName)!
                    .toLowerCase()
                    .contains(selectedUsername.toLowerCase()) &&
                (element.personDetails?.userCountry
                        ?.toLowerCase()
                        .contains(selectedProvince.toLowerCase()) ??
                    false)))
            .toList();
      } else {
        displaypost = _postsController.displaypost
            .where((element) => ((element.personDetails?.userName ??
                        element.bandDetails?.bandName)!
                    .toLowerCase()
                    .contains(selectedUsername.toLowerCase()) &&
                (element.personDetails?.userPosition
                        ?.toLowerCase()
                        .contains(selectedRole.toLowerCase()) ??
                    false) &&
                (element.personDetails?.userCountry
                        ?.toLowerCase()
                        .contains(selectedProvince.toLowerCase()) ??
                    false)))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstants.appColors,
        child: const Icon(Icons.add), //child widget inside this button
        onPressed: () {
          scrollToTop();
          Get.to(const AddPostTest(), transition: Transition.downToUp);
        },
      ),
      body: LiquidPullToRefresh(
        // showChildOpacityTransition: true,
        backgroundColor: Colors.white70,
        borderWidth: 5,
        height: 200,
        onRefresh: _handleRefresh,
        color: ColorConstants.appColors,
        child: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
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
                    updatePost(value),
                    selectedUsername = value,
                    // setState(() {}),
                    print(selectedUsername)
                  },
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
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
                                menuMaxHeight: 700,
                                style: TextStyle(
                                  color: ColorConstants.gray600,
                                ),
                                decoration: InputDecoration(
                                  hintText: "Select Province",
                                  hintStyle: const TextStyle(
                                      color:
                                          Color.fromARGB(255, 192, 192, 192)),
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
                                value:
                                    _postsController.selectProvice.value != ''
                                        ? _postsController.selectProvice.value
                                        : selectedProvince,
                                onChanged: (val) {
                                  print(val);
                                  setState(() {
                                    selectedProvince = val!;
                                  });
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
                                  setState(() {
                                    selectedRole = val.toString();
                                  });
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
              print(
                  ' bandService.bandsController.bandid = = = = ${bandService.bandsController.bandid}');
              return !_postsController.isLoading.value
                  ? SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int i) {
                          // var userPositionIcon;
                          var reverseindex = displaypost.length - 1 - i;
                          // var postid = displaypost[reverseindex].postId;
                          var postid = displaypost[reverseindex].postId;
                          DateTime datetime =
                              displaypost[reverseindex].postCreateAt!;
                          final isBand =
                              (displaypost[reverseindex].bandDetails != null);
                          // ! showpostsBand
                          if (isBand) {
                            return Slidable(
                              enabled:
                                  (bandService.bandsController.isBand.value ==
                                              true) &&
                                          (displaypost[reverseindex]
                                                  .bandDetails!
                                                  .bandId ==
                                              bandService
                                                  .bandsController.bandid.value)
                                      ? true
                                      : false,
                              endActionPane: ActionPane(
                                  // extentRatio: 0.3,

                                  motion: const StretchMotion(),
                                  children: [
                                    SlidableAction(
                                      flex: 3,
                                      onPressed: ((context) {}),
                                      backgroundColor: Colors.amber,
                                      icon: IconlyBold.edit,
                                      foregroundColor: Colors.white,
                                    ),
                                    SlidableAction(
                                      flex: 3,
                                      onPressed: ((context) {}),
                                      backgroundColor: Colors.red,
                                      icon: IconlyBold.delete,
                                      foregroundColor: Colors.white,
                                    ),
                                    SlidableAction(
                                      flex: 4,
                                      onPressed: ((context) {}),
                                      backgroundColor: ColorConstants.unfollow,
                                      icon: Icons.report_rounded,
                                      foregroundColor: Colors.white,
                                    )
                                  ]),
                              child: Card(
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
                                        right: 20,
                                        top: 10,
                                        left: 20,
                                        bottom: 20),
                                    child: Column(children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 30),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
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
                                                bandService
                                                    .bandsController
                                                    .anotherbandid
                                                    .value = bandid;
                                                print(bandService
                                                    .profileController
                                                    .anotherProfileType
                                                    .value);
                                                print(bandService
                                                    .profileController
                                                    .anotherprofileid
                                                    .value);
                                                try {
                                                  await bandService
                                                      .profileController
                                                      .checkfollow();
                                                  await bandService
                                                      .notificationController
                                                      .checkSendEmail();
                                                } catch (e) {
                                                  print("Error: $e");
                                                  // Handle the error as needed
                                                }

                                                // bandService.notificationController
                                                //     .checkInviteBand();
                                                Get.to(
                                                    transition:
                                                        Transition.downToUp,
                                                    AnotherProfileTab(
                                                      anotherpofileid: bandid,
                                                    ));
                                              },
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Colors.transparent,
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
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                        child: Text(displaypost[reverseindex]
                                            .postMessage!),
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
                                              _commentspostscontroller
                                                  .postid.value = postid!;
                                              print(
                                                  "_commentspostscontroller.postid.value");
                                              print(_commentspostscontroller
                                                  .postid.value);
                                              _commentspostscontroller
                                                  .getCommentsBypostid();
                                              Get.to(
                                                PostMessage(
                                                    displaypost[reverseindex]
                                                        .postMessage!),
                                                transition: Transition
                                                    .downToUp, // ใช้ transition ตรงนี้
                                              );
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
                              ),
                            );
                            // ! Showpostuser
                          } else if (displaypost[reverseindex]
                                  .personDetails
                                  ?.userIsAdmin ==
                              'true') {
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              elevation: 8,
                              margin: const EdgeInsets.all(15),
                              child: AnimatedContainer(
                                duration: Duration(seconds: 1),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(width: 1),
                                    color: Colors.lightBlue[100]),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 20, top: 10, left: 20, bottom: 20),
                                  child: Column(children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 30),
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
                                              // print(bandService.profileController
                                              //     .anotherProfileType.value);
                                              // print(bandService.profileController
                                              //     .anotherprofileid.value);
                                              bandService.profileController
                                                  .checkfollow();
                                            },
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
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
                                            Row(children: [
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
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: Lottie.asset(
                                                          'assets/animation_lnlv8zw0.json',
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.1,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.1,
                                                          fit: BoxFit.fill),
                                                    ),
                                                  ])),
                                            ]),
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
                                      child: Text(displaypost[reverseindex]
                                          .postMessage!),
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
                                          onPressed: () {},
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
                          } else {
                            return Slidable(
                              enabled:
                                  (bandService.bandsController.isBand.value ==
                                              false) &&
                                          (displaypost[reverseindex]
                                                  .personDetails!
                                                  .userId ==
                                              bandService.profileController
                                                  .profileid.value)
                                      ? true
                                      : false,
                              endActionPane: ActionPane(
                                  // extentRatio: 0.3,

                                  motion: const StretchMotion(),
                                  children: [
                                    SlidableAction(
                                      flex: 3,
                                      onPressed: ((context) {}),
                                      backgroundColor: Colors.amber,
                                      icon: IconlyBold.edit,
                                      foregroundColor: Colors.white,
                                    ),
                                    SlidableAction(
                                      flex: 3,
                                      onPressed: ((context) {}),
                                      backgroundColor: Colors.red,
                                      icon: IconlyBold.delete,
                                      foregroundColor: Colors.white,
                                    ),
                                    SlidableAction(
                                      flex: 4,
                                      onPressed: ((context) {}),
                                      backgroundColor: ColorConstants.unfollow,
                                      icon: Icons.report_rounded,
                                      foregroundColor: Colors.white,
                                    )
                                  ]),
                              child: Card(
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
                                        right: 20,
                                        top: 10,
                                        left: 20,
                                        bottom: 20),
                                    child: Column(children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 30),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
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
                                                print(bandService
                                                    .profileController
                                                    .anotherProfileType
                                                    .value);
                                                print(bandService
                                                    .profileController
                                                    .anotherprofileid
                                                    .value);
                                                try {
                                                  await bandService
                                                      .profileController
                                                      .checkfollow();
                                                  await bandService
                                                      .notificationController
                                                      .checkInviteBand();
                                                  await bandService
                                                      .notificationController
                                                      .checkSendEmail();
                                                } catch (e) {
                                                  print("Error: $e");
                                                  // Handle the error as needed
                                                }
                                                Get.to(
                                                    transition:
                                                        Transition.downToUp,
                                                    AnotherProfileTab(
                                                      anotherpofileid: userid,
                                                    ));
                                              },
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Colors.transparent,
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
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                        child: Text(displaypost[reverseindex]
                                            .postMessage!),
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
                                              _commentspostscontroller
                                                  .postid.value = postid!;
                                              print(_commentspostscontroller
                                                  .postid.value);
                                              _commentspostscontroller
                                                  .getCommentsBypostid();
                                              Get.to(
                                                PostMessage(
                                                    displaypost[reverseindex]
                                                        .postMessage!),
                                                transition: Transition
                                                    .downToUp, // ใช้ transition ตรงนี้
                                              );
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
                              ),
                            );
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
      ),
    );
  }
}
