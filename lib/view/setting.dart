import 'package:deenitaindia/constants/textstyle.dart';
import 'package:deenitaindia/view/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/size.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ScreenSize.height * .06,),
          Text('Settings',style: AppTextStyles.raleWayBold28,),
            SizedBox(height: ScreenSize.height * .03,),
            Text('Personal',style: AppTextStyles.raleWayBold20,),
            SizedBox(height: ScreenSize.height * .03,),
            _buildContent(text: 'Profile', onTap: () { Get.to(()=> Profile());}),
            _buildContent(text: 'Shipping Address', onTap: () {  }),
            _buildContent(text: 'Payment Methods', onTap: () {  }),
            SizedBox(height: ScreenSize.height * .03,),
            //2_buildContent(text: 'Country', onTap: () {  }),
            //_buildContent(text: 'Currency', onTap: () {  }),


            Text('Account',style: AppTextStyles.raleWayBold20,),
            SizedBox(height: ScreenSize.height * .03,),
            _buildContent(text: 'About Us', onTap: () {
              openUrl('https://deenitaindia.com/about-us');
            }),
            _buildContent(text: 'Terms and Conditions', onTap: () {
              openUrl('https://deenitaindia.com/terms-of-service');
            }),
            SizedBox(height: ScreenSize.height * .05,),
            Text('Deenita India',style: AppTextStyles.raleWayBold20,),
            Text('Version 1.0',style: AppTextStyles.nunitoSans10,),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(
  {required String text,
  required VoidCallback onTap}
      ){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(text,style: AppTextStyles.nunitoSans16,),
              Icon(Icons.arrow_forward_ios_outlined,color: Colors.grey,),
            ],
          ),
        ),
       // SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(color: Colors.grey.shade200,),
        ),
      ],
    );
  }
  Future<void> openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
