// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:iconly/iconly.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:project/utils/color.constants.dart';
// import 'package:project/view/post_tab.dart';
// import '../controller/comments_controller.dart';
// import '../controller/main_wrapper_controller.dart';
// import '../controller/posts_controller.dart';
// import '../utils/config.dart';
// import 'package:get_time_ago/get_time_ago.dart';
// import 'dart:math';

// class PostDetail extends StatefulWidget {
//   final String postMessage; // เพิ่มพารามิเตอร์เพื่อรับข้อมูล

//   const PostDetail(this.postMessage, {Key? key}) : super(key: key);

//   @override
//   State<PostDetail> createState() => _PostDetailState();
// }

// class _PostDetailState extends State<PostDetail> {
//   final PostsController _postsController = Get.find<PostsController>();
//   final _keyForm = GlobalKey<FormState>();
//   final MainWrapperController _mainWrapperController =
//       Get.find<MainWrapperController>();
//   final CommentsController _commentcontroller = Get.put(CommentsController());
//   TextEditingController _textcommentController = TextEditingController();
//   // final GlobalKey<FormState> _textFormFieldKey = GlobalKey<FormState>();
//   @override
//   void initState() {
//     // _assetImagesDevice();
//     super.initState();
//     _textcommentController = TextEditingController();
//     _textcommentController.addListener(() {
//       if (_textcommentController.text.isNotEmpty) {
//         print(_textcommentController.text);
//         _commentcontroller.isIconButtonEnabled.value =
//             true; // ถ้ามีข้อความ กำหนดให้ปุ่มสามารถกดได้
//       } else {
//         _commentcontroller.isIconButtonEnabled.value =
//             false; // ถ้าไม่มีข้อความ กำหนดให้ปุ่มไม่สามารถกดได้
//       }
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _textcommentController.dispose();
//   }

// // ? void showCustomSnackBar(String title, String message, Color color)
//   void showCustomSnackBar(
//       String title, String message, Color color, ContentType contentType) {
//     final snackBar = SnackBar(
//       /// need to set following properties for best effect of awesome_snackbar_content
//       elevation: 0,
//       behavior: SnackBarBehavior.floating,
//       backgroundColor: Colors.transparent,
//       content: AwesomeSnackbarContent(
//         title: title,
//         message: message,

//         /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
//         contentType: contentType,
//         color: color,
//       ),
//     );

//     ScaffoldMessenger.of(context)
//       ..hideCurrentSnackBar()
//       ..showSnackBar(snackBar);
//   }

