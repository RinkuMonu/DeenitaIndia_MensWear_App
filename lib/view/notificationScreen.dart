import 'package:deenitaindia/constants/colors.dart';
import 'package:deenitaindia/constants/image.dart';
import 'package:deenitaindia/widgets/button.dart';
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
      body: SafeArea(
        child: Obx(() {
        
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
        
          return ListView.builder(
            padding: const EdgeInsets.only(top: 16),
            itemCount: controller.notifications.length,
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
      ),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 🔥 Banner Image
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 12.0,vertical: 12),
              child: ClipRRect(

                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: Image.network(
                  image,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // 🔥 Content
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Title Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.local_offer,
                          color: Colors.red, size: 18),
                      const SizedBox(width: 6),

                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // Subtitle
                  Text(
                    subTitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Time
                  Row(
                    children: [
                      const Icon(Icons.access_time,
                          size: 12, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // 🔥 Button
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: AppButton(title: "Shop Now", onTap: (){}, bgColor: AppColors.yellow_shade,textColor: Colors.black,)
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}