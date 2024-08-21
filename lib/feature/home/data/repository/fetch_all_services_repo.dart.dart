import 'dart:developer';
import 'package:doorcareworker/feature/auth/data/model/user_model.dart';
import '../../../auth/data/service/local/auth_local_service.dart';
import '../model/fetch_all_service_model.dart';
import '../service/remote/fetch_all_services_remote_service.dart';

class FetchAllServiceRepo {
  final FetchAllPendingServicesRemoteService _fetchAllServicesRemoteService;
  final AuthLocalService _authLocalService;

  FetchAllServiceRepo(
      this._fetchAllServicesRemoteService, this._authLocalService);

  Future<List<FetchAllServiceModel>> fetchServicesDetails() async {
    try {
      String? token = await _authLocalService.getToken();
      if (token == null) {
        throw Exception('No token Found');
      }
      UserModel? userModel = await _authLocalService.getUser();
      if (userModel == null) {
        throw Exception('No User Found');
      }
      String serviceName = userModel.service;

      var response =
          await _fetchAllServicesRemoteService.fetchAllPendingServiceDetails(
        token: token,
        service: serviceName,
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData =
            response.data['data'] as List<dynamic>;
        final List<FetchAllServiceModel> fetchAllServiceModel = responseData
            .map((service) =>
                FetchAllServiceModel.fromMap(service as Map<String, dynamic>))
            .toList();

        return fetchAllServiceModel;
      } else {
        log('fetch user details failed ${response.statusCode}');
        throw Exception('Failed to fetch service details');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('An error occurred while fetching services');
    }
  }
}
