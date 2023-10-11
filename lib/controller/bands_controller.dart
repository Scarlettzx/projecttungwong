// ignore_for_file: unnecessary_overrides
// import 'dart:convert';
// import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:project/controller/profile_controller.dart';
// import 'package:project/data/providers/comment_provider.dart';
// import 'package:project/data/models/post_model.dart';
// import 'package:project/data/providers/post_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../data/models/comment_model.dart';
import '../data/models/band_model.dart';
// import '../data/models/profile_model.dart';
import '../services/bandservice.dart';
import '../utils/config.dart';
import '../utils/custom_snakebar.dart';
import 'main_wrapper_controller.dart';

class BandsController extends GetxController {
  // final MainWrapperController _mainWrapperController =
  //     Get.find<MainWrapperController>();
  final BandService bandService = Get.find();
  // ! อันใหม่
  // final ProfileController profileController = Get.find<ProfileController>();
  // !อันเดิม
  // final ProfileController profileController = Get.put(ProfileController());
  List<Member> memberList = [];
  var bandList = <Band>[].obs;
  final RxBool isBand = false.obs;
  final RxBool createBand = false.obs;
  late Band band;
  //! showprofileband
  final RxInt anotherbandid = 0.obs;
  final RxInt bandid = 0.obs;
  final count = 0.obs;
  final Rx<BandModel?> bandModelData = Rx<BandModel?>(null);
  final RxBool isLoading = false.obs;
  // final bband =
  // final Rx<BandModel?> bandModelData = Rx<BandModel?>(null);
  // var profile = <ProfileModel>[].obs;
  // RxMap<String, dynamic>? profileMap;
  // final comments = <Comment>[].obs;
  // final RxInt postid = 0.obs;
  // final RxBool isLoading = false.obs;
  // final isIconButtonEnabled = RxBool(false);
  // final RxBool isEmpty = false.obs;
  // final ProfileController profileController = Get.put(ProfileController());
  @override
  void onInit() {
    super.onInit();
    bandService.bandsController.checkBand();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // void resetData() async {
  //   isBand.value = false;
  //   createBand.value = false;
  //   bandid.value = 0;
  // }
//  Future<String?> getToken() async{
//       final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('token');
//     if(token != null && JwtDecoder.isExpired(token) == false){
//       return token;
//       }else{
//         return null;
//       }
//  }

// // ! checkBand is have or not have
  Future<void> checkBand() async {
    await bandService.profileController.getProfile();
    print("profileController.profileList");
    print(bandService.profileController.profileList);
    print(bandService.profileController.profileDetail!['userId']);
    print(bandService.profileController.profileList[0].bandType != "0");
    if (bandService.profileController.profileList[0].bandType != "0") {
      bandid.value = bandService.profileController.profileList[0].bandId;
      print("createBand.value in if checkBand");
      print(createBand.value);
      print("bandid.value in if checkBand");
      print(bandid.value);
      createBand.value = true;
      // await getBand();
      print(createBand.value);
    } else {
      bandid.value = 0;
      isBand.value = false;
      createBand.value = false;
      print(createBand.value);
    }
  }

// ! getBand
  Future<void> getBand() async {
    print("isBand.value");
    print(isBand.value);
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final Uri url = Uri.parse(
      '${Config.endPoint}/api/bands/getbybandid/${bandid.value}',
    );
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(url, headers: headers);
    try {
      if (response.statusCode == 200) {
        print(response.body);
        // final dynamic jsonData = jsonDecode(response.body);
        // final data = jsonDecode(response.body)['data'];

// 1. แปลง JSON ใน 'data' เป็น Map
        final Map<String, dynamic> data = jsonDecode(response.body)['data'];
        // print(data.runtimeType);
        // print(data);

// 2. สร้าง ProfileModel จากข้อมูลใน 'data'
        final Band profileModel = Band.fromJson(data);
// 2.1 ลบข้อมูลชุดเดิมออกก่อน
        bandList.clear();
// 3. เพิ่ม ProfileModel เข้าไปใน profileList
        bandList.add(profileModel);
        // final List<dynamic> result = jsonData["data"] as List<dynamic>;
        // print(json.encode(bandList));
        // print(bandList);
        // profileList.value =
        // result.map((e) => ProfileModel.fromJson(e).data).toList();

        // isLoading.value = false;
        // update();
      } else if (response.statusCode == 404) {
        print(response.body);
      } else {
        Get.snackbar("Error Loading data",
            'Server Response: ${response.statusCode}:${response.reasonPhrase.toString()}');
      }
    } catch (e) {
      print(e.toString());
    }
  }

// !  CreateBand api
  Future<http.Response> doCreateBand(
      String name, String category, String filepath) async {
    print(filepath);
    // var token  = getToken();
    // print(token);
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final Uri url = Uri.parse('${Config.endPoint}/api/bands/create');
    var request = http.MultipartRequest('POST', url);
    request.fields['name'] = name;
    request.fields['category'] = category;
    // ระบุชื่อฟิลด์และส่งรูปภาพจาก filepath
    request.files.add(
      await http.MultipartFile.fromPath(
        'avatar',
        filepath,
        contentType: MediaType(
            'image', 'jpeg'), // แก้ mimetype ตรงนี้ตามประเภทของรูปภาพที่คุณใช้
      ),
    );
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token',
    });
    // ทำการส่งคำขอและรับคำขอ
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    return response;
  }

