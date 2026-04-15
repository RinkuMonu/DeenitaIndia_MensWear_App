import 'package:deenitaindia/constants/image.dart';
import 'package:deenitaindia/constants/textstyle.dart';
import 'package:deenitaindia/view/faq_page.dart';
import 'package:deenitaindia/view/profile.dart';
import 'package:deenitaindia/view/reward_screen.dart';
import 'package:deenitaindia/widgets/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/size.dart';
import '../widgets/logout_pop_up.dart';
import 'help_center_screen.dart';
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 8),

            // ── My Orders ────────────────────────────────────────────────
            settingTile(
              title: 'My Orders',
              icon: AppImage.box,
              onTap: () => Get.to(() => MyOrders()),
            ),
            _divider(height: 10),

            // ── My Details ───────────────────────────────────────────────
            settingTile(
              title: 'My Details',
              icon: AppImage.detail,
              onTap: () => Get.to(() => Profile()),
            ),
            _divider(height: 10),

            // ── My Rewards (with NEW badge) ───────────────────────────────
            settingTile(
              title: 'My Rewards',
              icon: AppImage.card,
              onTap: () {
                Get.to(() => RewardScreen());
              },
              badge: 'NEW',
            ),
            _divider(height: 1),

            // ── Help Center ───────────────────────────────────────────────
            settingTile(
              title: 'Help Center',
              icon: AppImage.headPhones,
              onTap: () {

                Get.to(() => HelpCenterScreen());
              },
            ),
            _divider(height: 1),
            // ── FAQs ─────────────────────────────────────────────────────
            settingTile(
              title: 'FAQs',
              icon: AppImage.questions,
              onTap: () {
                Get.to(() => FaqPage());
              },
            ),

            // ── Legal links section ───────────────────────────────────────
            const Divider(height: 32, thickness: 8, color: Color(0xFFF2F2F2)),

            _legalTile('ABOUT US',              onTap: () {}),
            _legalTile('TERMS OF USE',          onTap: () {}),
            _legalTile('PRIVACY POLICY',        onTap: () {}),
            _legalTile('GRIEVANCE REDRESSAL',   onTap: () {}),
            _legalTile('PRIVACY CENTER',        onTap: () {}),

            const SizedBox(height: 24),

            // ── Log Out button ────────────────────────────────────────────
            Container(
              padding: EdgeInsets.symmetric(vertical: 32),
              decoration: BoxDecoration(
                color: Colors.grey.shade200
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: OutlinedButton(
                  onPressed: () {
                    logoutPopup();
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 54),
                    side: const BorderSide(color: Colors.red, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  child: const Text(
                    'Log Out',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }

  // ── Thin divider between tiles ────────────────────────────────────────────
  Widget _divider({required double height}) =>  Divider(height: height, thickness: 1, color: Color(0xFFF0F0F0));

  // ── Legal link row ────────────────────────────────────────────────────────
  Widget _legalTile(String title, {required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
            letterSpacing: 0.4,
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// Setting Tile — widget function
// ════════════════════════════════════════════════════════════════════════════

Widget settingTile({
  required String title,
  required String icon,
  required VoidCallback onTap,
  Color? titleColor,
  bool arrowVisible = true,
  String? badge,            // optional badge text e.g. "NEW"
}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [

          // Icon
          SvgPicture.asset(
            icon,
            height: 22,
            width: 22,
            colorFilter: ColorFilter.mode(
              titleColor ?? Colors.grey.shade600,
              BlendMode.srcIn,
            ),
          ),

          const SizedBox(width: 16),

          // Title
          Expanded(
            child: Row(
              children: [
                Text(
                  title,
                  style: AppTextStyles.nunitoSans16.copyWith(
                    color: titleColor ?? Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                // Optional badge
                if (badge != null) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F0E8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      badge,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF8B7355),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Arrow
          if (arrowVisible)
            const Icon(Icons.arrow_forward_ios, size: 15, color: Colors.grey),
        ],
      ),
    ),
  );
}

// ════════════════════════════════════════════════════════════════════════════
// URL Launcher helper
// ════════════════════════════════════════════════════════════════════════════

Future<void> openUrl(String url) async {
  final uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    debugPrint('Could not launch $url');
  }
}