//   String? _commentValidator(String? fieldContent) {
//     if (fieldContent!.isEmpty) {
//       showCustomSnackBar(
//           'COMMENT FAILED',
//           "Please Fill Message or Something..",
//           Colors.red, // สีแดงหรือสีที่คุณต้องการ
//           ContentType.failure);
//       return '';
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusScopeNode currentFocus = FocusScope.of(context);
//         if (!currentFocus.hasPrimaryFocus) {
//           currentFocus.unfocus();
//         }
//       },
//       child: Scaffold(
//         resizeToAvoidBottomInset: true,
//         appBar: AppBar(
//           elevation: 5,
//           leading: IconButton(
//             onPressed: () {
//               _loadDataPost();
//               Get.back(); // คำสั่งเพื่อย้อนกลับไปยังหน้า PostTab
//             },
//             icon: const Icon(Icons.arrow_back_ios_new),
//           ),
//           backgroundColor: ColorConstants.appColors,
//         ),
//         body: Form(
//           key: _keyForm,
//           child: SafeArea(
//             child: Column(
//               children: [
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         LayoutBuilder(
//                           builder: ((context, constraints) {
//                             return Container(
//                               width: MediaQuery.of(context).size.width,
//                               color: Colors.grey[300],
//                               child: Wrap(children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(15.0),
//                                   child: Column(
//                                     children: [
//                                       Text(
//                                         widget.postMessage,
//                                         style: TextStyle(
//                                           color: Colors.grey[600],
//                                           fontSize: 25,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ]),
//                             );
//                           }),
//                         ),
//                         SizedBox(
//                           // color: ColorConstants.appColors,
//                           height: MediaQuery.of(context).size.height / 1.6,
//                           child: Obx(() {
//                             if (_commentcontroller.isLoading.value) {
//                               return Center(
//                                 child: LoadingAnimationWidget.dotsTriangle(
//                                   color: ColorConstants.appColors,
//                                   size: 50,
//                                 ),
//                               );
//                             } else {
//                               if (_commentcontroller.isEmpty.value) {
//                                 return Center(
//                                   child: Text('No comments'),
//                                 );
//                               } else {
//                                 return ListView.builder(
//                                   physics: const BouncingScrollPhysics(),
//                                   padding: const EdgeInsets.all(5.0),
//                                   // reverse: true,
//                                   // padding: const EdgeInsets.only(top: 5.0, bottom: 40.0),
//                                   shrinkWrap:
//                                       true, // ให้ ListView ขยายตามเนื้อหาของมัน
//                                   itemCount: _commentcontroller.comments.length,
//                                   itemBuilder: (context, i) {
//                                     var reverseindex =
//                                         _commentcontroller.comments.length -
//                                             1 -
//                                             i;
//                                     DateTime datetime = _commentcontroller
//                                         .comments[reverseindex].commentCreateAt;
//                                     return Padding(
//                                       padding: EdgeInsets.all(5.0),
//                                       child: ListTile(
//                                         tileColor: ColorConstants.gray50,
//                                         title: Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: Text(
//                                             _commentcontroller
//                                                 .comments[reverseindex]
//                                                 .commentMessage,
//                                             style:
//                                                 const TextStyle(fontSize: 17),
//                                           ),
//                                         ),
//                                         // isThreeLine: true,
//                                         subtitle: const SizedBox(
//                                           height: 30,
//                                         ),
//                                         leading: Column(
//                                           children: [
//                                             Expanded(
//                                               child: Container(
//                                                 // margin: EdgeInsets.all(5.0),
//                                                 // color: ColorConstants.appColors,
//                                                 width:
//                                                     40, // ปรับขนาดของ Container ตามต้องการ
//                                                 height:
//                                                     70, // ปรับขนาดของ Container ตามต้องการ
//                                                 child: CircleAvatar(
//                                                   // radius: 10,
//                                                   backgroundColor:
//                                                       Colors.transparent,
//                                                   backgroundImage:
//                                                       _commentcontroller
//                                                               .comments[
//                                                                   reverseindex]
//                                                               .createByid
//                                                               .userAvatar
//                                                               .isEmpty
//                                                           ? null
//                                                           : NetworkImage(
//                                                               '${Config.getImage}${_commentcontroller.comments[reverseindex].createByid.userAvatar}'),
//                                                 ),
//                                               ),
//                                             ),
//                                             Text(_commentcontroller
//                                                 .comments[reverseindex]
//                                                 .createByid
//                                                 .userPosition),
//                                           ],
//                                         ),

//                                         trailing: Text(
//                                           GetTimeAgo.parse(datetime),
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 );
//                               }
//                             }
//                           }),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   // alignment: Alignment.topLeft,
//                   color: ColorConstants.appColors,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 25.0, vertical: 5),
//                     child: TextFormField(
//                       // key: _textFormFieldKey,
//                       // autovalidateMode: AutovalidateMode.onUserInteraction,
//                       validator: _commentValidator,
//                       controller: _textcommentController,
//                       obscureText: false,
//                       keyboardType: TextInputType.text,
//                       decoration: InputDecoration(
//                         // isDense: true,
//                         hintText: "Comment",
//                         hintStyle: const TextStyle(
//                             color: Color.fromARGB(255, 192, 192, 192)),
//                         fillColor: const Color.fromARGB(255, 237, 237, 237),
//                         filled: true, // ปรับความสูงของกรอบ
//                         suffixIcon: Obx(() => IconButton(
//                               iconSize: 40,
//                               icon: Icon(
//                                 IconlyBold.send,
//                                 color: _commentcontroller
//                                         .isIconButtonEnabled.value
//                                     ? ColorConstants.appColors
//                                     : Colors
//                                         .grey, // กำหนดสีตามเงื่อนไข, // กำหนดสีตามเงื่อนไข
//                               ),
//                               onPressed: _commentcontroller
//                                       .isIconButtonEnabled.value //
//                                   ? () {
//                                       subbmitComment().then((value) =>
//                                           SystemChannels.textInput
//                                               .invokeMethod('TextInput.hide'));
//                                     }
//                                   : null, // ถ้าไม่มีข้อมูลให้ปุ่มเป็น non-clickable
//                               // ถ้าไม่มีข้อมูลให้ปุ่มเป็น non-clickable
//                             )),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide.none,
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: Color.fromARGB(255, 52, 230, 168),
//                             width: 3,
//                           ),
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future subbmitComment() async {
//     if (_keyForm.currentState!.validate()) {
//       print(_textcommentController.text);
//       var rs = await _commentcontroller
//           .createComment(_textcommentController.text.trim());
//       try {
//         if (rs.statusCode == 200) {
//           // การส่งข้อมูลสำเร็จ
//           print('Post created successfully');
//           _loadData();
//           _textcommentController.clear();
//           _commentcontroller.isIconButtonEnabled.value = false;
//           setState(() {
//             initState();
//           });
//         } else if (rs.statusCode == 498) {
//           showCustomSnackBar(
//               'POST FAILED',
//               "Invalid token",
//               Colors.red, // สีแดงหรือสีที่คุณต้องการ
//               ContentType.failure);
//           _mainWrapperController.logOut();
//           // การส่งข้อมูลไม่สำเร็จ
//         } else if (rs.statusCode == 404) {
//           print(rs.body);
//           showCustomSnackBar(
//               'COMMENT FAILED',
//               "Please Fill Message or Something..",
//               Colors.red, // สีแดงหรือสีที่คุณต้องการ
//               ContentType.failure);
//         }
//       } catch (e) {
//         // เกิดข้อผิดพลาดในการเชื่อมต่อ
//         print('Error creating post: $e');
//       }
//     }
//   }

//   _loadDataPost() async {
//     _postsController.getPosts();
//     print(_postsController.posts.length);
//   }

//   _loadData() async {
//     _commentcontroller.getCommentsBypostid();
//     print(_commentcontroller.comments.length);
//   }
// }
