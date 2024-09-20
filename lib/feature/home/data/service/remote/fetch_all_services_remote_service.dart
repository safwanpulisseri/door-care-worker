import 'dart:developer';
// import 'dart:io';
import 'package:dio/dio.dart';
// import 'package:dio/io.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FetchAllPendingServicesRemoteService {
  final String _link = dotenv.env['API_LINK']!;

  final Dio dio = Dio();

//   FetchAllPendingServicesRemoteService() {
//     dio.interceptors.add(
//       InterceptorsWrapper(
//         onRequest: (options, handler) {
//           log('Request[${options.method}] => PATH: ${options.path} => DATA: ${options.data}');
//           return handler.next(options);
//         },
//         onResponse: (response, handler) {
//           log('Response[${response.statusCode}] => DATA: ${response.data}');
//           return handler.next(response);
//         },
//         onError: (DioException e, handler) {
//           log('Error[${e.response?.statusCode}] => MESSAGE: ${e.message}');
//           return handler.next(e);
//         },
//       ),
//     );
// // Disable SSL verification for debugging purposes
//     (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
//       final HttpClient client = HttpClient();
//       client.badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//       return client;
//     };
//   }

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
