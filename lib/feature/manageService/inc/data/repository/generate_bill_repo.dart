import 'dart:developer';
import 'package:dio/dio.dart';
import '../../../../auth/data/service/local/auth_local_service.dart';
import '../services/remote/generate_bill_remote.dart';

class GenerateBillServiceRepo {
  final GenerateBillRemoteService _generateBillRemoteService;
  final AuthLocalService _authLocalService;

  GenerateBillServiceRepo(
    this._generateBillRemoteService,
    this._authLocalService,
  );

  Future<Response<dynamic>> generateBillRepo({
    required String bookingId,
    required num bookingPrice,
  }) async {
    try {
      String? token = await _authLocalService.getToken();
      if (token == null) {
        throw Exception('No token Found');
      }

      var response = await _generateBillRemoteService.generateBillRemote(
        token: token,
        id: bookingId,
        price: bookingPrice,
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        log('generateBillRepo failed with status code: ${response.statusCode}');
        throw Exception('generateBillRepo failed');
      }
    } catch (e) {
      log(e.toString());
      throw Exception();
    }
  }
}
