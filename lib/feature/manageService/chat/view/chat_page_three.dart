import 'package:doorcareworker/core/theme/color/app_color.dart';
import 'package:doorcareworker/feature/manageService/chat/data/service/remote/get_message.dart';
import 'package:doorcareworker/feature/manageService/chat/data/service/remote/send_message.dart';
import 'package:doorcareworker/feature/manageService/chat/data/service/remote/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/util/png_asset.dart';

class ChatPageThree extends StatefulWidget {
  final String conversationId;
  final String senderId;
  final String receiverId;
  final String username;
  final String userProfile;

  ChatPageThree({
    required this.conversationId,
    required this.senderId,
    required this.receiverId,
    required this.username,
    required this.userProfile,
  });

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPageThree> {
  final SocketService _socketService = SocketService();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<dynamic> _messages = [];

  @override
  void initState() {
    super.initState();
    _socketService.initializeSocket(widget.senderId);

    _socketService.listenForMessages((message) {
      setState(() {
        _messages.add(message);
      });
      _scrollToBottom();
    });

    _loadMessages();
  }

  void _loadMessages() async {
    _messages = await getMessages(widget.conversationId);
    setState(() {
      _scrollToBottom(); // Scroll to the bottom after messages are loaded
    });
  }

  void _sendMessage() {
    final messageText = _messageController.text;

    if (messageText.trim().isEmpty) {
      return; // Don't send empty messages
    }

    // Update the UI immediately
    setState(() {
      _messages.add({
        'text': messageText,
        'senderId': widget.senderId,
        'createdAt': DateTime.now().toIso8601String(), // Add createdAt field
      });
    });

    // Send the message via socket and API
    _socketService.sendMessage(widget.conversationId, messageText);
    sendMessage(
        widget.conversationId, widget.senderId, widget.receiverId, messageText);

    // Clear the input field
    _messageController.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _socketService.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.background,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const FaIcon(FontAwesomeIcons.arrowLeft)),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColor.toneThree.withOpacity(0.3),
              backgroundImage: widget.userProfile.isNotEmpty
                  ? NetworkImage(
                      widget.userProfile,
                    )
                  : const AssetImage(AppPngPath.personImage),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              '${widget.username}',
              style: TextStyle(
                color: AppColor.secondary,
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              // padding: EdgeInsets.only(
              //     bottom:
              //         16.0), // Adjust the padding to ensure the last message is fully visible
              itemBuilder: (context, index) {
                final message = _messages[index];

                // Fallback to empty string if 'text' is null
                final messageText = message['text'] ?? '';

                // Fallback to current date and time if 'createdAt' is null
                final createdAt = message['createdAt'] != null
                    ? DateTime.parse(message['createdAt'])
                    : DateTime.now();

                // Format date and time to include AM/PM in 12-hour format
                final formattedDate =
                    DateFormat('dd/MM/yyyy hh:mm a').format(createdAt);

                // Check if senderId is null and compare
                final isCurrentUser = message['senderId'] == widget.senderId;

                return Align(
                  alignment: isCurrentUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: isCurrentUser
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      if (!isCurrentUser) ...[
                        SizedBox(
                          width: 5,
                        ),
                        CircleAvatar(
                          backgroundColor: AppColor.toneThree.withOpacity(0.3),
                          backgroundImage: widget.userProfile.isNotEmpty
                              ? NetworkImage(
                                  widget.userProfile,
                                )
                              : const AssetImage(AppPngPath.personImage)
                                  as ImageProvider,
                          radius: 20,
                        ),
                      ],
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        margin:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                          color: isCurrentUser
                              ? AppColor.primary
                              : AppColor.toneTwelve,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                            topLeft: isCurrentUser
                                ? Radius.circular(12)
                                : Radius.zero,
                            topRight: isCurrentUser
                                ? Radius.zero
                                : Radius.circular(12),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: isCurrentUser
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Text(
                              messageText,
                              style: TextStyle(
                                color: isCurrentUser
                                    ? AppColor.background
                                    : AppColor.secondary,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              formattedDate,
                              style: TextStyle(
                                color: isCurrentUser
                                    ? AppColor.background.withOpacity(0.6)
                                    : AppColor.secondary.withOpacity(0.6),
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                      controller: _messageController,
                      // validator: widget.validator,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColor.textfield,
                        hintText: 'Write your message',
                        hintStyle: const TextStyle(
                          color: AppColor.toneThree,
                          fontSize: 16.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            color: AppColor.primary,
                            width: 1.0,
                          ),
                        ),
                      ),
                      style: GoogleFonts.poppins(
                        color: AppColor.secondary,
                        fontSize: 16.0,
                      )),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Material(
                    shape: const CircleBorder(),
                    color: AppColor.primary,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Icon(
                        size: 30,
                        IconlyLight.send,
                        color: AppColor.background,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
