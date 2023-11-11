import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/video_model.dart';
import '../services/bandservice.dart';
import '../utils/config.dart';

class VideosController extends GetxController {
  final BandService bandService = Get.find();
  final RxBool isLoading = false.obs;
  final RxList<Video> videos = <Video>[].obs;
  Future<void> getVideos() async {
    print("getVideos()");
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final Uri url = Uri.parse('${Config.endPoint}/api/videos/');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      isLoading.value = true; // เริ่มโหลดข้อมูล
      final response = await http.get(url, headers: headers);
      if (response.statusCode == HttpStatus.ok) {
        final videosData = videosFromJson(response.body);
        videos.assignAll(videosData.videos!.whereType<Video>());
        print("videos");
        print(videos);
      }
    } catch (e) {
      print('Error fetching posts: $e');
    } finally {
      Future.delayed(const Duration(seconds: 1), () {
        isLoading.value = false; // โหลดข้อมูลเสร็จสิ้น
      }); // โหลดข้อมูลเสร็จสิ้น
    }
  }

  Future<void> getVideosbyUserid(int userid) async {
    print("getVideosbyUserid()");
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    //  (bandService.bandsController.isBand.value == false)
    final Uri url =
        Uri.parse('${Config.endPoint}/api/videos/getVideosByuserid/$userid');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      isLoading.value = true; // เริ่มโหลดข้อมูล
      final response = await http.get(url, headers: headers);
      if (response.statusCode == HttpStatus.ok) {
        final videosData = videosFromJson(response.body);
        videos.assignAll(videosData.videos!.whereType<Video>());
        print("videos");
        print(videos);
      }
    } catch (e) {
      print('Error fetching posts: $e');
    } finally {
      Future.delayed(const Duration(seconds: 1), () {
        isLoading.value = false; // โหลดข้อมูลเสร็จสิ้น
      }); // โหลดข้อมูลเสร็จสิ้น
    }
  }

  Future<void> getVideosbyBandid(int bandid) async {
    print("getVideosbyBandid()");
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    //  (bandService.bandsController.isBand.value == false)
    final Uri url =
        Uri.parse('${Config.endPoint}/api/videos/getVideosBybandid/$bandid');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      isLoading.value = true; // เริ่มโหลดข้อมูล
      final response = await http.get(url, headers: headers);
      if (response.statusCode == HttpStatus.ok) {
        final videosData = videosFromJson(response.body);
        videos.assignAll(videosData.videos!.whereType<Video>());
        print("videos");
        print(videos);
      }
    } catch (e) {
      print('Error fetching posts: $e');
    } finally {
      Future.delayed(const Duration(seconds: 1), () {
        isLoading.value = false; // โหลดข้อมูลเสร็จสิ้น
      }); // โหลดข้อมูลเสร็จสิ้น
    }
  }

  Future<http.Response> editVideo(int videoid, String message) async {
    // isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = Uri.parse('${Config.endPoint}/api/videos/editvideo');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode({'video_id': videoid, "video_message": message});
    return await http.patch(url, headers: headers, body: body);
  }

  Future<http.Response> deleteVideo(int videoid) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = Uri.parse('${Config.endPoint}/api/videos/deletevideo');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode({'video_id': videoid});
    return await http.delete(url, headers: headers, body: body);
  }

  @override
  void onInit() {
    super.onInit();
    getVideos();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

//   Future<void> getBand() async {
//     print("isBand.value");
//     print(isBand.value);
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('token');
//     final Uri url = Uri.parse(
//       '${Config.endPoint}/api/bands/getbybandid/${bandid.value}',
//     );
//     final headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $token',
//     };
//     final response = await http.get(url, headers: headers);
//     try {
//       if (response.statusCode == 200) {
//         print(response.body);
//         // final dynamic jsonData = jsonDecode(response.body);
//         // final data = jsonDecode(response.body)['data'];

// // 1. แปลง JSON ใน 'data' เป็น Map
//         final Map<String, dynamic> data = jsonDecode(response.body)['data'];
//         // print(data.runtimeType);
//         // print(data);

// // 2. สร้าง ProfileModel จากข้อมูลใน 'data'
//         final Band profileModel = Band.fromJson(data);
// // 2.1 ลบข้อมูลชุดเดิมออกก่อน
//         bandList.clear();
// // 3. เพิ่ม ProfileModel เข้าไปใน profileList
//         bandList.add(profileModel);
//         // final List<dynamic> result = jsonData["data"] as List<dynamic>;
//         // print(json.encode(bandList));
//         // print(bandList);
//         // profileList.value =
//         // result.map((e) => ProfileModel.fromJson(e).data).toList();

//         // isLoading.value = false;
//         // update();
//       } else if (response.statusCode == 404) {
//         print(response.body);
//       } else {
//         Get.snackbar("Error Loading data",
//             'Server Response: ${response.statusCode}:${response.reasonPhrase.toString()}');
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }

// !  doUploadvideo api
  Future<http.Response> doUploadvideo(String message, String videopath) async {
    print(videopath);
    var streamedResponse;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (bandService.bandsController.isBand.value == false) {
      final Uri url =
          Uri.parse('${Config.endPoint}/api/videos/createvideobyuser');
      var request = http.MultipartRequest('POST', url);
      request.fields['message'] = message;
      // ระบุชื่อฟิลด์และส่งรูปภาพจาก filepath
      request.files.add(
        await http.MultipartFile.fromPath(
          'video',
          videopath,
          contentType: MediaType(
              'video', 'mp4'), // แก้ mimetype ตรงนี้ตามประเภทของรูปภาพที่คุณใช้
        ),
      );
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $token',
      });
      streamedResponse = await request.send();
    } else if (bandService.bandsController.isBand.value == true) {
      final Uri url =
          Uri.parse('${Config.endPoint}/api/videos/createvideobyband');
      var request = http.MultipartRequest('POST', url);
      request.fields['message'] = message;
      request.fields['band_id'] =
          bandService.bandsController.bandid.value.toString();
      // ระบุชื่อฟิลด์และส่งรูปภาพจาก filepath
      request.files.add(
        await http.MultipartFile.fromPath(
          'video',
          videopath,
          contentType: MediaType(
              'video', 'mp4'), // แก้ mimetype ตรงนี้ตามประเภทของรูปภาพที่คุณใช้
        ),
      );
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $token',
      });
      streamedResponse = await request.send();
    }
    var response = await http.Response.fromStream(streamedResponse);
    return response;
  }
}
