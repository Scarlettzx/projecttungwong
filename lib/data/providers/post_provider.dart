// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../utils/config.dart';
// import '../models/post_model.dart';

// class PostProvider extends GetConnect {
//   @override
//   void onInit() {
//     httpClient.defaultDecoder = (map) {
//       if (map is Map<String, dynamic>) return Posts.fromJson(map);
//       if (map is List) return map.map((item) => Posts.fromJson(item)).toList();
//     };
//     httpClient.baseUrl = Config.endPoint;
//   }

//   Future<Posts?> getApi() async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('token'); // ดึง Token จาก SharedPreferences
//     final response = await get(
//       '/api/posts/',
//       headers: {'Authorization': 'Bearer $token'},
//     );
//     if (token != null && JwtDecoder.isExpired(token) == false) {
//       return response.body;
//     } else if (response.statusCode == 498) {
//       // กรณีไม่พบ Token ใน SharedPreferences
//       Get.snackbar("GETPOST FAILED", "Token invalid");

//       // ในกรณีนี้คุณสามารถจัดการกับการเรียก API ได้ตามความต้องการของคุณ เช่น คืนค่าที่ต้องการหรือทำอะไรก็ตามที่คุณต้องการ
//       return null;
//     }

//     // Future<Response<Api>> postApi(Api api) async => await post('api', api);
//     // Future<Response> deleteApi(int id) async => await delete('api/$id');
//   }
// }
