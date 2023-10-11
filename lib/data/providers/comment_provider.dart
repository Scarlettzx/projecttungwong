import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/utils/color.constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../../utils/config.dart';
import '../../utils/config.dart';
import '../models/comment_model.dart';

class CommentProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Comments.fromJson(map);
      if (map is List) {
        return map.map((item) => Comments.fromJson(item)).toList();
      }
    };
    httpClient.baseUrl = Config.endPoint;
  }

  Future<Comments?> getcommentBypostidApi(int postid) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token'); // ดึง Token จาก SharedPreferences
    try {
      if (token != null) {
        final response = await get(
          '/api/comments/$postid',
          headers: {'Authorization': 'Bearer $token'},
        );
        print(response.statusCode);
        print(response);
        print(response.body);
        Comments commentsObject = response.body; // ให้กำหนดค่าเองตามที่คุณมี
        Map<String, dynamic> commentsMap = commentsObject.toJson();
        print(commentsMap);
        // print(jsonRes);
        if (response.statusCode == 200) {
          // ในกรณีที่สถานะเป็น 200 (OK) แปลง response.body เป็น Comments
          return response.body;
          // } else if (response.statusCode == 404) {
          //   if (jsonRes['message'] == 'Record not Found') {
          //     Get.snackbar(
          //       'Error Message: ',
          //       "Record not found",
          //       colorText: Colors.white,
          //       backgroundColor: ColorConstants.appColors,
          //       icon: const Icon(Icons.add_alert),
          //     );
          //   }
        }
      } else {
        // กรณีไม่พบ Token ใน SharedPreferences
        Get.snackbar(
          'Error Token',
          "Invalid Token",
          colorText: Colors.white,
          backgroundColor: ColorConstants.appColors,
          icon: const Icon(Icons.add_alert),
        );
        // ในกรณีนี้คุณสามารถจัดการกับการเรียก API ได้ตามความต้องการของคุณ เช่น คืนค่าที่ต้องการหรือทำอะไรก็ตามที่คุณต้องการ
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  // Future<Response<Api>> postApi(Api api) async => await post('api', api);
  // Future<Response> deleteApi(int id) async => await delete('api/$id');
}
