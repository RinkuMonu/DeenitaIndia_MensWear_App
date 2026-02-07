import 'package:deenitaindia/constants/image.dart';
import 'package:deenitaindia/widgets/customAppBar.dart';
import 'package:deenitaindia/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controller/notificationController.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationController controller =
  Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: "Notification",
        showMenu: false,
        appBarBgColor: Colors.white,
        showNotification: false,
        showWishlist: false,
      ),
      body: Obx(() {

        if(controller.isLoading.value){
          return Center(child: AppLoader());
        }


        if (controller.notifications.isEmpty) {
          return Center(
            child: SingleChildScrollView(
              child: _emptyNotification(),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.only(top: 16),
          itemCount: controller.notifications.length,
          separatorBuilder: (context, index) =>
          const Divider(),
          itemBuilder: (context, index) {
            final item = controller.notifications[index];
            return _notificationItemWidget(
              time: item.time,
              title: item.title,
              subTitle: item.subTitle,
              image: item.image,
            );
          },
        );
      }),
    );
  }

  // ───────────────── EMPTY STATE ─────────────────

  Widget _emptyNotification() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(AppImage.emptyNotification, height: 55),
        const SizedBox(height: 12),
        const Text(
          "You don’t have any\nnotifications",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          "We’ll notify you when there’s \nsomething new",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  // ───────────────── ITEM UI ─────────────────

  Widget _notificationItemWidget({
    required String time,
    required String title,
    required String subTitle,
    required String image,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            time,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Image.network(
            image,
            height: 50,
            width: 50,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.notifications,
                size: 40,
                color: Colors.grey,
              );
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return  SizedBox(
                height: 50,
                width: 50,
                child: Center(
                  child: AppLoader(),
                ),
              );
            },
          ),
              const SizedBox(width: 16),

              // ✅ THIS FIXES OVERFLOW
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}