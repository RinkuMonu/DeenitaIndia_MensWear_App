 import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/textstyle.dart';

Widget buildContainer({
  required String text,
  required Color color,
  //required Color textColor,
}){
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: color,
    ),
    padding: EdgeInsets.symmetric(horizontal: 16,vertical: 6),
    child: Text(text,style: AppTextStyles.raleWay16Primary,),
  );
}


Widget circularProgressTop(){
  return Scaffold(
    backgroundColor: Colors.white,
    body: Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Center(
        child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              color: AppColors.primary, strokeWidth: 2.5,)),
      ),
    ),
  );
}

 Widget circularProgressBottom(){
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


