import 'dart:developer';
import 'package:dio/dio.dart';

class FetchAllPendingServicesRemoteService {
  final String _link = "http://10.0.2.2:3000/api/worker/"; // For android
  //final String _link = "http://127.0.0.1:3000/api/worker/"; // Adjusted for web
  //final String _link = "http://127.0.0.1:3000/api/worker/"; // For iOS simulator

  final Dio dio = Dio();

  Future<Response<dynamic>> fetchAllPendingServiceDetails({
    required String token,
    required String service,
  }) async {
    log("on fetch all service in dio");
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
          'status': 'pending',
          'workerId': null,
          'service': service,
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
      log("Error fetch all pending service: $e");
      throw Exception("Failed to fetch all pending service");
    }
  }
}
