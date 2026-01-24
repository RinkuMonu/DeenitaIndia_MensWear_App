import 'package:carousel_slider/carousel_slider.dart';
import 'package:deenitaindia/constants/colors.dart';
import 'package:deenitaindia/constants/image.dart';
import 'package:deenitaindia/constants/textstyle.dart';
import 'package:deenitaindia/view/setting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../constants/size.dart';
import '../controller/homeC.dart';
import '../model/bannerM.dart';
import '../utils/api_url.dart';
import '../widgets/container.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _controller = Get.put(HomeC());
  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ScreenSize.height * .06,),
            Row(
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
                  padding: EdgeInsets.all(4),
                  child: CircleAvatar(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(AppImage.avatar)),
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColors.primary,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: Text(
                    'My Activity', style: AppTextStyles.raleWay16White,),
                ),
                Spacer(),
                topIcons(icon: Icons.add_alarm_sharp, onIconTap: () {}),
                SizedBox(width: 10,),
                topIcons(icon: Icons.add_alarm_sharp, onIconTap: () {}),
                SizedBox(width: 10,),
                topIcons(icon: Icons.settings, onIconTap: () {
                  Get.to(()=> Setting());
                }),
              ],
            ),
            SizedBox(height: ScreenSize.height * .01,),
            Text('Hello, Romina!', style: AppTextStyles.raleWayBold30,),
            SizedBox(height: ScreenSize.height * .01,),
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8)
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Accouncement', style: AppTextStyles.raleWay14Bold,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Text(
                        'New offers and updates are available. Check now!',
                        style: AppTextStyles.nunitoSans10,)),
                      InkWell(
                          onTap: () {
                            //Get.to(()=> Login());
                          },
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: AppColors.primary,
                            child: Icon(
                              Icons.arrow_forward, size: 20, color: Colors
                                .white,),)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: ScreenSize.height * .022,),
            Text('Recently Viewed', style: AppTextStyles.raleWayBold21,),
            SizedBox(height: ScreenSize.height * .01,),
            _bannerSection(_controller.topBanners, 150, BoxFit.fill),
            Container(
              //color: Colors.red,
              height: ScreenSize.height * .08,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 14,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 8,
                            spreadRadius: 2,
                            offset: const Offset(0, 8), // downward shadow
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(4),
                      child: CircleAvatar(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(AppImage.avatar)),
                      ),
                    );
                  }),
            ),
            SizedBox(height: ScreenSize.height * .024,),
            Text('My Orders', style: AppTextStyles.raleWayBold21,),
            SizedBox(height: ScreenSize.height * .01,),
          Wrap(
            children: [
              buildContainer(text: 'To Pay', color: AppColors.containerColor),
              SizedBox(width: 10,),
              buildContainer(text: 'To Receive', color: AppColors.containerColor),
              SizedBox(width: 10,),
              buildContainer(text: 'To Review', color: AppColors.containerColor),
            ],
          ),
            SizedBox(height: ScreenSize.height * .024,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('New Items', style: AppTextStyles.raleWayBold21,),
                Row(
                  children: [
                    Text('See All', style: AppTextStyles.raleWayBold15,),
                    SizedBox(width: 14,),
                    InkWell(
                        onTap: () {
                          //Get.to(()=> Login());
                        },
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: AppColors.primary,
                          child: Icon(
                            Icons.arrow_forward, size: 20, color: Colors
                              .white,),)),
                  ],
                ),
              ],
            ),
            SizedBox(height: ScreenSize.height * .01,),
            SizedBox(
              //color: Colors.red,
              height: ScreenSize.height * .24,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 14,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          //alignment: Alignment.centerRight,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset: const Offset(0, 8), // downward shadow
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.asset(AppImage.demoImage,height: ScreenSize.height * .17,width: ScreenSize.width * .34,fit: BoxFit.cover,)),
                            ],
                          ),
                        ),
                        SizedBox(height: 4,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Hello',style: AppTextStyles.raleWay12,),
                              Text('₹17,00', style: AppTextStyles.raleWayBold17,),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
            ),
            SizedBox(height: ScreenSize.height * .02,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Most Popular', style: AppTextStyles.raleWayBold21,),
                Row(
                  children: [
                    Text('See All', style: AppTextStyles.raleWayBold15,),
                    SizedBox(width: 14,),
                    InkWell(
                        onTap: () {
                          //Get.to(()=> Login());
                        },
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: AppColors.primary,
                          child: Icon(
                            Icons.arrow_forward, size: 20, color: Colors
                              .white,),)),
                  ],
                ),
              ],
            ),
            SizedBox(height: ScreenSize.height * .01,),
            SizedBox(
              //color: Colors.red,
              height: ScreenSize.height * .24,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 14,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          //alignment: Alignment.centerRight,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset: const Offset(0, 8), // downward shadow
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.asset(AppImage.demoImage,height: ScreenSize.height * .17,width: ScreenSize.width * .34,fit: BoxFit.cover,)),
                            ],
                          ),
                        ),
                        SizedBox(height: 4,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Hello',style: AppTextStyles.raleWay12,),
                              Text('₹17,00', style: AppTextStyles.raleWayBold17,),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget topIcons({
    required IconData icon,
    required VoidCallback onIconTap
  }) {
    return GestureDetector(
      onTap: onIconTap,
      child: CircleAvatar(
        backgroundColor: const Color(0xffF8F8F8),
        child: Icon(
          icon,
          size: 20,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _bannerSection(
      RxList<BannersData> banners,
      double height,
      BoxFit fit,
      ) {
    return SizedBox(
      height: height + 140, // 🔥 tall like poster banner
      child: Obx(() {
        // if (banners.isEmpty) {
        //   return _staticBanner(height: height);
        // }

        final currentPage = _controller.bannerPage.value;

        return CarouselSlider.builder(
          itemCount: banners.length,
          itemBuilder: (context, index, realIndex) {
            final banner = banners[index];

            double value = index - currentPage;
            value = value.clamp(-1.0, 1.0);

            // 🔥 subtle floating (NO shrinking)
            final double translateY = value.abs() * 8;
            final double rotateZ = value * 0.004;

            return Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      blurRadius: 6,
                      offset: Offset(0,1)
                  )
                ],
                /// 🔥 IMAGE AS BACKGROUND
                image: DecorationImage(
                  image: NetworkImage(
                    "${ApiUrl.bannerBaseUrl}${banner.images}",
                  ),
                  fit: BoxFit.fill,
                ),


              ),
            );
          },
          options: CarouselOptions(
            height: height + 120,
            viewportFraction: 0.96, // 🔥 edge-to-edge feel
            enlargeCenterPage: false,
            enableInfiniteScroll: banners.length > 1,
            autoPlay: banners.length > 1,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(milliseconds: 900),
            autoPlayCurve: Curves.easeOutCubic,
            scrollPhysics: const BouncingScrollPhysics(),
            onPageChanged: (index, reason) {
              _controller.bannerPage.value = index.toDouble();
            },
          ),
        );
      }),
    );
  }



}
