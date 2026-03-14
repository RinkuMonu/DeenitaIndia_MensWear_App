import 'package:deenitaindia/constants/colors.dart';
import 'package:deenitaindia/view/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../constants/size.dart';
import '../../controller/onboardingC.dart';
import '../../widgets/button.dart';

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
      backgroundColor: AppColors.white_shade,
      body: PageView.builder(
        controller: controller.pageController,
        onPageChanged: controller.onPageChanged,
        itemCount: controller.pages.length,
        itemBuilder: (context, index) {
          final item = controller.pages[index];

          return Stack(
            children: [

              /// 🔹 FULL SCREEN IMAGE
              Image.asset(
                item.image,
                fit: BoxFit.cover,
              ),

              /// 🔹 DARK GRADIENT OVERLAY (Bottom Fade)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.45,
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        offset: Offset(0, 2),
                      )
                    ],
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black,
                        Colors.black,
                      ],
                    ),
                  ),
                ),
              ),

              /// 🔹 TEXT + BUTTON AREA
              Positioned(
                bottom: 60,
                left: 20,
                right: 20,
                child: Obx(() {
                  final isLast = controller.currentIndex.value ==
                      controller.pages.length - 1;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      /// Title
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// Subtitle
                      Text(
                        item.subtitle,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),

                      const SizedBox(height: 16),

                      /// Dots Indicator
                      Row(
                        children: List.generate(
                          controller.pages.length,
                              (dotIndex) => Container(
                            margin: const EdgeInsets.only(right: 6),
                            height: 8,
                            width: controller.currentIndex.value == dotIndex
                                ? 16
                                : 8,
                            decoration: BoxDecoration(
                              color: controller.currentIndex.value == dotIndex
                                  ? Colors.white
                                  : Colors.white38,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// Button
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: (){
                            if(isLast){
                              Get.to(() => Login());
                            }else{
                              controller.nextPage();
                            }
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            height: 50,
                            width: 130,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Continue",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 6),
                                Icon(Icons.arrow_forward, size: 18),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                    ],
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