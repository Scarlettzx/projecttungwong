import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:project/controller/comments_post_controller.dart';
import 'package:project/controller/poststest_controller.dart';
import 'package:project/utils/color.constants.dart';
import '../controller/comments_controller.dart';
import '../controller/main_wrapper_controller.dart';
import '../utils/config.dart';
import 'package:get_time_ago/get_time_ago.dart';

class PostMessage extends StatefulWidget {
  final String postMessage; // เพิ่มพารามิเตอร์เพื่อรับข้อมูล

  const PostMessage(this.postMessage, {Key? key}) : super(key: key);

  @override
  State<PostMessage> createState() => _PostMessageState();
}

class _PostMessageState extends State<PostMessage> {
  final PoststestController _postsController = Get.find<PoststestController>();
  final _keyForm = GlobalKey<FormState>();
  final MainWrapperController _mainWrapperController =
      Get.find<MainWrapperController>();
  final CommentsPostController _commentspostscontroller =
      Get.find<CommentsPostController>();
  TextEditingController _textcommentController = TextEditingController();
  // final GlobalKey<FormState> _textFormFieldKey = GlobalKey<FormState>();
  @override
  void initState() {
    // _assetImagesDevice();
    super.initState();
    _textcommentController = TextEditingController();
    _textcommentController.addListener(() {
      if (_textcommentController.text.isNotEmpty) {
        print(_textcommentController.text);
        _commentspostscontroller.isIconButtonEnabled.value =
            true; // ถ้ามีข้อความ กำหนดให้ปุ่มสามารถกดได้
      } else {
        _commentspostscontroller.isIconButtonEnabled.value =
            false; // ถ้าไม่มีข้อความ กำหนดให้ปุ่มไม่สามารถกดได้
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _textcommentController.dispose();
  }

// ? void showCustomSnackBar(String title, String message, Color color)
  void showCustomSnackBar(
      String title, String message, Color color, ContentType contentType) {
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

  String? _commentValidator(String? fieldContent) {
    if (fieldContent != null && fieldContent.contains(' ')) {
      showCustomSnackBar(
          'COMMENT FAILED',
          "Please Fill Message without spaces..",
          Colors.red,
          ContentType.failure);
      return 'Comments cannot contain spaces';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 5,
          leading: IconButton(
            onPressed: () {
              _loadDataPost();
              Get.back(); // คำสั่งเพื่อย้อนกลับไปยังหน้า PostTab
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          backgroundColor: ColorConstants.appColors,
        ),
        body: Form(
          key: _keyForm,
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        LayoutBuilder(
                          builder: ((context, constraints) {
                            return Container(
                              // height: MediaQuery.of(context).size.height / 4,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.grey[300],
                              child: Wrap(children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        widget.postMessage,
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                            );
                          }),
                        ),
                        Container(
                          // color: Colors.amber,
                          // height: double.minPositive,
                          child: Obx(() {
                            if (_commentspostscontroller.isLoading.value) {
                              return Center(
                                child: LoadingAnimationWidget.dotsTriangle(
                                  color: ColorConstants.appColors,
                                  size: 50,
                                ),
                              );
                            } else {
                              if (_commentspostscontroller.comments.isEmpty) {
                                return const Center(
                                  child: Text('No comments'),
                                );
                              } else {
                                return ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  padding: const EdgeInsets.all(5.0),
                                  shrinkWrap:
                                      true, // ให้ ListView ขยายตามเนื้อหาของมัน
                                  itemCount:
                                      _commentspostscontroller.comments.length,
                                  itemBuilder: (context, i) {
                                    var reverseindex = _commentspostscontroller
                                            .comments.length -
                                        1 -
                                        i;
                                    DateTime datetime = _commentspostscontroller
                                        .comments[reverseindex]
                                        .commentCreateAt!;
                                    final isBand = (_commentspostscontroller
                                            .comments[reverseindex]
                                            .bandDetails !=
                                        null);
                                    if (isBand) {
                                      return Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: ListTile(
                                          tileColor: ColorConstants.gray50,
                                          title: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              _commentspostscontroller
                                                  .comments[reverseindex]
                                                  .commentMessage!,
                                              style:
                                                  const TextStyle(fontSize: 17),
                                            ),
                                          ),
                                          // isThreeLine: true,
                                          subtitle: const SizedBox(
                                            height: 30,
                                          ),
                                          leading: Column(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  // margin: EdgeInsets.all(5.0),
                                                  // color: ColorConstants.appColors,
                                                  width:
                                                      40, // ปรับขนาดของ Container ตามต้องการ
                                                  height:
                                                      70, // ปรับขนาดของ Container ตามต้องการ
                                                  child: CircleAvatar(
                                                    // radius: 10,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    backgroundImage:
                                                        _commentspostscontroller
                                                                .comments[
                                                                    reverseindex]
                                                                .bandDetails!
                                                                .bandAvatar!
                                                                .isEmpty
                                                            ? null
                                                            : NetworkImage(
                                                                '${Config.getImageBand}${_commentspostscontroller.comments[reverseindex].bandDetails!.bandAvatar}'),
                                                  ),
                                                ),
                                              ),
                                              Text(_commentspostscontroller
                                                  .comments[reverseindex]
                                                  .bandDetails!
                                                  .bandCategory!),
                                            ],
                                          ),

                                          trailing: Text(
                                            GetTimeAgo.parse(datetime),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: ListTile(
                                          tileColor: ColorConstants.gray50,
                                          title: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              _commentspostscontroller
                                                  .comments[reverseindex]
                                                  .commentMessage!,
                                              style:
                                                  const TextStyle(fontSize: 17),
                                            ),
                                          ),
                                          // isThreeLine: true,
                                          subtitle: const SizedBox(
                                            height: 30,
                                          ),
                                          leading: Column(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  // margin: EdgeInsets.all(5.0),
                                                  // color: ColorConstants.appColors,
                                                  width:
                                                      40, // ปรับขนาดของ Container ตามต้องการ
                                                  height:
                                                      70, // ปรับขนาดของ Container ตามต้องการ
                                                  child: CircleAvatar(
                                                    // radius: 10,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    backgroundImage:
                                                        _commentspostscontroller
                                                                .comments[
                                                                    reverseindex]
                                                                .personDetails!
                                                                .userAvatar!
                                                                .isEmpty
                                                            ? null
                                                            : NetworkImage(
                                                                '${Config.getImage}${_commentspostscontroller.comments[reverseindex].personDetails!.userAvatar}'),
                                                  ),
                                                ),
                                              ),
                                              Text(_commentspostscontroller
                                                  .comments[reverseindex]
                                                  .personDetails!
                                                  .userPosition!),
                                            ],
                                          ),

                                          trailing: Text(
                                            GetTimeAgo.parse(datetime),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                );
                              }
                            }
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  // alignment: Alignment.topLeft,
                  color: ColorConstants.appColors,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 5),
                    child: TextFormField(
                      cursorColor: Colors.white,
                      // key: _textFormFieldKey,
                      // autovalidateMode: AutovalidateMode.always,
                      validator: _commentValidator,
                      controller: _textcommentController,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        
                        // isDense: true,
                        hintText: "Comment",
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 192, 192, 192)),
                        fillColor: const Color.fromARGB(255, 237, 237, 237),
                        filled: true, // ปรับความสูงของกรอบ
                        suffixIcon: Obx(() => IconButton(
                              iconSize: 40,
                              icon: Icon(
                                IconlyBold.send,
                                color: _commentspostscontroller
                                        .isIconButtonEnabled.value
                                    ? ColorConstants.appColors
                                    : Colors
                                        .grey, // กำหนดสีตามเงื่อนไข, // กำหนดสีตามเงื่อนไข
                              ),
                              onPressed: _commentspostscontroller
                                      .isIconButtonEnabled.value //
                                  ? () {
                                      subbmitComment().then((value) =>
                                          SystemChannels.textInput
                                              .invokeMethod('TextInput.hide'));
                                    }
                                  : null, // ถ้าไม่มีข้อมูลให้ปุ่มเป็น non-clickable
                              // ถ้าไม่มีข้อมูลให้ปุ่มเป็น non-clickable
                            )),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 52, 230, 168),
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future subbmitComment() async {
    if (_keyForm.currentState!.validate()) {
      print(_textcommentController.text);
      var rs = await _commentspostscontroller
          .createComments(_textcommentController.text.trim());
      try {
        if (rs.statusCode == 200) {
          // การส่งข้อมูลสำเร็จ
          print('Post created successfully');
          _loadData();
          _textcommentController.clear();
          _commentspostscontroller.isIconButtonEnabled.value = false;
          setState(() {
            initState();
          });
        } else if (rs.statusCode == 498) {
          showCustomSnackBar(
              'POST FAILED',
              "Invalid token",
              Colors.red, // สีแดงหรือสีที่คุณต้องการ
              ContentType.failure);
          _mainWrapperController.logOut();
          // การส่งข้อมูลไม่สำเร็จ
        } else if (rs.statusCode == 404) {
          print(rs.body);
          showCustomSnackBar(
              'COMMENT FAILED',
              "Please Fill Message or Something..",
              Colors.red, // สีแดงหรือสีที่คุณต้องการ
              ContentType.failure);
        }
      } catch (e) {
        // เกิดข้อผิดพลาดในการเชื่อมต่อ
        print('Error creating post: $e');
      }
    }
  }

  _loadDataPost() async {
    _postsController.getPosts();
    print(_postsController.posts.length);
  }

  _loadData() async {
    _commentspostscontroller.getCommentsBypostid();
    print(_commentspostscontroller.comments.length);
  }
}
