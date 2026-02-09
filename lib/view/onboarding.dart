import 'package:deenitaindia/view/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../constants/size.dart';
import '../controller/onboardingC.dart';
import '../widgets/button.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final OnBoardingController controller = Get.put(OnBoardingController());

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView.builder(
        controller: controller.pageController,
        onPageChanged: controller.onPageChanged,
        itemCount: controller.pages.length,
        itemBuilder: (context, index) {
          final item = controller.pages[index];

          return Stack(
            children: [
              /// ───────── FULL SCREEN IMAGE ─────────
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Positioned(
                  child: Image.asset(
                    height: MediaQuery.of(context).size.height * 07,
                    item.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),



              Positioned(
                bottom: 20,
                left: 16,
                right: 16,
                child: Obx(() {
                  final isLast = controller.currentIndex.value ==
                      controller.pages.length - 1;

                  return isLast
                      ? SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      title: "Get Started",
                      bgColor: Colors.black,
                      textColor: Colors.white,
                      onTap: () {
                        Get.offAll(() => const Login());
                      },
                    ),
                  )
                      : Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: controller.nextPage,
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1.5,
                          ),
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                          size: 26,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}