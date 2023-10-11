// // ignore_for_file: deprecated_member_use, unused_import, no_leading_underscores_for_local_identifiers, unused_local_variable, non_constant_identifier_names, prefer_const_constructors, avoid_print, prefer_final_fields, unused_field, unused_element, sized_box_for_whitespace

// import 'package:anim_search_bar/anim_search_bar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:get_time_ago/get_time_ago.dart';
// import 'package:iconly/iconly.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:project/components/Mypost_v2.dart';
// import 'package:project/controller/profile_controller.dart';
// import 'package:project/data/models/post_model.dart';
// import 'package:project/view/another_profile_tab.dart';
// import 'package:project/components/Mypost.dart';
// import 'package:project/controller/posts_controller.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:project/view/add_post.dart';
// import 'package:project/view/post_detail.dart';
// // import '../components/Post.dart';
// import '../controller/Video_wrap_controller.dart';
// import '../controller/comments_controller.dart';
// import '../data/models/dropdown_province_model.dart';
// import '../pages/api_provider.dart';
// import '../services/bandservice.dart';
// import '../utils/color.constants.dart';
// import '../utils/config.dart';

// class PostTab extends StatefulWidget {
//   // เพิ่มพารามิเตอร์เพื่อรับข้อมูล

//   const PostTab({Key? key}) : super(key: key);

//   @override
//   State<PostTab> createState() => _PostTabState();
// }

// List<Post> display_post = _controller.posts;
// // final BandService bandService = Get.find();
// List<String> itemsRole = ['All', 'Guitar', 'Vocal', 'Drum', 'Bass'];
// ScrollController _scrollController = ScrollController();

// String selectedRole = 'All';
// String selectedCity = 'กรุงเทพมหานคร';
// String selectedUsername = '';

// final PostsController _controller = Get.put(PostsController());

// class _PostTabState extends State<PostTab> {
//   TextEditingController _searchController = TextEditingController();
//   ApiProvider apiProvider = ApiProvider();
//   static ScrollController _scrollController = ScrollController();

//   final CommentsController _commentcontroller = Get.put(CommentsController());

//   @override
//   void initState() {
//     super.initState();
//     // print(bandService.bandsController.isBand.value);
//     display_post = _controller.posts;
//   }

