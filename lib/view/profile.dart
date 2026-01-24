import 'package:deenitaindia/constants/colors.dart';
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
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: ScreenSize.height * .06),
              Text('Settings', style: AppTextStyles.raleWayBold28),
              SizedBox(height: ScreenSize.height * .01),
              Text('Your Profile', style: AppTextStyles.raleWay16),
              SizedBox(height: ScreenSize.height * .02),
              Stack(
                children: [
                  Container(
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
                    padding: EdgeInsets.all(6),
                    child: CircleAvatar(
                      radius: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(AppImage.avatar),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: Container(
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
                      padding: EdgeInsets.all(2),
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: AppColors.primary,
                        child: Icon(Icons.edit, color: Colors.white, size: 18),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: ScreenSize.height * .02),
              CommonTextField2(
                controller: controller.firstName,
                hint: 'first name',
              ),
              CommonTextField2(
                controller: controller.lastName,
                hint: 'last name',
              ),
              CommonTextField2(controller: controller.email, hint: 'email'),
              CommonTextField2(controller: controller.mobile, hint: 'mobile',maxLength: 10,),
              CommonTextField2(controller: controller.address, hint: 'address'),
              Spacer(),
              controller.isLoadingUpdate.value
                  ? circularProgressBottom()
                  : AppButton(
                      title: 'Save',
                      onTap: () {
                        print('tap');
                        controller.updateProfile();
                      },
                    ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildContent({required String text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: AppTextStyles.nunitoSans16),
            Icon(Icons.arrow_forward_ios_outlined, color: Colors.grey),
          ],
        ),
        // SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(color: Colors.grey.shade200),
        ),
      ],
    );
  }
}
