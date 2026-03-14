import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/image.dart';
import '../../constants/size.dart';
import '../../constants/textstyle.dart';
import '../../controller/forgot_passwordC.dart';
import '../../widgets/button.dart';
import '../../widgets/textfield.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
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
                        Text('Set New Password',style: AppTextStyles.raleWayBold30,),
                        Text('Please, setup new password for your account',style: AppTextStyles.raleWay16,),
                        SizedBox(height: ScreenSize.height * .03,),
                        CommonTextField(controller: _controller.passwordC, hint: 'password',
                          obscureText: _controller.isPasswordHidden.value,
                          onToggleVisibility: () {
                            setState(() {
                              _controller.isPasswordHidden.value = !_controller.isPasswordHidden.value;
                            });
                          },),
                        CommonTextField(controller: _controller.newPasswordC, hint: 'confirm password',
                          obscureText: _controller.isPasswordHidden2.value,
                          onToggleVisibility: () {
                            setState(() {
                              _controller.isPasswordHidden2.value = !_controller.isPasswordHidden2.value;
                            });
                          },),

                        Spacer(),
                        Obx((){
                          if(_controller.isPasswordLoading.value){
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
                          return AppButton(title: 'Save', onTap: (){
                            _controller.validatePassword();
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
