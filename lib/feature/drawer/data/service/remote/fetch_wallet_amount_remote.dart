import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FetchWalletAmountRemote {
  final String _link = dotenv.env['ADMIN_API_LINK']!;

  final Dio dio = Dio();

  Future<Response<dynamic>> fetchWokersDetails(String token) async {
    log("on get all workers dio");
    try {
      log("auth token in fetchWokersDetails : $token");
      var response = await dio.get(
        "${_link}getJoinRequests",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      log("success");
      return response;
    } catch (e) {
      log("Error getting all workers details for fetching wallet amount : $e");
      throw Exception();
    }
  }
}
