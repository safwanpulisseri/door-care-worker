import 'dart:developer';
import 'package:dio/dio.dart';

class CommitServiceRemoteService {
  final String _link = "http://10.0.2.2:3000/api/worker/"; // For android
  //final String _link = "http://127.0.0.1:3000/api/worker/"; // Adjusted for web
  //final String _link = "http://127.0.0.1:3000/api/worker/"; // For iOS simulator

  final Dio dio = Dio();

  Future<Response<dynamic>> commitService({
    required String token,
    required String workerId,
    required String serviceId,
  }) async {
    log("on commit/accept a new service in dio");
    try {
      var response = await dio.patch(
        "${_link}commitWork",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          'workerId': workerId,
          'status': 'commit',
          '_id': serviceId,
        },
      );
      log("success");
      return response;
    } catch (e) {
      if (e is DioException) {
        log("Error response data: ${e.response?.data}");
        log("Error response headers: ${e.response?.headers}");
        log("Error response status code: ${e.response?.statusCode}");
      }
      log("Error commit/accept a new service: $e");
      throw Exception("Failed to commit/accept a new service");
    }
  }
}
