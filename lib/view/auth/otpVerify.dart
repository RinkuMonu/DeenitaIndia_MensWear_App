import 'package:deenitaindia/controller/forgot_passwordC.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../constants/colors.dart';
import '../../constants/image.dart';
import '../../constants/size.dart';
import '../../constants/textstyle.dart';
import '../../controller/loginC.dart';
import '../../widgets/button.dart';
import '../../widgets/otpPopup.dart';
import '../../widgets/textfield.dart';
import '../bottomBar.dart';
import 'forgotPassword.dart';
import '../home.dart';

class OtpVerifyView extends StatefulWidget {
  const OtpVerifyView({super.key});

  @override
  State<OtpVerifyView> createState() => _OtpVerifyViewState();
}

class _OtpVerifyViewState extends State<OtpVerifyView> {

  final defaultPinTheme = PinTheme(
    width: 50,
    height: 50,
    textStyle: const TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      border: Border.all(color: Colors.grey.shade200),
      // boxShadow: [
      //   BoxShadow(
      //     color: Colors.black.withOpacity(0.07),
      //     blurRadius: 10.9,
      //     offset: const Offset(0, 1),
      //   ),
      // ],
    ),
  );
  final _controller  = Get.put(LoginC());
  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return  Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: _build()
    );
  }

  Widget _build(){
    return Stack(
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
              SizedBox(height: ScreenSize.height * .1,),

              Align(
                alignment: Alignment.centerLeft,
                child: Text("OTP Verification", style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),),
              ),
              SizedBox(height: 16,),

              Center(
                child: Pinput(
                  length: 6,
                  autofocus: true,
                  controller: _controller.otpC,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      border: Border.all(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(10),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.red,
                      //     blurRadius: 10,
                      //     offset: const Offset(0, 4),
                      //   ),
                      // ],
                    ),
                  ),
                  submittedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      //color: Colors.red
                    ),
                  ),
                  showCursor: true,
                  onCompleted: (pin) {
                    //  controller.verifyOtp();
                  },
                ),
              ),

              SizedBox(height: 20,),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  
                  Text("Resend OTP", style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 13
                  ),),


                  Text("00:30", style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 13
                  ),),
                  
                ],
              ),
              SizedBox(height: ScreenSize.height * .03,),
              AppButton(title: 'Verify OTP', onTap: (){
                // Get.offAll(()=> BottomBar());
                //_controller.validate();

                showSuccessDialog(
                  image: "assets/image/successStatus.png",
                  // title: "All Done!",
                  subtitle: "Your account has been created successfully.",
                  onNext: () {
                    Get.offAll(() => BottomBar());
                  },
                );

                showSuccessDialog(
                  image: "assets/image/failStatus.svg",
                  // title: "All Done!",
                  subtitle: "Your account has been created successfully.",
                  onNext: () {
                    Get.offAll(() => BottomBar());
                  },
                );
              }),


              SizedBox(height: ScreenSize.height * .03,),

              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child: Text("Back", style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 16
                  ),),
                ),
              )

            ],
          ),
        ),

      ],
    );
  }







}
