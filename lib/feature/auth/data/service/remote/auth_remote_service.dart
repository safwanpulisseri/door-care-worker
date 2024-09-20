import 'dart:developer';
// import 'dart:io';
import 'package:dio/dio.dart';
// import 'package:dio/io.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthRemoteService {
  final String _link = dotenv.env['API_LINK']!;

  final Dio dio = Dio();

  // AuthRemoteService() {
  // dio.interceptors.add(
  //   InterceptorsWrapper(
  //     onRequest: (options, handler) {
  //       log('Request[${options.method}] => PATH: ${options.path} => DATA: ${options.data}');
  //       return handler.next(options);
  //     },
  //     onResponse: (response, handler) {
  //       log('Response[${response.statusCode}] => DATA: ${response.data}');
  //       return handler.next(response);
  //     },
  //     onError: (DioException e, handler) {
  //       log('Error[${e.response?.statusCode}] => MESSAGE: ${e.message}');
  //       return handler.next(e);
  //     },
  //   ),
  // );
  // (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
  //   final HttpClient client = HttpClient();
  //   client.badCertificateCallback =
  //       (X509Certificate cert, String host, int port) => true;
  //   return client;
  // };
  //}

  //User sign in
  Future<Response<dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    log("on dio");
    try {
      var response = await dio.post("${_link}login", data: {
        'email': email,
        'password': password,
      });
      log("success");
      return response;
    } catch (e) {
      log('Error during login $e');
      throw Exception();
    }
  }

  //User sign up
  Future<Response<dynamic>> signUp({
    required String name,
    required String password,
    required String email,
    required String mobile,
    required num experience,
    required String district,
    required String service,
    required String idCardImage,
    required String profileImage,
  }) async {
    log("signup in dio");
    try {
      var response = await dio.post(
        "${_link}signup",
        data: {
          'name': name,
          'password': password,
          'email': email,
          'mobile': mobile,
          "experience": experience,
          'district': district,
          'service': service,
          'idCard_img': idCardImage,
          'profile_img': profileImage,
        },
      );
      return response;
    } catch (e) {
      log('Error during sign up $e');
      throw Exception();
    }
  }
}
