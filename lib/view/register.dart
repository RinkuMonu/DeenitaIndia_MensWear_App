import 'package:deenitaindia/constants/image.dart';
import 'package:deenitaindia/constants/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../constants/size.dart';
import '../controller/loginC.dart';
import '../controller/registerC.dart';
import '../widgets/button.dart';
import '../widgets/textfield.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final _controller  = Get.put(RegisterC());
  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return  Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Align(
                alignment: AlignmentGeometry.bottomCenter,
                child: Image.asset(AppImage.backWave)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: ScreenSize.height * .2,),
                  Text('Login',style: AppTextStyles.alexandria32,),
                  Text('We saved your spot',style: AppTextStyles.alexandria16w300,),
                  SizedBox(height: ScreenSize.height * .14,),
                  CommonTextField(controller: _controller.mobileC,maxLength: 10, hint: 'Enter your mobile number',label: 'Mobile Number',),
                  InkWell(
                    onTap: (){
                      //  Get.to(()=> VerifyEmail());
                    },
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('Forgot Password?',textAlign: TextAlign.end,)),
                  ),
                  SizedBox(height: ScreenSize.height * .03,),
                  AppButton(title: 'Send OTP', onTap: (){
                   // Get.to(()=> OtpVerifyView());
                    // _controller.validate();
                  })
                ],
              ),
            ),

          ],
        )
    );
  }

}
