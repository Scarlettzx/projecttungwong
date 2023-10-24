import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:project/components/Textcustom.dart';
import 'package:project/utils/color.constants.dart';
import 'package:project/view/post_tab.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../controller/main_wrapper_controller.dart';
import '../controller/poststest_controller.dart';

class AddPostTest extends StatefulWidget {
  const AddPostTest({super.key});

  @override
  State<AddPostTest> createState() => _AddPostTestState();
}

final PoststestController _postsController = Get.find<PoststestController>();

final MainWrapperController _mainWrapperController =
    Get.find<MainWrapperController>();

class _AddPostTestState extends State<AddPostTest> {
  final _keyForm = GlobalKey<FormState>();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    // _assetImagesDevice();
    super.initState();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
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

  String? _addPostValidator(String? fieldContent) {
    if (fieldContent!.isEmpty || fieldContent.trim().length < 5) {
      showCustomSnackBar(
          'POST FAILED',
          "Please Fill Message or Something..",
          Colors.red, // สีแดงหรือสีที่คุณต้องการ
          ContentType.failure);
      return '';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _keyForm,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
                child: Column(
              children: [
                _appBarPost(context, _keyForm),
                const SizedBox(height: 10.0),
                Expanded(
                  child: SizedBox(
                    height: 100,
                    // width: size.width * .78,
                    // color: ColorConstants.gray900,
                    child: TextFormField(
                      validator: _addPostValidator,
                      controller: _descriptionController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10.0, top: 10.0),
                        border: InputBorder.none,
                        hintText: 'Please fill message',
                        // hintStyle: (fontSize: 18)),
                        //   validator: RequiredValidator(
                        //       errorText: 'El campo es obligatorio'),
                        // ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }

  Widget _appBarPost(BuildContext context, GlobalKey<FormState> keyForm) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      IconButton(
          splashRadius: 20,
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.close_rounded)),
      TextButton(
          style: TextButton.styleFrom(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              backgroundColor: ColorConstants.appColors,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0))),
          onPressed: () {
            if (keyForm.currentState!.validate()) {
              // print(_postsController.posts.length);
              submitPost();
            }
          },
          child: const TextCustom(
            text: 'POST',
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w500,
            letterSpacing: 2,
          )),
    ]);
  }

  Future<void> submitPost() async {
    try {
      var rs =
          await _postsController.createPost(_descriptionController.text.trim());

      if (rs.statusCode == 200) {
        // การส่งข้อมูลสำเร็จ
        print('Post created successfully');
        Get.back();
        _loadData();
        print(_postsController.posts);
      } else if (rs.statusCode == 498) {
        showCustomSnackBar(
            'POST FAILED', 'Invalid token', Colors.red, ContentType.failure);
        _mainWrapperController.logOut();
        // การส่งข้อมูลไม่สำเร็จ
      } else {
        print('Failed to create post. Status code: ${rs.statusCode}');
        print(rs.body);
      }
    } catch (e) {
      // เกิดข้อผิดพลาดในการเชื่อมต่อ
      print('Error creating post: $e');
    }
  }

  _loadData() async {
    setState(() {}); // รีเรนเดอร์หน้าจอ
    await _postsController.getPosts();
    // _postsController.update_displaypost();
    print(_postsController.posts.length);
  }
}
