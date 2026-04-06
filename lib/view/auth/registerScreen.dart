import 'package:deenitaindia/constants/colors.dart';
import 'package:deenitaindia/controller/registerC.dart';
import 'package:deenitaindia/widgets/button.dart';
import 'package:deenitaindia/widgets/customAppBar.dart';
import 'package:deenitaindia/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bottomBar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final controller = Get.put(RegisterC());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        showMenu: false,
        showNotification: false,
        showWishlist: false,
        title: "Register",
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 20,),
            CommonTextField(controller: controller.nameController, hint: "Enter full name", label: "Full Name",),
            SizedBox(height: 20,),

            Obx(() => CommonTextField(
              controller: controller.emailController,
              hint: "Enter email",
              label: "Email",
              keyBoard: TextInputType.emailAddress,
              suffix: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: controller.isEmailVerified.value ||
                      controller.isEmailVerifying.value
                      ? null
                      : controller.verifyEmail,
                  child: Container(
                    height: 32,
                    width: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: controller.isEmailVerified.value
                          ? AppColors.primary
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: controller.isEmailVerifying.value
                        ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                        : Text(
                      controller.isEmailVerified.value
                          ? "Verified"
                          : "Verify",
                      style: TextStyle(
                        color: controller.isEmailVerified.value
                            ? Colors.white
                            : Colors.black54,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            )),
            SizedBox(height: 20,),

            SizedBox(height: 20,),

            Obx(() => CommonTextField(
              controller: controller.mobileController,
              maxLength: 10,
              hint: "Enter mobile number",
              label: "Mobile Number",
              suffix: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: controller.isMobileVerified.value ||
                      controller.isMobileVerifying.value
                      ? null
                      : controller.verifyMobile,
                  child: Container(
                    height: 32,
                    width: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: controller.isMobileVerified.value
                          ? AppColors.primary
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: controller.isMobileVerifying.value
                        ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                        : Text(
                      controller.isMobileVerified.value
                          ? "Verified"
                          : "Verify",
                      style: TextStyle(
                        color: controller.isMobileVerified.value
                            ? Colors.white
                            : Colors.black54,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              keyBoard: TextInputType.number,
            )),

            SizedBox(height: 20,),

            CommonTextField(controller: controller.passController, hint: "Enter password", label: "Password",),

            SizedBox(height: 20,),
            CommonTextField(controller: controller.passConfirmController, hint: "Confirm  password", label: " Confirm Password",),


            SizedBox(height: 20,),

            Obx(() {
              return AppButton(
                title: "Done",
                bgColor: controller.isFormValid.value
                    ? Colors.black
                    : Colors.grey.shade400,
                textColor: Colors.white,
                onTap: controller.isFormValid.value
                    ? () {
                  Get.to(()=> BottomBar());
                }
                    : null, // disables button
              );
            }),

          ],
        ),
      ),
    );
  }
}
