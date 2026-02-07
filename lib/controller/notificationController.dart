// controllers/notification_controller.dart
import 'package:get/get.dart';

class NotificationModel {
  final String time;
  final String title;
  final String subTitle;
  final String image;

  NotificationModel({
    required this.time,
    required this.title,
    required this.subTitle,
    required this.image,
  });
}

class NotificationController extends GetxController {
  final RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    isLoading.value = true;

    Future.delayed(const Duration(seconds: 2), () {
      notifications.addAll([
        NotificationModel(
          time: "Just now",
          title: "Order Confirmed",
          subTitle: "Your order #12345 has been confirmed",
          image: "https://cdn-icons-png.flaticon.com/512/190/190411.png",
        ),
        NotificationModel(
          time: "10 min ago",
          title: "Special Offer 🎉",
          subTitle: "Get 20% off on your next purchase",
          image: "https://cdn-icons-png.flaticon.com/512/891/891462.png",
        ),
        NotificationModel(
          time: "Yesterday",
          title: "Payment Successful",
          subTitle: "₹499 paid successfully via UPI",
          image: "https://cdn-icons-png.flaticon.com/512/3144/3144456.png",
        ),
      ]);

      isLoading.value = false;
    });
  }
}