import 'dart:developer';
import 'package:dio/dio.dart';

class AuthRemoteService {
  final String _link = "http://10.0.2.2:3000/api/worker/"; // For android
  //final String _link = "http://127.0.0.1:3000/api/worker/"; // For iOS simulator
  //final String _link = "http://127.0.0.1:3000/api/worker/"; // Adjusted for web
  final Dio dio = Dio();

  AuthRemoteService() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          log('Request[${options.method}] => PATH: ${options.path} => DATA: ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          log('Response[${response.statusCode}] => DATA: ${response.data}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          log('Error[${e.response?.statusCode}] => MESSAGE: ${e.message}');
          return handler.next(e);
        },
      ),
    );
  }

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
