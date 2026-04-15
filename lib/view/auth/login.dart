import 'package:deenitaindia/constants/colors.dart';
import 'package:deenitaindia/view/auth/registerScreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/image.dart';
import '../../constants/size.dart';
import '../../controller/loginC.dart';
import '../../widgets/button.dart';
import '../../widgets/textfield.dart';
import 'forgotPassword.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _controller = Get.put(LoginC());

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Stack(
        children: [

          /// Background
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(AppImage.backWave),
          ),

          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(height: ScreenSize.height * .15),

                const Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'We saved your spot',
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 50),

                /// 🔥 TAB SWITCHER
                Obx(() => Row(
                  children: [

                    /// MOBILE TAB
                    GestureDetector(
                      onTap: _controller.selectMobile,
                      child: Column(
                        children: [
                          Text(
                            "Mobile Number",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: _controller.isMobileSelected.value
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 15),
                    // const Text("|"),
                    // const SizedBox(width: 15),
                    //
                    // /// EMAIL TAB
                    // GestureDetector(
                    //   onTap: _controller.selectEmail,
                    //   child: Column(
                    //     children: [
                    //       Text(
                    //         "Email",
                    //         style: TextStyle(
                    //           fontWeight: FontWeight.w600,
                    //           color: !_controller.isMobileSelected.value
                    //               ? Colors.black
                    //               : Colors.grey,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                )),


                /// 🔥 DYNAMIC FORM
                Obx(() {

                  /// ───────── MOBILE UI ─────────
                  if(_controller.isMobilePasswordSelected.value){
                    return Column(
                      children: [

                        CommonTextField(
                          controller: _controller.mobileC,
                          maxLength: 10,
                          prefix: SizedBox(
                            width: 60,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: Text(
                                  '91+',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Alexandria',
                                      color: Colors.grey
                                  ),
                                ),
                              ),
                            ),
                          ),
                          hint: 'Enter your mobile number',
                          label: "",
                          keyBoard: TextInputType.number,
                        ),

                        Obx(() => CommonTextField(
                          controller: _controller.passC,
                          hint: 'Enter your password',
                          label: "",
                          obscureText: _controller.isPasswordHidden.value,
                          prefix: IconButton(
                            icon: Icon(
                              _controller.isPasswordHidden.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              _controller.isPasswordHidden.value =
                              !_controller.isPasswordHidden.value;
                            },
                          ),
                        )),

                        SizedBox(height: 20,),
                        Align(alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap:(){
                              Get.to(()=> ForgotPassword());
                            },
                            child: Text("Forget Password", style: TextStyle(
                            color: Colors.grey,
                              fontWeight: FontWeight.w500,

                          ),),
                        ),),

                        const SizedBox(height: 25),

                        Obx(() => AppButton(
                          title: _controller.isLoading.value
                              ? "Loading..."
                              : "Login",
                          onTap: _controller.sendOtp,
                        )),


                        SizedBox(height: 20,),
                        Align(
                          alignment: AlignmentGeometry.topCenter,
                          child: InkWell(
                            onTap: (){
                              _controller.selectMobilePassword();
                            },
                            child: Text("Login with Otp", style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500,
                                fontSize: 16
                            ),),
                          ),
                        ),

                        SizedBox(height: 30,),
                        Align(
                          alignment: Alignment.center,
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                              children: [

                                const TextSpan(
                                  text: "Don’t have an account? ",
                                ),

                                TextSpan(
                                  text: "Create account",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.to(()=> RegisterScreen()); // change route as needed
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }



                  /// ───────── MOBILE UI ─────────
                  if (_controller.isMobileSelected.value) {
                    return Column(
                      children: [

                        CommonTextField(
                          controller: _controller.mobileC,
                          maxLength: 10,
                          prefix: SizedBox(
                            width: 60,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: Text(
                                  '91+',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Alexandria',
                                      color: Colors.grey
                                  ),
                                ),
                              ),
                            ),
                          ),
                          hint: 'Enter your mobile number',
                          label: "",
                          keyBoard: TextInputType.number,
                        ),
                        const SizedBox(height: 16),
                        AppButton(
                          title: 'Send OTP',
                          onTap: _controller.sendOtp,
                        ),

                        const SizedBox(height: 20),

                        Align(
                          alignment: AlignmentGeometry.topCenter,
                          child: InkWell(
                            onTap: (){
                              _controller.selectMobilePassword();
                            },
                            child: Text("Login with Password", style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                              fontSize: 16
                            ),),
                          ),
                        ),


                        SizedBox(height: 30,),
                        Align(
                          alignment: Alignment.center,
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                              children: [

                                const TextSpan(
                                  text: "Don’t have an account? ",
                                ),

                                TextSpan(
                                  text: "Create account",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.to(()=> RegisterScreen()); // change route as needed
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  /// ───────── EMAIL UI ─────────
                  return Column(
                    children: [

                      CommonTextField(
                        controller: _controller.emailC,
                        hint: 'Enter your mail id',
                        label: "",
                        prefix: Icon(
                          Icons.email_outlined,
                          color: Colors.grey,
                        ),
                      ),


                      Obx(() => CommonTextField(
                        controller: _controller.passC,
                        hint: 'Enter password',
                        label: "",
                        obscureText: _controller.isPasswordHidden.value,
                        prefix: IconButton(
                          icon: Icon(
                            _controller.isPasswordHidden.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            _controller.isPasswordHidden.value =
                            !_controller.isPasswordHidden.value;
                          },
                        ),
                      )),

                      SizedBox(height: 20,),
                      Align(alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap:(){
                            Get.to(()=> ForgotPassword());
                          },
                          child: Text("Forget Password", style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,

                          ),),
                        ),),


                      const SizedBox(height: 25),

                      Obx(() => AppButton(
                        title: _controller.isLoading.value
                            ? "Loading..."
                            : "Login",
                        onTap: _controller.sendOtp,
                      )),


                      SizedBox(height: 30,),
                      Align(
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            children: [

                              const TextSpan(
                                text: "Don’t have an account? ",
                              ),

                              TextSpan(
                                text: "Create account",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.to(()=> RegisterScreen()); // change route as needed
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}