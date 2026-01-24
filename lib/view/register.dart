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

          Positioned(
             left: 0,
            //  right: 0,
              child: Image.asset(AppImage.bgVector2,fit: BoxFit.contain,height: ScreenSize.height * .24)),
          Positioned(
              // left: 0,
               right: 0,
              child: Image.asset(AppImage.bgVector1,fit: BoxFit.contain,height: ScreenSize.height * .36)),
          Container(
            height: double.maxFinite,
            width: double.maxFinite,
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: ScreenSize.height * .146,),
                  Text('Create\nAccount',style: AppTextStyles.raleWayBold30,),
                  SizedBox(height: ScreenSize.height * .06,),
                  CommonTextField(controller: _controller.fNameC, hint: 'first name', ),
                  CommonTextField(controller: _controller.lNameC, hint: 'last name', ),
                  CommonTextField(controller: _controller.emailC, hint: 'email', ),
                  CommonTextField(controller: _controller.mobileC, hint: 'mobile',maxLength: 10,),
                  CommonTextField(controller: _controller.passC, hint: 'password',
                    obscureText: _controller.isPasswordHidden.value,
                    onToggleVisibility: () {
                      setState(() {
                        _controller.isPasswordHidden.value = !_controller.isPasswordHidden.value;
                      });
                    },),
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
                    return AppButton(title: 'Create', onTap: (){
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
