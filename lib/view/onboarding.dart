import 'package:deenitaindia/view/login.dart';
import 'package:deenitaindia/view/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../constants/image.dart';
import '../constants/size.dart';
import '../constants/textstyle.dart';
import '../widgets/button.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
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
      ),
    );
  }
}
