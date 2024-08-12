import 'dart:developer';
import 'package:dio/dio.dart';

class SelectServiceRemoteService {
  final String _link = "http://10.0.2.2:3000/api/admin/"; // For android
  //final String _link = "http://127.0.0.1:3000/api/worker/"; // For iOS simulator
  //final String _link = "http://127.0.0.1:3000/api/worker/"; // Adjusted for web
  final Dio dio = Dio();

  Future<Response<dynamic>> fetchAllServiceDetails() async {
    log("on fetch all service in dio");
    try {
      var response = await dio.get(
        "${_link}getServices",
      );
      log("success");
      return response;
    } catch (e) {
      log("Error fetch all service: $e");
      throw Exception("Failed to fetch all service");
    }
  }
}
