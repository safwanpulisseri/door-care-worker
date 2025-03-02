import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GenerateBillRemoteService {
  final String _link = dotenv.env['API_LINK']!;

  final Dio dio = Dio();
  Future<Response<dynamic>> generateBillRemote({
    required String token,
    required String id,
    required num price,
  }) async {
    log("on generateBillRemoteService in dio");
    try {
      var response = await dio.post(
        "${_link}generateBill",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          '_id': id,
          'price': price,
          'status': 'completed',
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
      log("Error generateBillRemoteService: $e");
      throw Exception("Failed to generateBillRemoteService");
    }
  }
}
