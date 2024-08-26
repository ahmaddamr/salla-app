import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(
      BaseOptions(
        validateStatus: (status) {
          return status! <
              500; // Accept all responses with status code less than 500
        },
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
    String lang = 'en',
  }) async {
    dio!.options.headers = {
      'Authorization': token ?? "",
      'lang': lang,
      'Content-Type': 'application/json'
    };

    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData(
      {required String url,
      Map<String, dynamic>? query,
      String? token,
      String lang = 'en',
      required Map<String, dynamic> data}) async {
    dio!.options.headers = {
      'Authorization': token ?? "",
      'lang': lang,
      'Content-Type': 'application/json'
    };

    return await dio!.post(url, queryParameters: query, data: data);
  }
}

// class DioHelper {
//   static Dio? dio;

//   static init() {
//     dio = Dio(BaseOptions(
//         receiveDataWhenStatusError: true,
//         baseUrl: 'https://student.valuxapps.com/api/',
//         headers: {'Content-Type': 'application/json'}));
//   }

//   static Future<Response> getData({
//     required String url,
//     Map<String, dynamic>? query,
//     String lang = 'en',
//     String? token,
//   }) async {
//     dio!.options.headers = {
//       'Content-Type': 'application/json',
//       'lang': lang,
//       'Authorization': token ?? ''
//     };
//     return await dio!.get(url, queryParameters: query);
//   }

//   static Future<Response> postData({
//     required String url,
//     Map<String, dynamic>? query,
//     required Map<String, dynamic>? data,
//     String lang = 'en',
//     String? token,
//   }) async {
//     dio!.options.headers = {
//       'Content-Type': 'application/json',
//       'lang': lang,
//       'Authorization': token,
//     };
//     return await dio!.post(url, queryParameters: query, data: data);
//   }
// }