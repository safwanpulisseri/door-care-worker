import 'dart:developer';
import 'package:dio/dio.dart';
import '../model/user_model.dart';
import '../service/remote/auth_remote_service.dart';

class AuthRepo {
  final AuthRemoteService _authService;

  AuthRepo(
    this._authService,
  );

  Future<UserModel> emailSignIn({
    required String email,
    required String password,
  }) async {
    try {
      var response = await _authService.signIn(
        email: email,
        password: password,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData =
            response.data['data'] as Map<String, dynamic>;
        final UserModel userModel = UserModel.fromMap(responseData);
        return userModel;
      } else {
        log('Login failed${response.statusCode}');
        throw Exception();
      }
    } catch (e) {
      log(e.toString());
      throw Exception();
    }
  }

  Future<Response<dynamic>> userRegistration({
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
    try {
      var response = await _authService.signUp(
        name: name,
        password: password,
        email: email,
        mobile: mobile,
        experience: experience,
        district: district,
        service: service,
        idCardImage: idCardImage,
        profileImage: profileImage,
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        log('Registration failed${response.statusCode}');
        throw Exception();
      }
    } catch (e) {
      log(e.toString());
      throw Exception();
    }
  }
}
