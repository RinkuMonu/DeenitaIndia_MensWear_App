import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget AppLoader(){
  return Center(
    child: CircularProgressIndicator(
      color: Colors.black,
      strokeWidth: 0.8,
    ),
  );
}