import 'package:deenitaindia/constants/colors.dart';
import 'package:deenitaindia/constants/image.dart';
import 'package:deenitaindia/constants/textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/cartC.dart';
import '../widgets/button.dart';
import '../widgets/customAppBar.dart';
import '../widgets/textfield.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final _controller = Get.put(CartC());
  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(
          title: "Cart",
          showMenu: false,
          appBarBgColor: Colors.white,
          showWishlist: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300)
                ),
                padding: EdgeInsets.symmetric(horizontal: 14,vertical: 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.asset(AppImage.cartImage,height: 80,width: 80,fit: BoxFit.cover,)),
                    SizedBox(width: 20,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Cotton Check Shirt',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                              Icon(Icons.delete_forever_outlined,color: Colors.red,)
                            ],
                          ),
                          Text('Size L',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300)),
                          //Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Rs. 1,100',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Color(0xff808080))),
                              Row(
                                children: [
                                  _buildButton(onTap: (){
                                    _controller.decrease();
                                  },icon: CupertinoIcons.minus),
                                  SizedBox(width: 12,),
                                  Text( _controller.item.value.toString()),
                                  SizedBox(width: 12,),
                                  _buildButton(onTap: (){
                                    _controller.increase();
                                  },icon: Icons.add),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Spacer(),
              _buildRow(text: 'Sub-total', price: 'Rs 2,200'),
              _buildRow(text: 'GST (%)', price: 'Rs 50'),
              _buildRow(text: 'Shipping fee', price: 'Rs 50'),
              Divider(),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total',style: AppTextStyles.alexandria16w400,),
                  Text('Rs 2,300',style: AppTextStyles.alexandria16w400,),
                ],
              ),
              SizedBox(height: 40,),
              AppButton(title: 'Go To Checkout', onTap: () {},bgColor: AppColors.secondary,)
            ],
          ),
        ),
      );
    });
  }

  Widget _buildButton(
  {
    required IconData icon,
    required VoidCallback onTap,
}
      ){
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.shade300)
        ),
        padding: EdgeInsets.symmetric(horizontal: 6,vertical: 4),
        child: Icon(icon),
      ),
    );
  }

  Widget _buildRow(
      {
        required String text,
        required String price,
      }
      ){
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,style: AppTextStyles.alexandria16w300,),
          Text(price,style: AppTextStyles.alexandria16w300Black,),
          
        ],
      ),
    );
  }
}
