import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/color/app_color.dart';
import '../../../../core/util/png_asset.dart';
import '../../../../core/widget/padding_widget.dart';
import '../../../manageService/chat/data/service/remote/start_chat.dart';
import '../../../manageService/chat/view/chat_page.dart';
import '../../../manageService/inc/view/page/generate_bill.dart';
import '../../../service/view/widgets/location_fetching_widget.dart';
import '../../data/model/fetch_all_commited_service_model.dart';
import '../../provider/card_expanded_provider.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.service,
  });

  final FetchAllCommitedServiceModel service;

  @override
  Widget build(BuildContext context) {
    void navigateToChatPage(String senderId, String receiverId) async {
      try {
        // Get the conversation details from the API
        final response = await startConversation(senderId, receiverId);

        final conversationId = response['conversationId'];
        final username = response['username'];
        final userProfile = response['userProfile'];

        // Navigate to the chat page with the obtained conversation ID, username, and user profile
        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => ChatPageThree(
              conversationId: conversationId,
              senderId: senderId,
              receiverId: receiverId,
              username: username,
              userProfile: userProfile,
            ),
          ),
        );
      } catch (e) {
        // Handle errors if the API call fails
        if (kDebugMode) {
          print('Error: $e');
        }
        // Optionally, show an error message to the user
      }
    }

    return ChangeNotifierProvider(
      create: (context) => CardState(),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColor.toneThree.withOpacity(0.4),
            ),
          ),
          child: PaddingWidget(
            // padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: service.serviceImg.isNotEmpty
                          ? NetworkImage(service.serviceImg)
                          : const AssetImage(AppPngPath.homeCleanTwo),
                      // onBackgroundImageError:
                      //     (exception, stackTrace) {
                      //   // Optionally handle image loading errors here
                      // },
                    ),
                    const SizedBox(width: 10),
                    Consumer<CardState>(
                      builder: (context, cardState, _) => Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              service.serviceName,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                cardState.toggleExpanded();
                              },
                              child: Text(
                                'Booking ID: ${service.id}',
                                style: const TextStyle(
                                  color: AppColor.toneThree,
                                ),
                                overflow: cardState.isExpanded
                                    ? TextOverflow.visible
                                    : TextOverflow.ellipsis,
                                maxLines: cardState.isExpanded ? 2 : 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Divider(),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Work Status',
                      style: TextStyle(
                        color: AppColor.toneThree,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Chip(
                      side: BorderSide.none,
                      label: Text(
                        '${service.status}ted',
                        style: const TextStyle(color: AppColor.toneSix),
                      ),
                      backgroundColor: AppColor.toneSix.withOpacity(0.2),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Payment Status',
                      style: TextStyle(
                        color: AppColor.toneThree,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Chip(
                      side: BorderSide.none,
                      label: const Text(
                        'Pending',
                        style: TextStyle(color: AppColor.toneSix),
                      ),
                      backgroundColor: AppColor.toneSix.withOpacity(0.2),
                    ),
                  ],
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColor.toneThree.withOpacity(0.7),
                            width: 1.0,
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(7.0),
                          child: Icon(
                            IconlyLight.calendar,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      DateFormat('dd-MM-yyyy').format(service.createdAt),
                      style: const TextStyle(
                        color: AppColor.secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                LocationFetchingWidget(
                  latitude: service.latitude,
                  longitude: service.longitude,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // context.read<CancelABookedPendingServiceBloc>().add(
                        //       CancelBookedPendingServiceEvent(
                        //         bookingId: service.id,
                        //       ),
                        //     );
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => ManageServiceHome(
                        //       latitude: service.latitude,
                        //       longitude: service.longitude,
                        //     ),
                        //   ),
                        // );
                        // context.read<CreateConversationBloc>().add(
                        //       CreateAConversationEvent(
                        //         receiverId: service.userId,
                        //       ),
                        //     );
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => ChatScreen()));
                        // Example usage
                        navigateToChatPage(service.workerId!, service.userId);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Chat',
                        style: TextStyle(color: AppColor.background),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GenerateBillPage(
                              bookingId: service.id,
                              firstHourCharge: service.firstHourCharge,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Start Work',
                        style: TextStyle(color: AppColor.background),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
