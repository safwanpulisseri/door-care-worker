import 'dart:developer';
import '../model/service_model.dart';
import '../service/remote/select_service_remote_service.dart';

class FetchAllAddedServiceRepo {
  final SelectServiceRemoteService _selectServiceRemoteService;

  FetchAllAddedServiceRepo(
    this._selectServiceRemoteService,
  );

  Future<List<SelectServiceModel>> fetchServicesDetails() async {
    try {
      var response = await _selectServiceRemoteService.fetchAllServiceDetails();

      if (response.statusCode == 200) {
        final List<dynamic> responseData =
            response.data['data'] as List<dynamic>;
        final List<SelectServiceModel> fetchAllServiceModel = responseData
            .map((service) =>
                SelectServiceModel.fromMap(service as Map<String, dynamic>))
            .toList();

        return fetchAllServiceModel;
      } else {
        log('fetch user details failed${response.statusCode}');
        throw Exception();
      }
    } catch (e) {
      log(e.toString());
      throw Exception();
    }
  }
}
