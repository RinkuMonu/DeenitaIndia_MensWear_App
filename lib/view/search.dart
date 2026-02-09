
import 'package:deenitaindia/constants/textstyle.dart';
import 'package:deenitaindia/widgets/customAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../constants/image.dart';
import '../controller/searchC.dart';
import '../widgets/customAppBar.dart';
import '../widgets/textfield.dart';


class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final controller = Get.put(SearchC());

  List text = ['Jeans','Casual clothes','V-neck tshirt','Winter clothes'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Search",
        showNotification: true,
        showWishlist: false,
        showMenu: false,
        appBarBgColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 0),
        child: Column(
          children: [
            CommonTextField2(
              controller: controller.searchController,
              readOnly: false,
              hint: 'Search for clothes...',
              preffix: SvgPicture.asset(
                AppImage.search,
                height: 28,
                width: 28,
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Searches',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                InkWell(
                    onTap: (){
                      controller.recentSearch.value = false;
                    },
                    child: Text('Clear all',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,decoration: TextDecoration.underline))),
              ],
            ),
            SizedBox(height: 20,),
            Obx((){
              return  Visibility(
                  visible: controller.recentSearch.value,
                  child: searchList());
            })
          ],
        ),
      ),
    );
  }

  Widget searchList(){
    return ListView.builder(
        itemCount: text.length,
        shrinkWrap: true,
        itemBuilder: (context,index){
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(text[index],style: AppTextStyles.alexandria16w300Black,),
              Icon(CupertinoIcons.xmark_circle,color: Colors.grey,)
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Divider(color: Colors.grey.shade300,),
          )
        ],
      );
    });
  }
}
