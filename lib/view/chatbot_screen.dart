import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import '../controller/chatbot_controller.dart';
import '../widgets/customAppBar.dart';

class ChatbotScreen extends StatelessWidget {
  const ChatbotScreen({Key? key}) : super(key: key);

  static const _darkOlive = Color(0xFF3B3B2A);
  static const _bubbleGrey = Color(0xFFF0F0F0);
  static const _dateBadge = Color(0xFFF5EDD6);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatbotController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Chatbot',
        showWishlist: false,
        showNotification: true,
        showMenu: false,
      ),
      body: Column(
        children: [
          // ── Messages List ──
          Expanded(
            child: Obx(() => ListView.builder(
              controller: controller.scrollController,
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 12),
              itemCount: controller.messages.length +
                  (controller.isTyping.value ? 1 : 0),
              itemBuilder: (context, index) {
                // Date badge at top
                if (index == 0) {
                  return Column(
                    children: [
                      _dateBadgeWidget('Today'),
                      const SizedBox(height: 12),
                      _buildMessageTile(
                          controller.messages[index], controller),
                    ],
                  );
                }

                // Typing indicator
                if (controller.isTyping.value &&
                    index == controller.messages.length) {
                  return _typingIndicator();
                }

                return _buildMessageTile(
                    controller.messages[index], controller);
              },
            )),
          ),

          // ── Input Bar ──
          _buildInputBar(controller),
        ],
      ),
    );
  }

  // ── Date Badge ──
  Widget _dateBadgeWidget(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: _dateBadge,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }

  // ── Message Tile ──
  Widget _buildMessageTile(ChatMessage msg, ChatbotController controller) {
    final isUser = msg.isUser;

    // Find if this is the last message in a group to show timestamp
    final index = controller.messages.indexOf(msg);
    final isLastInGroup = index == controller.messages.length - 1 ||
        controller.messages[index + 1].isUser != isUser;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Column(
        crossAxisAlignment:
        isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Align(
            alignment:
            isUser ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 270),
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: isUser ? _darkOlive : _bubbleGrey,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(isUser ? 18 : 4),
                  bottomRight: Radius.circular(isUser ? 4 : 18),
                ),
              ),
              child: Text(
                msg.text,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: isUser ? Colors.white : Colors.black87,
                  height: 1.4,
                ),
              ),
            ),
          ),

          // Timestamp — only after last bubble in group
          if (isLastInGroup) ...[
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                msg.time,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }

  // ── Typing Indicator ──
  Widget _typingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: _bubbleGrey,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (i) => _dot(i)),
        ),
      ),
    );
  }

  Widget _dot(int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 400 + index * 150),
      builder: (_, val, __) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        width: 7,
        height: 7,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.4 + val * 0.6),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  // ── Input Bar ──
  Widget _buildInputBar(ChatbotController controller) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.textController,

                      // ✅ FIX: update Rx value
                      onChanged: (val) {
                        controller.messageText.value = val;
                      },

                      onSubmitted: (_) => controller.sendMessage(),
                      decoration: const InputDecoration(
                        hintText: 'Write your message...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Icon(Icons.image_outlined,
                      color: Colors.grey, size: 22),
                ],
              ),
            ),
          ),

          const SizedBox(width: 10),

          // ✅ FIX: Proper Obx usage
          Obx(() {
            final hasText =
                controller.messageText.value.trim().isNotEmpty;

            return GestureDetector(
              onTap: controller.sendMessage,
              child: Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B3B2A),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  hasText ? Icons.send_rounded : Icons.mic,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}