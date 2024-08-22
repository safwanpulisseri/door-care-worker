import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:doorcareworker/feature/auth/data/model/user_model.dart';
import '../../../auth/data/service/local/auth_local_service.dart';
import '../service/remote/commit_service_remote_service.dart';

class CommitNewServiceRepo {
  final CommitServiceRemoteService _commitServiceRemoteService;
  final AuthLocalService _authLocalService;

  CommitNewServiceRepo(
      this._commitServiceRemoteService, this._authLocalService);

  Future<Response<dynamic>> commitNewService({
    required String serviceId,
  }) async {
    try {
      String? token = await _authLocalService.getToken();
      if (token == null) {
        throw Exception('No token Found');
      }
      UserModel? userModel = await _authLocalService.getUser();
      if (userModel == null) {
        throw Exception('No User Found');
      }
      String workerId = userModel.id;

      var response = await _commitServiceRemoteService.commitService(
        token: token,
        workerId: workerId,
        serviceId: serviceId,
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        log('commit/accept a new service failed with status code: ${response.statusCode}');
        throw Exception('commit/accept a new service failed');
      }
    } catch (e) {
      log(e.toString());
      throw Exception();
    }
  }
}
