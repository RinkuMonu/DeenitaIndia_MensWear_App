import 'package:deenitaindia/constants/colors.dart';
import 'package:deenitaindia/constants/image.dart';
import 'package:deenitaindia/view/filterScreen.dart';
import 'package:deenitaindia/widgets/customAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../controller/categoryViewController.dart';

class CategoryView extends StatefulWidget {
  final String title;
  const CategoryView({super.key, required this.title});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  final _controller = Get.put(CategoryViewController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        showMenu: false,
        showNotification: true,
        showWishlist: false,
        title: widget.title,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [

            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: (){
                    Get.to(() => FilterScreen());
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      SvgPicture.asset(AppImage.filterIcon, color: Colors.black,),
                      SizedBox(width: 8,),
                      Text("Filters", style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),)



                    ],
                  ),
                ),
              ),
            ),


            SizedBox(height: 20,),

            GridView.builder(
              itemCount: 6,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.60,
                mainAxisSpacing: 20,
                crossAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      final isSelected = _controller.selectedFav.value == index;
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Stack(
                          children: [
                            Image.asset(AppImage.shirt),
                            Positioned(
                              right: 10,
                              top: 10,
                              child: InkWell(
                                onTap: () {
                                  _controller.selectedFav.value = isSelected
                                      ? -1
                                      : index;
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.all(10),
                                  child: isSelected
                                      ? Icon(
                                    CupertinoIcons.heart_fill,
                                    color: Colors.pinkAccent,
                                  )
                                      : Icon(CupertinoIcons.heart),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    SizedBox(height: 10),
                    Text(
                      'Beige Oversized T-Shirt',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      spacing: 4,
                      children: [
                        Text(
                          'Rs. 1,190',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                        if (index == 1)
                          Text(
                            '50%OFF',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.red,
                            ),
                          ),


                        Spacer(),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 15,
                            ),

                            Text(
                              "4.5k",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 10
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                );
              },
            ),


          ],
        ),
      ),



    );
  }
}
