import 'package:deenitaindia/view/login.dart';
import 'package:deenitaindia/view/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../constants/image.dart';
import '../constants/size.dart';
import '../constants/textstyle.dart';
import '../controller/onboardingC.dart';
import '../widgets/button.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final controller = OnBoardingController();
  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: controller.pageController,
              onPageChanged: controller.onPageChanged,
              itemCount: controller.pages.length,
              itemBuilder: (context, index) {
                final item = controller.pages[index];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: ScreenSize.height * .08),
                    Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: Text(
                        item.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          letterSpacing: -3,
                          height: 1,
                          fontSize: 50,
                          color: index == 0
                              ? AppColors.onboardTextColor
                              : index == 1
                              ? Color(0xff464135)
                              : Color(0xffA9A390),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: ScreenSize.height * .63,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        //color: Colors.red,
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.white,
                        //     blurRadius: 70,
                        //     spreadRadius: 0,
                        //     offset: Offset(0, 4),
                        //     blurStyle: BlurStyle.outer
                        //   ),
                        // ],
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Image.asset(
                              index == 1
                                  ? AppImage.onbBack2
                                  : AppImage.onbBack1,
                            ),
                          ),
                          Image.asset(
                            item.image,
                            height: ScreenSize.height * .63,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30),
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            controller.currentIndex.value == 2
                                ? Expanded(
                                    child: AppButton(
                                      title: "Get Started",
                                      onTap: controller.nextPage,
                                      bgColor: Colors.black,
                                      textColor: Colors.white,
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      controller.nextPage();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: Colors.transparent,
                                        border: Border.all(
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 6,
                                      ),
                                      child: Icon(
                                        Icons.arrow_forward,
                                        size: 36,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          /// ================= BOTTOM CONTROLS =================
        ],
      ),
      /* body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: ScreenSize.height * .36,),
            Center(
              child: Container(
                  height: 120,
                  width: 120,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        blurRadius: 20,
                        spreadRadius: 2,
                        offset: const Offset(0, 8), // downward shadow
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(16),
                  child: SvgPicture.asset(AppImage.bag,fit: BoxFit.contain,height: 30,width: 30,)),
            ),
            SizedBox(height: 20,),
            Text('Deenita India',style: AppTextStyles.raleWayBold30,),
            SizedBox(height: 20,),
            Text('Style that speaks, fashion that fits your lifestyle — from everyday essentials to standout looks.',style: AppTextStyles.raleWay16,textAlign: TextAlign.center,),
            //Spacer(),
            SizedBox(height: ScreenSize.height * .1,),
            AppButton(title: 'Let\'s get Started', onTap: (){
              Get.to(()=>Register());
            }),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8,
              children: [
                Text('Already Have an account',style: AppTextStyles.raleWay14,),
                InkWell(
                    onTap: (){
                      Get.to(()=> Login());
                    },
                    child: CircleAvatar(backgroundColor: AppColors.primary,child: Icon(Icons.arrow_forward,color: Colors.white,),)),
              ],
            ),
          ],
        ),
      ),*/
    );
  }
}
