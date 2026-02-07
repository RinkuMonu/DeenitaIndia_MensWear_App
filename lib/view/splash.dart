import 'dart:async';

import 'package:deenitaindia/constants/colors.dart';
import 'package:deenitaindia/constants/image.dart';
import 'package:deenitaindia/constants/size.dart';
import 'package:deenitaindia/constants/textstyle.dart';
import 'package:deenitaindia/controller/splashC.dart';
import 'package:deenitaindia/view/onboarding.dart';
import 'package:deenitaindia/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final _controller  = Get.put(SplashC());



  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
         /* Center(
            child: Obx(
                  () => AnimatedOpacity(
                duration: const Duration(milliseconds: 800),
                opacity: _controller.opacity.value,
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOutBack,
                  scale: _controller.scale.value,
                  child: Image.asset(
                    AppImage.logo,
                    height: 160,
                    width: 160,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),*/
          Image.asset(AppImage.splash,)
        ],
      ),
    );
  }
}
