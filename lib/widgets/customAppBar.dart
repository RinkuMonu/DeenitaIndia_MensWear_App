import 'package:deenitaindia/view/wishlistScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../controller/bottomNavC.dart';
import '../view/notificationScreen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onMenuTap;
  final VoidCallback? onNotificationTap;

  final String? title;
  final String? subtitle;

  final bool showMenu;
  final bool showNotification;
  final bool showWishlist;

  final Color? appBarBgColor;
  final Color? iconColor;
  final Color? titleColor;

  final Widget? leadingWidget;
  final List<Widget>? actions;
  final double height;

  const CustomAppBar({
    super.key,
    this.onMenuTap,
    this.onNotificationTap,
    this.title,
    this.subtitle,
    this.showMenu = true,
    this.showNotification = true,
    this.showWishlist = true,
    this.appBarBgColor,
    this.iconColor = Colors.black,
    this.titleColor = Colors.black,
    this.leadingWidget,
    this.actions,
    this.height = 70,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      centerTitle: true,
      backgroundColor: appBarBgColor ?? AppColors.containerColor,
      titleSpacing: 0,
      title: SizedBox(
        height: height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // LEFT
            Align(
              alignment: Alignment.centerLeft,
              child: leadingWidget ??
                  (showMenu
                      ? _iconButton(
                    Icons.menu_rounded,
                    onMenuTap ??
                            () => Scaffold.of(context).openDrawer(),
                  )
                      : _iconButton(
                    CupertinoIcons.arrow_left,
                    (){
                      _handleBackNavigation(context);
                    },
                  )),
            ),

            // CENTER TITLE
            _buildTitle(),

            // RIGHT
            Align(
              alignment: Alignment.centerRight,
              child: actions != null
                  ? Row(
                mainAxisSize: MainAxisSize.min,
                children: actions!,
              )
                  : showWishlist
                  ? _iconButton(
                CupertinoIcons.heart,
                    () => Get.to(() => WishlistScreen()),
              )
                  : showNotification
                  ? _iconButton(
                CupertinoIcons.bell,
                onNotificationTap ??
                        () => Get.to(
                            () => const NotificationScreen()),
              )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }


  void _handleBackNavigation(BuildContext context) {
    final titleLower = title?.toLowerCase() ?? "";

    // Special navigation for 3 specific screens: History, Services, Profile
    if (titleLower == "search" ||
        titleLower == "category" ||
        titleLower == "cart"||
        titleLower == "profile") {
      // Navigate back to home tab (index 0)
      Get.find<BottomNavC>().change(0);
    } else {
      // Normal back navigation for all other screens
      if (Navigator.canPop(context)) {
        Get.back();
      }
    }
  }

  // ───────────────── TITLE ─────────────────

  Widget _buildTitle() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (subtitle != null)
          Text(
            subtitle!,
            style: TextStyle(
              fontSize: 22,
              color: titleColor?.withOpacity(0.6),
            ),
          ),
        Text(
          title ?? "Dashboard",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: titleColor,
          ),
        ),
      ],
    );
  }

  // ───────────────── ICON BUTTON ─────────────────

  Widget _iconButton(IconData icon, VoidCallback onTap) {
    return IconButton(
      icon: Icon(icon, color: iconColor, size: 24),
      onPressed: onTap,
    );
  }
}