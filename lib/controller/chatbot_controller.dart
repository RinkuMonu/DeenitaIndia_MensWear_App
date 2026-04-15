import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatMessage {
  final String text;
  final String time;
  final bool isUser;

  ChatMessage({
    required this.text,
    required this.time,
    required this.isUser,
  });
}

class ChatbotController extends GetxController {
  final textController = TextEditingController();
  final scrollController = ScrollController();

  RxList<ChatMessage> messages = <ChatMessage>[].obs;
  RxBool isTyping = false.obs;

  // ✅ FIX: reactive text
  RxString messageText = ''.obs;

  void sendMessage() {
    final text = messageText.value.trim();
    if (text.isEmpty) return;

    messages.add(ChatMessage(
      text: text,
      time: _getTime(),
      isUser: true,
    ));

    messageText.value = '';
    textController.clear();

    _scrollToBottom();

    // fake bot reply
    isTyping.value = true;

    Future.delayed(const Duration(seconds: 1), () {
      isTyping.value = false;

      messages.add(ChatMessage(
        text: "This is a bot response",
        time: _getTime(),
        isUser: false,
      ));

      _scrollToBottom();
    });
  }

  String _getTime() {
    final now = TimeOfDay.now();
    return now.format(Get.context!);
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void onClose() {
    textController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}