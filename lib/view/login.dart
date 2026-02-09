import 'package:deenitaindia/constants/colors.dart';
import 'package:deenitaindia/view/otpVerify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/image.dart';
import '../constants/size.dart';
import '../constants/textstyle.dart';
import '../controller/loginC.dart';
import '../widgets/button.dart';
import '../widgets/textfield.dart';
import 'forgotPassword.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _controller  = Get.put(LoginC());

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return  Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Align(
                alignment: AlignmentGeometry.bottomCenter,
                child: Image.asset(AppImage.backWave)),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: ScreenSize.height * .16,),
                    Text('Login',style: AppTextStyles.alexandria32,),
                    Text('We saved your spot',style: AppTextStyles.alexandria16w300,),
                    SizedBox(height: ScreenSize.height * .1,),
                    CommonTextField(controller: _controller.mobileC,maxLength: 10, hint: 'Enter your mobile number',label: 'Mobile Number',),
                    SizedBox(height: ScreenSize.height * .02,),
                    AppButton(title: 'Send OTP', onTap: (){
                      Get.to(()=> OtpVerifyView());
                      // _controller.validate();
                    })
                  ],
                ),
              ),
            ),

          ],
        )
    );
  }

}



