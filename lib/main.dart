import 'package:deenitaindia/service/locationServices.dart';
import 'package:deenitaindia/view/auth/splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Get.putAsync(() => LocationServices().init());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: GetMaterialApp(
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
            child: child!,
          );
        },
        title: 'Deenita',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
         // primarySwatch: Colors.blue,
          fontFamily: 'Alexandria',
        ),
        home: const Splash(),
      ),
    );
  }
}

