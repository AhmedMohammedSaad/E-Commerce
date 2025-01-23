// import 'package:advanced_app/core/apikey.dart';
// import 'package:dio/dio.dart';

// class ApiServices {
//   final Dio _dio = Dio(
//     BaseOptions(
//         baseUrl: 'https://uvedejatxeoieqysxkbc.supabase.co/rest/v1/',
//         headers: {
//           "apikey": apiKey,
//         }),
//   );

// //! get data form api
//   Future<Response> getData(String path) async {
//     return await _dio.get(path);
//   }

// //! post data form api
//   Future<Response> postData(String path, Map<String, dynamic> data) async {
//     return await _dio.post(path, data: data);
//   }

//   //! path data form api
//   Future<Response> pathData(String path, Map<String, dynamic> data) async {
//     return await _dio.patch(path, data: data);
//   }

//   //! delete data form api
//   Future<Response> deleteData(String path) async {
//     return await _dio.delete(path);
//   }
// }