//   static void scrollToTop() {
//     _scrollController.animateTo(
//       0.0,
//       duration: Duration(milliseconds: 500), // ระยะเวลาในการเลื่อน
//       curve: Curves.easeInOut, // โครงรูปการเลื่อน
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     void updatePost(String value) {
//       print(display_post.length);
//       print(_controller.posts.value.length);
//       setState(() {
//         if (selectedCity == 'All' && selectedRole == 'All') {
//           display_post = _controller.posts
//               .where((element) => element.createByid.userName
//                   .toLowerCase()
//                   .contains(value.toLowerCase()))
//               .toList();
//         } else if (selectedCity == 'All') {
//           display_post = _controller.posts
//               .where((element) =>
//                   element.createByid.userName
//                       .toLowerCase()
//                       .contains(value.toLowerCase()) &&
//                   element.createByid.userPosition
//                       .toLowerCase()
//                       .contains(selectedRole.toLowerCase()))
//               .toList();
//         } else if (selectedRole == 'All') {
//           display_post = _controller.posts
//               .where((element) =>
//                   element.createByid.userName
//                       .toLowerCase()
//                       .contains(value.toLowerCase()) &&
//                   element.createByid.userCountry
//                       .toLowerCase()
//                       .contains(selectedCity.toLowerCase()))
//               .toList();
//         } else {
//           display_post = _controller.posts
//               .where((element) =>
//                   element.createByid.userName
//                       .toLowerCase()
//                       .contains(value.toLowerCase()) &&
//                   element.createByid.userCountry
//                       .toLowerCase()
//                       .contains(selectedCity.toLowerCase()) &&
//                   element.createByid.userPosition
//                       .toLowerCase()
//                       .contains(selectedRole.toLowerCase()))
//               .toList();
//         }
//       });
//     }

//     void updatePost_Role(String value) {
//       print(display_post.length);
//       print(_controller.posts.value.length);
//       setState(() {
//         if (value == 'All' && selectedCity == 'All') {
//           display_post = _controller.posts
//               .where((element) => element.createByid.userName
//                   .toLowerCase()
//                   .contains(selectedUsername.toLowerCase()))
//               .toList();
//         } else if (value == 'All') {
//           display_post = _controller.posts
//               .where((element) =>
//                   element.createByid.userCountry
//                       .toLowerCase()
//                       .contains(selectedCity.toLowerCase()) &&
//                   element.createByid.userName
//                       .toLowerCase()
//                       .contains(selectedUsername.toLowerCase()))
//               .toList();
//         } else if (selectedCity == 'All') {
//           display_post = _controller.posts
//               .where((element) =>
//                   element.createByid.userPosition
//                       .toLowerCase()
//                       .contains(value.toLowerCase()) &&
//                   element.createByid.userName
//                       .toLowerCase()
//                       .contains(selectedUsername.toLowerCase()))
//               .toList();
//         } else {
//           display_post = _controller.posts
//               .where((element) =>
//                   element.createByid.userPosition
//                       .toLowerCase()
//                       .contains(value.toLowerCase()) &&
//                   element.createByid.userCountry
//                       .toLowerCase()
//                       .contains(selectedCity.toLowerCase()) &&
//                   element.createByid.userName
//                       .toLowerCase()
//                       .contains(selectedUsername.toLowerCase()))
//               .toList();
//         }
//       });
//     }

//     void updatePost_city(String value) {
//       print(display_post.length);
//       print(_controller.posts.value.length);
//       setState(() {
//         if (value == 'All' && selectedRole == 'All') {
//           display_post = _controller.posts
//               .where((element) => element.createByid.userName
//                   .toLowerCase()
//                   .contains(selectedUsername.toLowerCase()))
//               .toList();
//         } else if (value == 'All') {
//           display_post = _controller.posts
//               .where((element) =>
//                   element.createByid.userPosition
//                       .toLowerCase()
//                       .contains(selectedRole.toLowerCase()) &&
//                   element.createByid.userName
//                       .toLowerCase()
//                       .contains(selectedUsername.toLowerCase()))
//               .toList();
//         } else if (selectedRole == 'All') {
//           display_post = _controller.posts
//               .where((element) =>
//                   element.createByid.userCountry
//                       .toLowerCase()
//                       .contains(value.toLowerCase()) &&
//                   element.createByid.userName
//                       .toLowerCase()
//                       .contains(selectedUsername.toLowerCase()))
//               .toList();
//         } else {
//           display_post = _controller.posts
//               .where((element) =>
//                   element.createByid.userCountry
//                       .toLowerCase()
//                       .contains(value.toLowerCase()) &&
//                   element.createByid.userPosition
//                       .toLowerCase()
//                       .contains(selectedRole.toLowerCase()) &&
//                   element.createByid.userName
//                       .toLowerCase()
//                       .contains(selectedUsername.toLowerCase()))
//               .toList();
//         }
//       });
//     }

//     // print(_controller.posts);
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: ColorConstants.appColors,
//         child: const Icon(Icons.add), //child widget inside this button
//         onPressed: () {
//           scrollToTop();
//           Get.to(const AddPost(), transition: Transition.downToUp);
//         },
//       ),
//       // backgroundColor: ColorConstants.gray100, // กำหนดสีพื้นหลังที่ต้องการ
//       body: CustomScrollView(
//         controller: _scrollController,
//         slivers: <Widget>[
//           SliverAppBar(
//             floating: true, // เพื่อให้ SearchBar หายไปเมื่อเลื่อนลง
//             backgroundColor: ColorConstants.appColors,
//             title: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: TextFormField(
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: const Color.fromARGB(255, 255, 255, 255),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(25.0),
//                   ),
//                   prefixIcon: Icon(
//                     Icons.search,
//                     color: Colors.black,
//                   ),
//                   hintText: 'ข้อมูลที่ต้องการค้นหา',
//                   contentPadding: EdgeInsets.only(
//                     left: 15.0,
//                   ),
//                 ),
//                 onChanged: (value) => {
//                   print(value),
//                   updatePost(value),
//                   selectedUsername = value,
//                   setState(() {})
//                 },
//                 controller: _searchController,
//                 style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.only(
//                   top: 20, bottom: 20, left: 20, right: 10),
//               child: FutureBuilder<List<ProvinceDropdownModel>>(
//                 future: apiProvider.fetchProvinceData(),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     return Obx(() => Row(children: [
//                           Container(
//                             width: 200,
//                             child: DropdownButtonFormField(
//                               // validator: _provinceValidator,
//                               menuMaxHeight: 700,
//                               style: TextStyle(
//                                 color: ColorConstants.gray600,
//                               ),
//                               // autofocus: true,
//                               // icon: Icon(
//                               //   Icons.arrow_drop_down_circle,
//                               //   color: ColorConstants.appColors,
//                               // ),
//                               // value: selectedValue,
//                               decoration: InputDecoration(
//                                 hintText: "Select Province",
//                                 hintStyle: const TextStyle(
//                                     color: Color.fromARGB(255, 192, 192, 192)),
//                                 fillColor:
//                                     const Color.fromARGB(255, 237, 237, 237),
//                                 filled: true,
//                                 prefixIcon: const Icon(
//                                   Icons.location_on,
//                                   color: Color(0xFFB3B3B3),
//                                 ),
//                                 border: OutlineInputBorder(
//                                   borderSide: BorderSide.none,
//                                   borderRadius: BorderRadius.circular(25),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide: const BorderSide(
//                                     color: Color.fromARGB(255, 52, 230, 168),
//                                     width: 2,
//                                   ),
//                                   borderRadius: BorderRadius.circular(25),
//                                 ),
//                                 contentPadding:
//                                     EdgeInsets.symmetric(vertical: 5.0),
//                               ),
//                               items: snapshot.data?.map((e) {
//                                 return DropdownMenuItem(
//                                     value: e.nameTh.toString(),
//                                     child: Text(e.nameTh.toString()));
//                               }).toList(),
//                               value: _controller.selectProvice.value != ''
//                                   ? _controller.selectProvice.value
//                                   : null,
//                               onChanged: (val) {
//                                 print(val);
//                                 setState(() => selectedCity = val!);
//                                 updatePost_city(val!);
//                               },
//                             ),
//                           ),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Container(
//                             width: 150,
//                             // height: 100,
//                             child: DropdownButtonFormField(
//                               menuMaxHeight: 200,
//                               value: selectedRole,
//                               items: itemsRole.map((item) {
//                                 return DropdownMenuItem(
//                                   value: item,
//                                   child: Text(
//                                     item,
//                                     overflow: TextOverflow.ellipsis,
//                                     maxLines: 1,
//                                     style: TextStyle(fontSize: 16),
//                                   ),
//                                 );
//                               }).toList(),
//                               onChanged: (val) {
//                                 setState(() => selectedRole = val.toString());
//                                 updatePost_Role(val.toString());
//                               },
//                               decoration: InputDecoration(
//                                 hintText: "Select Role",
//                                 hintStyle: const TextStyle(
//                                   color: Color.fromARGB(255, 192, 192, 192),
//                                 ),
//                                 fillColor:
//                                     const Color.fromARGB(255, 237, 237, 237),
//                                 filled: true,
//                                 prefixIcon: const Icon(
//                                   Icons.person,
//                                   color: Color(0xFFB3B3B3),
//                                 ),
//                                 border: OutlineInputBorder(
//                                   borderSide: BorderSide.none,
//                                   borderRadius: BorderRadius.circular(25),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide: const BorderSide(
//                                     color: Color.fromARGB(255, 52, 230, 168),
//                                     width: 2,
//                                   ),
//                                   borderRadius: BorderRadius.circular(25),
//                                 ),
//                                 contentPadding:
//                                     EdgeInsets.symmetric(vertical: 5.0),
//                               ),
//                             ),
//                           )
//                         ]));
//                   }
//                   return const CircularProgressIndicator();
//                 },
//               ),
//             ),
//           ),
//           Obx(() {
//             return !_controller.isLoading.value
//                 ? SliverList(
//                     delegate: SliverChildBuilderDelegate(
//                       (BuildContext context, int i) {
//                         var reverseindex = display_post.length - 1 - i;
//                         var postid = display_post[reverseindex].postId;
//                         var profileid =
//                             display_post[reverseindex].createByid.userId;
//                         DateTime _datetime =
//                             display_post[reverseindex].postCreateAt;

//                         return Mypost_v2(
//                           profileid:
//                               display_post[reverseindex].createByid.userId,
//                           postMessage: display_post[reverseindex].postMessage,
//                           userName:
//                               display_post[reverseindex].createByid.userName,
//                           userAvatar:
//                               display_post[reverseindex].createByid.userAvatar,
//                           postCreateAt: GetTimeAgo.parse(_datetime),
//                           userPosition: display_post[reverseindex]
//                               .createByid
//                               .userPosition,
//                           userCity:
//                               display_post[reverseindex].createByid.userCountry,
//                           postid: postid as int,
//                           userPositionIcon: display_post[reverseindex]
//                                       .createByid
//                                       .userPosition ==
//                                   'Guitar'
//                               ? Icon(
//                                   FontAwesomeIcons.guitar,
//                                   size: 30,
//                                 )
//                               : display_post[reverseindex]
//                                           .createByid
//                                           .userPosition ==
//                                       'Vocal'
//                                   ? Icon(
//                                       FontAwesomeIcons.microphone,
//                                       size: 30,
//                                     )
//                                   : display_post[reverseindex]
//                                               .createByid
//                                               .userPosition ==
//                                           'Drum'
//                                       ? Icon(
//                                           FontAwesomeIcons.drum,
//                                           size: 30,
//                                         )
//                                       : display_post[reverseindex]
//                                                   .createByid
//                                                   .userPosition ==
//                                               'Bass'
//                                           ? Icon(
//                                               FontAwesomeIcons.guitar,
//                                               size: 30,
//                                             )
//                                           : null,
//                         );
//                       },
//                       childCount: display_post.length,
//                     ),
//                   )
//                 : SliverToBoxAdapter(
//                     child: Container(
//                       height: 400,
//                       child: Center(
//                         child: LoadingAnimationWidget.dotsTriangle(
//                           color: ColorConstants.appColors,
//                           size: 50,
//                         ),
//                       ),
//                     ),
//                   );
//           }),
//         ],
//       ),
//     );
//   }
// }
