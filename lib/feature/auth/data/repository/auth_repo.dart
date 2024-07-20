import 'dart:developer';
import '../model/user_model.dart';
import '../service/local/auth_local_service.dart';
import '../service/remote/auth_remote_service.dart';

class AuthRepo {
  final AuthRemoteService _authService;
  //final AuthLocalService _authLocalService;

  AuthRepo(
    this._authService,
    // this._authLocalService,
  );

  // Future<UserModel?> getUser() async {
  //   final UserModel? userModel = await _authLocalService.getUser();
  //   if (userModel != null) {
  //     return userModel;
  //   } else {
  //     return null;
  //   }
  // }

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
        // _authLocalService.saveUser(userModel);
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

  Future<UserModel> userRegistration({
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
}