// ! Checkmember in screen band Tab have Condition if  createBand = false rerender button create band else showCheckmember
  Future<void> showMemberInBand() async {
    // isLoading.value = true;

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    // if (token == null || JwtDecoder.isExpired(token)) {
    //   CustomSnackBar.show(
    //     context,
    //     'POST FAILED',
    //     'Invalid token',
    //     Colors.red,
    //     CustomSnackBarContentType.failure,
    //   );
    //   _mainWrapperController.logOut();
    // } else {
    final Uri url = Uri.parse(
      '${Config.endPoint}/api/bands/checkmemberinband/${bandid.value}',
    );
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 404) {
      // CustomSnackBar.show(
      //   context,
      //   'BAND FAILED',
      //   "DON'T HAVE THIS BAND",
      //   Colors.red,
      //   CustomSnackBarContentType.failure,
      // );
    } else if (response.statusCode == 200) {
      final String responseBody = response.body;
      final Map<String, dynamic> jsonRes = json.decode(responseBody);

      final BandModel bandModel = BandModel.fromJson(jsonRes);
      bandModelData.value = bandModel;

      final List<Member> membersList = bandModel.member;

      memberList.clear();
      memberList.addAll(membersList);
      print("memberList");
      print(memberList);
      // Future.delayed(const Duration(seconds: 1), () {
      //   isLoading.value = false; // โหลดข้อมูลเสร็จสิ้น
      // });
    }
    // }
  }

//  ! Delete Band
  Future<void> deleteBand() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final Uri url = Uri.parse(
      '${Config.endPoint}/api/bands/delete',
    );
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode({'band_id': bandid.value});
    final response = await http.delete(url, headers: headers, body: body);
    try {
      if (response.statusCode == 200) {
        print(response.body);
        isBand.value = false;
        createBand.value = false;
      } else if (response.statusCode == 404) {
        print("404");
        print(response.body);
      } else if (response.statusCode == 409) {
        print("409");
        print(response.body);
      } else {
        Get.snackbar("Error Loading data",
            'Server Response: ${response.statusCode}:${response.reasonPhrase.toString()}');
      }
    } catch (e) {
      print(e.toString());
    }
  }
  // Future<http.Response> createBand() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('token');
  //   final url = Uri.parse('${Config.endPoint}/api/comments/');
  //   final headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   };
  //   final body = jsonEncode({'message': message, 'post_id': postid.value});
  //   return await http.post(url, headers: headers, body: body);
  // }

  // void getCommentsBypostid() async {
  //   isLoading.value = true; // เริ่มโหลดข้อมูล
  //   var r =
  //       await Get.put(CommentProvider()).getcommentBypostidApi(postid.value);
  //   var p = r?.comments ?? [];
  //   print(p);
  //   print(r);
  //   if (r == null) {
  //     isEmpty.value = true;
  //     print('no comments');
  //     print(comments);
  //     print(isEmpty.value);
  //   } else {
  //     comments.clear();
  //     comments.addAll(p);
  //     isEmpty.value = false;
  //     print(isEmpty.value);
  //   }
  //   // print(comments);
  //   Future.delayed(const Duration(seconds: 1), () {
  //     isLoading.value = false; // โหลดข้อมูลเสร็จสิ้น
  //   });
  // }

  void increment() => count.value++;
}
