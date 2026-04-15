import 'package:get/get.dart';

class FaqController extends GetxController {
  var selectedCategory = 0.obs;

  var expandedIndex = (-1).obs;

  final categories = [
    "General",
    "Account",
    "Service",
    "Payment",
  ];

  final faqs = [
    {
      "question": "How do I make a purchase?",
      "answer":
      "When you find a product, open it, tap Add to Cart and proceed to checkout.",
    },
    {
      "question": "What payment methods are accepted?",
      "answer":
      "We accept cards, UPI, net banking, and wallets.",
    },
    {
      "question": "How do I track my orders?",
      "answer":
      "Go to My Orders and select the order to track.",
    },
    {
      "question": "Can I cancel or return an order?",
      "answer":
      "Yes, depending on order status and return policy.",
    },
    {
      "question": "How can I contact support?",
      "answer":
      "Use the Help section inside the app.",
    },
  ];

  void toggleExpand(int index) {
    if (expandedIndex.value == index) {
      expandedIndex.value = -1;
    } else {
      expandedIndex.value = index;
    }
  }
}