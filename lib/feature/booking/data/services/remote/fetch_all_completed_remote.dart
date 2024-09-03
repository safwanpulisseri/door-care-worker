import 'dart:developer';
import 'package:dio/dio.dart';

class FetchAllCompletedRemote {
  final String _link = "http://10.0.2.2:3000/api/worker/"; // For Android

  final Dio dio = Dio();
  Future<Response<dynamic>> fetchAllCompletedRemoteService({
    required String token,
    required String workerId,
    required String service,
  }) async {
    log("on FetchAllCommitedServiceRemote in dio");
    try {
      var response = await dio.get(
        "${_link}getBookings",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          'userId': null,
          'status': 'completed',
          'workerId': workerId,
          'service': service,
        },
      );
      log("success");
      log("Response data: ${response.data}");
      return response;
    } catch (e) {
      if (e is DioException) {
        log("Error response data: ${e.response?.data}");
        log("Error response headers: ${e.response?.headers}");
        log("Error response status code: ${e.response?.statusCode}");
      }
      log("Error fetchAllCompletedRemoteService: $e");
      throw Exception("Failed to fetchAllCompletedRemoteService");
    }
  }
}
