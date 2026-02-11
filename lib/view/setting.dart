import 'package:deenitaindia/constants/image.dart';
import 'package:deenitaindia/constants/textstyle.dart';
import 'package:deenitaindia/view/profile.dart';
import 'package:deenitaindia/widgets/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/size.dart';
import 'myOrders.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: "Account",
        showMenu: false,
        showNotification: true,
        showWishlist: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 12),

            SettingTile(
              title: 'My Orders',
              icon: AppImage.box,
              onTap: () {
                Get.to(() => MyOrders());
              },
            ),

            _section([
              SettingTile(
                title: 'My Details',
                icon: AppImage.detail,
                onTap: () => Get.to(() => Profile()),
              ),
              SettingTile(
                title: 'Address Book',
                icon: AppImage.home, // replace if needed
                onTap: () {},
              ),
              SettingTile(
                title: 'Payment Methods',
                icon: AppImage.card, // replace if needed
                onTap: () {},
              ),
              SettingTile(
                title: 'Notifications',
                icon: AppImage.bell, // replace if needed
                onTap: () {},
              ),
            ]),

            _section([
              SettingTile(
                title: 'FAQs',
                icon: AppImage.questions, // replace if needed
                onTap: () {},
              ),
              SettingTile(
                title: 'Help Center',
                icon: AppImage.headPhones, // replace if needed
                onTap: () {},
              ),
            ]),

            _section([
              SettingTile(
                title: 'Logout',
                icon: AppImage.logoOut,
                titleColor: Colors.red,
                arrowVisible: false,
                onTap: () {},
              ),
            ]),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _section(List<Widget> children) {
    return Column(
      children: [
        const Divider(height: 24, thickness: 8, color: Color(0xFFF2F2F2)),
        ...children,
      ],
    );
  }
}

// =======================================================
// Setting Tile (iOS-style)
// =======================================================

class SettingTile extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;
  final Color? titleColor;
  final bool arrowVisible;

  const SettingTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.titleColor,
    this.arrowVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              height: 22,
              width: 22,
              color: titleColor ?? Colors.black,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.nunitoSans16.copyWith(
                  color: titleColor ?? Colors.black,
                ),
              ),
            ),
            if (arrowVisible)
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
          ],
        ),
      ),
    );
  }
}

// =======================================================
// URL Launcher
// =======================================================

Future<void> openUrl(String url) async {
  final uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    debugPrint('Could not launch $url');
  }
}