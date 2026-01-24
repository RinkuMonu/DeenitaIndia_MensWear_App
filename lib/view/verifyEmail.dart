import 'package:deenitaindia/controller/forgot_passwordC.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../constants/image.dart';
import '../constants/size.dart';
import '../constants/textstyle.dart';
import '../widgets/button.dart';
import '../widgets/textfield.dart';
import 'forgotPassword.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final _controller  = Get.put(ForgotPasswordC());
  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return  Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
              // left: 0,
              //top: 0,
                right: 0,
                child: Image.asset(AppImage.bgVector8,fit: BoxFit.contain,height: ScreenSize.height * .25)),
            Positioned(
              //left: 0,
                right: 0,
                child: Image.asset(AppImage.bgVector7,fit: BoxFit.contain,height: ScreenSize.height * .18)),



            Container(
              height: double.maxFinite,
              width: double.maxFinite,
              color: Colors.transparent,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: ScreenSize.height * .36,),
                        Text('Verify Email',style: AppTextStyles.raleWayBold30,),
                        Text('Enter your email address to reset your password.',style: AppTextStyles.raleWay16,textAlign: TextAlign.center,),
                        SizedBox(height: ScreenSize.height * .03,),
                        CommonTextField(controller: _controller.emailC, hint: 'email', ),
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
                          return AppButton(title: 'Verify', onTap: (){
                            _controller.validate();
                          });
                        })
                      ],
                    ),
                  ),
                  Positioned(
                    top: 52,
                    left: 20,
                    child: InkWell(
                      onTap: (){
                        print('object');
                        Get.back();
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: const Offset(4, 4),
                                blurRadius: 8,
                              ),
                              BoxShadow(
                                color: Colors.white.withOpacity(0.2),
                                offset: const Offset(-4, -4),
                                blurRadius: 8,
                              ),
                            ],
                          ),

                          padding: EdgeInsets.all(12),
                          child: Icon(Icons.arrow_back,color: Colors.black,)),
                    ),
                  ),
                ],
              )
            ),



          ],
        )
    );
  }
}
