import 'package:deenitaindia/constants/colors.dart';
import 'package:deenitaindia/widgets/customAppBar.dart';
import 'package:deenitaindia/widgets/otpPopup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/image.dart';
import '../constants/size.dart';
import '../constants/textstyle.dart';
import '../controller/profileC.dart';
import '../widgets/button.dart';
import '../widgets/container.dart';
import '../widgets/textfield.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final controller = Get.put(ProfileC());
  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Obx(() {
      if (controller.isLoading.value) {
        return circularProgressTop();
      }
      return Scaffold(
        appBar: CustomAppBar(
          title: "My Details",
          showWishlist: false,
          showNotification: true,
          showMenu: false,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Full Name", style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.black
              ),),

              CommonTextField(
                readOnly: controller.isEditableName.value ,
                controller: controller.firstName,
                hint: 'Enter Full Name',
              ),

              SizedBox(height: 16,),
              Text("Email ID", style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black
              ),),
              CommonTextField(
                  readOnly: controller.isEditableEmail.value ,
                  controller: controller.email,
                  hint: 'Enter email',
                suffix: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: controller.isEmailVerified.value ||
                        controller.isEmailVerifying.value
                        ? null
                        : (){
                      showMobileOtpPopup(onNext: (){Get.back();}, controller: controller.otpController);
                    },
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
              ),
              SizedBox(height: 16,),
              Text("Mobile Number", style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black
              ),),
              CommonTextField(
                readOnly: controller.isEditableMobile.value ,
                controller: controller.mobile,
                hint: 'Enter your mobile number',
                maxLength: 10,
                suffix: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: controller.isEmailVerified.value ||
                        controller.isEmailVerifying.value
                        ? null
                        : (){
                      showMobileOtpPopup(onNext: (){}, controller: controller.otpController);
                    },
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
              ),

              SizedBox(height: 16,),

              Text("Address", style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black
              ),),
              CommonTextField(
                  controller: controller.address,
                  hint: 'address',
                readOnly: controller.isEditableAddress.value ,
              ),
              Spacer(),
              controller.isLoadingUpdate.value
                  ? circularProgressBottom()
                  : AppButton(
                      textColor: controller.isEditable.value ? Colors.white : Colors.black,
                      bgColor: controller.isEditable.value ? AppColors.secondary : Colors.grey.shade200,
                      title: controller.isEditable.value ?  'Save' : "Edit",
                      onTap: () {
                        if(controller.isEditable.value){
                        }else{
                          controller.makeEditable();
                        }},
                    ),

              SizedBox(height: 20,)
            ],
          ),
        ),
      );
    });
  }

}
