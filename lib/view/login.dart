import 'package:deenitaindia/constants/colors.dart';
import 'package:deenitaindia/view/verifyEmail.dart';
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
        backgroundColor: Colors.white,
        body: Stack(
          children: [

            Positioned(
                left: 0,
                //  right: 0,
                child: Image.asset(AppImage.bgVector6,fit: BoxFit.contain,height: ScreenSize.height * .4)),
            Positioned(
               left: 0,
                //top: 0,
              //  right: 0,
                child: Image.asset(AppImage.bgVector5,fit: BoxFit.contain,height: ScreenSize.height * .32)),
            Positioned(
              // left: 0,
              top: ScreenSize.height * .3,
                right: 0,
                child: Image.asset(AppImage.bgVector3,fit: BoxFit.contain,height: ScreenSize.height * .2)),
            Positioned(
              // left: 0,
                //top: ScreenSize.height * .2,
              bottom: 0,
                right: 0,
                child: Image.asset(AppImage.bgVector4,fit: BoxFit.contain,height: ScreenSize.height * .38)),

            Container(
              height: double.maxFinite,
              width: double.maxFinite,
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: ScreenSize.height * .52,),
                    Text('Login',style: AppTextStyles.raleWayBold30,),
                    Text('Welcome back!',style: AppTextStyles.raleWay16,),
                    SizedBox(height: ScreenSize.height * .03,),
                    CommonTextField(controller: _controller.emailC, hint: 'email', ),
                    CommonTextField(controller: _controller.passC, hint: 'password',
                      obscureText: _controller.isPasswordHidden.value,
                      onToggleVisibility: () {
                        setState(() {
                          _controller.isPasswordHidden.value = !_controller.isPasswordHidden.value;
                        });
                      }, ),
                    InkWell(
                      onTap: (){
                        Get.to(()=> VerifyEmail());
                      },
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('Forgot Password?',textAlign: TextAlign.end,)),
                    ),
                    Spacer(),
                    Obx((){
                      if(_controller.isLoading.value){
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Center(
                            child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: AppColors.primary, strokeWidth: 2.5,)),
                          ),
                        );
                      }
                      return AppButton(title: 'Next', onTap: (){
                        _controller.validate();
                      });
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

