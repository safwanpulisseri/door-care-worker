import 'dart:developer';
import '../../../auth/data/service/local/auth_local_service.dart';
import '../service/remote/fetch_wallet_amount_remote.dart';

class FetchWalletAmountRepo {
  final FetchWalletAmountRemote _fetchWalletAmountRemote;
  final AuthLocalService _authLocalService;
  FetchWalletAmountRepo(
    this._fetchWalletAmountRemote,
    this._authLocalService,
  );

  Future<List<Map<String, dynamic>>>
      fetchUsersAllDetailsForWalletAmount() async {
    try {
      String? token = await _authLocalService.getToken();
      if (token == null) {
        throw Exception('No token Found');
      }
      var response = await _fetchWalletAmountRemote.fetchWokersDetails(token);
      if (response.statusCode == 200) {
        final List<dynamic> responseData =
            response.data['data'] as List<dynamic>;

        // Extract only the _id and wallet fields
        final List<Map<String, dynamic>> walletData = responseData.map((user) {
          final Map<String, dynamic> userMap = user as Map<String, dynamic>;
          return {
            '_id': userMap['_id'],
            'wallet': userMap['wallet'],
          };
        }).toList();

        return walletData;
      } else {
        log("Failed to fetch all workers details for fetching wallet amount. Status code: ${response.statusCode}");
        throw Exception('Failed to fetch wallet amounts');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('An error occurred while fetching wallet amounts');
    }
  }
}
