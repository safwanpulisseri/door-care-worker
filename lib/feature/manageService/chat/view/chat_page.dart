import 'package:doorcareworker/feature/manageService/chat/data/service/remote/get_message.dart';
import 'package:doorcareworker/feature/manageService/chat/data/service/remote/send_message.dart';
import 'package:doorcareworker/feature/manageService/chat/data/service/remote/socket_service.dart';
import 'package:doorcareworker/core/theme/color/app_color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/util/png_asset.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatPageThree extends StatefulWidget {
  final String conversationId;
  final String senderId;
  final String receiverId;
  final String username;
  final String userProfile;

  const ChatPageThree({
    super.key,
    required this.conversationId,
    required this.senderId,
    required this.receiverId,
    required this.username,
    required this.userProfile,
  });

  @override
  createState() => _ChatPageState();
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
          duration: const Duration(milliseconds: 300),
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

// Method to check if two dates are on the same day
  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
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
            const SizedBox(
              width: 10,
            ),
            Text(
              // ignore: unnecessary_string_interpolations
              '${widget.username}',
              style: const TextStyle(
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
            child: _messages.isEmpty
                ? Center(
                    child: Text(
                      'No messages yet.',
                      style: TextStyle(
                        color: AppColor.secondary.withOpacity(0.6),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      final messageText = message['text'] ?? '';
                      final createdAt = message['createdAt'] != null
                          ? DateTime.parse(message['createdAt'])
                          : DateTime.now();
                      final formattedDate =
                          DateFormat('hh:mm a').format(createdAt);
                      final isCurrentUser =
                          message['senderId'] == widget.senderId;

                      // Check if this message is the first message of the day
                      bool showDateHeader = true;
                      if (index > 0) {
                        final previousMessageDate =
                            DateTime.parse(_messages[index - 1]['createdAt']);
                        showDateHeader =
                            !_isSameDay(createdAt, previousMessageDate);
                      }

                      String dateHeader;
                      if (_isSameDay(createdAt, DateTime.now())) {
                        dateHeader = 'Today';
                      } else if (_isSameDay(createdAt,
                          DateTime.now().subtract(const Duration(days: 1)))) {
                        dateHeader = 'Yesterday';
                      } else {
                        dateHeader =
                            DateFormat('EEEE, dd MMMM yyyy').format(createdAt);
                      }

                      return Column(
                        children: [
                          if (showDateHeader)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                dateHeader,
                                style: TextStyle(
                                  color: AppColor.secondary.withOpacity(0.6),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          Align(
                            alignment: isCurrentUser
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: isCurrentUser
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                if (!isCurrentUser) ...[
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  CircleAvatar(
                                    backgroundColor:
                                        AppColor.toneThree.withOpacity(0.3),
                                    backgroundImage:
                                        widget.userProfile.isNotEmpty
                                            ? NetworkImage(
                                                widget.userProfile,
                                              )
                                            : const AssetImage(
                                                    AppPngPath.personImage)
                                                as ImageProvider,
                                    radius: 20,
                                  ),
                                ],
                                Flexible(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 16),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 8),
                                    decoration: BoxDecoration(
                                      color: isCurrentUser
                                          ? AppColor.primary
                                          : AppColor.toneTwelve,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: const Radius.circular(12),
                                        bottomRight: const Radius.circular(12),
                                        topLeft: isCurrentUser
                                            ? const Radius.circular(12)
                                            : Radius.zero,
                                        topRight: isCurrentUser
                                            ? Radius.zero
                                            : const Radius.circular(12),
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
                                          softWrap: true,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          formattedDate,
                                          style: TextStyle(
                                            color: isCurrentUser
                                                ? AppColor.background
                                                    .withOpacity(0.6)
                                                : AppColor.secondary
                                                    .withOpacity(0.6),
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: _sendMessage,
                  child: const Material(
                    shape: CircleBorder(),
                    color: AppColor.primary,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
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
