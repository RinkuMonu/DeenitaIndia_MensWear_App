import 'package:deenitaindia/constants/textstyle.dart';
import 'package:deenitaindia/view/bottomBar.dart';
import 'package:deenitaindia/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/image.dart';
import '../constants/size.dart';
import '../controller/pageC.dart';

class HelloCard extends StatefulWidget {
  const HelloCard({super.key});

  @override
  State<HelloCard> createState() => _HelloCardState();
}

class _HelloCardState extends State<HelloCard> {
  final _pageController = PageController();
  final controller  = Get.put(PageC());
  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(()=> Stack(
        children: [
          controller.currentIndex.value == 0 ?
            Positioned(
                left: 0,
                top: ScreenSize.height * .3,
                child: Image.asset(AppImage.bgVector9,fit: BoxFit.contain,height: ScreenSize.height * .32)):
          Positioned(
              left: ScreenSize.width * .56,
              top: ScreenSize.height * .42,
              child: Image.asset(AppImage.bgVector10,fit: BoxFit.contain,height: ScreenSize.height * .46)),


          Positioned(
              left: 0,
              //  right: 0,
              child: Image.asset(AppImage.bgVector5,fit: BoxFit.contain,height: ScreenSize.height * .32)),

          PageView(
            controller: _pageController,
            onPageChanged: (value){
              controller.currentIndex.value = value;
            },
            children: [
              _pageItem(title: 'Hello', color: Colors.white, description: 'Discover the latest trends, timeless styles, and outfits made just for you.', image: AppImage.hello),
              _pageItem(title: 'Ready', color: Colors.white, description: 'Ready to go! Dive into trends and find your perfect look.', image: AppImage.ready),

            ],
          ),
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(2, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  height: 8,
                  width: controller.currentIndex.value == index ? 22 : 8,
                  decoration: BoxDecoration(
                    color: controller.currentIndex.value == index
                        ? Colors.black
                        : Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              }),
            ),
          ),

        ],
      ))
    );
  }
  Widget _pageItem({
    required String title,
    required String image,
    required String description,
    required Color color,
  }) {
    return Container(
      margin:  const EdgeInsets.only(top: 90,bottom: 140,right: 30,left: 30),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 8), // downward shadow
          ),
        ],
      ),
      //padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.only(topRight: Radius.circular(25),topLeft: Radius.circular(25)),

                child: Image.asset(image)),
            SizedBox(height: ScreenSize.height * .04,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.nunitoSans19,
                  ),
                  SizedBox(height: 30,),

                  Visibility(
                    visible: title == 'Ready',
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 70),
                      child: AppButton(title: 'Let\'s Start', onTap: (){
                        Get.to(()=> BottomBar());
                      }),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

