import 'dart:async';

import 'package:deenitaindia/constants/colors.dart';
import 'package:deenitaindia/constants/image.dart';
import 'package:deenitaindia/constants/size.dart';
import 'package:deenitaindia/constants/textstyle.dart';
import 'package:deenitaindia/controller/splashC.dart';
import 'package:deenitaindia/view/auth/onboarding.dart';
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
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          "assets/image/logo.png",
          height: 200,
        ),
      ),
    );
  }
}
