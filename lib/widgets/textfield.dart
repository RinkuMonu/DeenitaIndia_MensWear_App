import 'package:deenitaindia/constants/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/colors.dart';

class CommonTextField extends StatelessWidget {
 // final IconData icon;
  final dynamic mainController;
  final FocusNode? focusNode;
  final TextEditingController controller;
  final String? label;
  final String hint;
  final bool readOnly;
  final bool obscureText;
  final int? maxLength;
  final VoidCallback? onToggleVisibility;
  final Widget? suffix;
  //final ValueNotifier<String?> errorNotifier;

  CommonTextField({
    super.key,
   // required this.icon,
    required this.controller,
    required this.hint,
    //required this.errorNotifier,
    this.mainController,
    this.focusNode,
    this.label,
    this.obscureText = false,
    this.readOnly = false,
    this.maxLength,
    this.onToggleVisibility,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Text(
              label!,
              style: AppTextStyles.alexandria16w500
            ),
          const SizedBox(height: 8),

          /// Text Field Container
          TextFormField(
            controller: controller,
            focusNode: focusNode,
            obscureText: obscureText,
            maxLength: maxLength,
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.w500),
            readOnly: readOnly,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: _getKeyboardType(),
            textCapitalization: hint.contains("PAN Card Number")
                ? TextCapitalization.characters
                : TextCapitalization.none,
            decoration: _inputDecoration(),
            // onChanged: (value) {
            //   errorNotifier.value = _validate(value);
            //   if (hint == "Enter mobile number" && value.length == 10) {
            //     focusNode?.unfocus();
            //   }
            //   if (label == "Email") {
            //     mainController?.onEmailChanged(value);
            //   }
            // },
          ),

          /// Error Text
          // ValueListenableBuilder<String?>(
          //   valueListenable: errorNotifier,
          //   builder: (_, error, __) {
          //     if (error == null) return const SizedBox(height: 6);
          //     return Padding(
          //       padding: const EdgeInsets.only(left: 16, top: 6),
          //       child: Text(
          //         error,
          //         style: const TextStyle(
          //           fontSize: 12,
          //           color: Colors.redAccent,
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }

  /// 🔹 Input Decoration
  InputDecoration _inputDecoration() {
    return InputDecoration(
      hintText: hint,
      counterText: "",
      filled: true,
      fillColor: Colors.white,
      hintStyle: const TextStyle(fontSize: 16, color: Colors.grey,fontWeight: FontWeight.w300),
      enabledBorder: _border(Colors.grey.shade200),
      focusedBorder: _border(Colors.grey.shade200),
      errorBorder: _border(Colors.red),
      suffixIcon: _buildSuffix(),
      prefixIcon: _buildPrefix(),
    );
  }

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: color, width: 2),
  );

  Widget? _buildPrefix() {
    if (!hint.contains("Enter your mobile number")) return null;

    return SizedBox(
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
              color: Color(0xff808080)
            ),
          ),
        ),
      ),
    );
  }

  Widget? _buildSuffix() {
    if (suffix == null && onToggleVisibility == null) return null;

    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (suffix != null) suffix!,
          if (onToggleVisibility != null)
            GestureDetector(
              onTap: onToggleVisibility,
              child: obscureText
                  ? Icon(Icons.remove_red_eye)
                  : Icon(Icons.visibility_off_sharp),
            ),
        ],
      ),
    );
  }

  TextInputType _getKeyboardType() {
    if (hint.contains("mobile") ||
        hint.contains("pincode") ||
        hint.contains("aadhaar") ||
        hint.contains("Otp") ||
        hint.contains("mpin")) {
      return TextInputType.phone;
    }
    return TextInputType.text;
  }

  String? _validate(String value) {
    if (value.isEmpty) return '$label is required';
    return null;
  }
}

class CommonTextField2 extends StatelessWidget {
  // final IconData icon;
  final dynamic mainController;
  final FocusNode? focusNode;
  final TextEditingController controller;
  final String? label;
  final String hint;
  final bool obscureText;
  final int? maxLength;
  final bool readOnly;
  final bool showCursor;
  final Widget? preffix;
  final VoidCallback? onToggleVisibility;
  final VoidCallback? onTap;
  final Widget? suffix;
  //final ValueNotifier<String?> errorNotifier;

  CommonTextField2({
    super.key,
    // required this.icon,
    required this.controller,
    required this.hint,
    //required this.errorNotifier,
    this.mainController,
    this.focusNode,
    this.showCursor = true,
    this.readOnly = false,
    this.label,
    this.obscureText = false,
    this.maxLength,
    this.onToggleVisibility,
    this.onTap,
    this.suffix,
    this.preffix
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Text(
              label!,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          const SizedBox(height: 8),

          /// Text Field Container
          TextFormField(
            controller: controller,
            focusNode: focusNode,
            obscureText: obscureText,
            maxLength: maxLength,
            cursorColor: Colors.black,
            readOnly: readOnly,
            showCursor: showCursor,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: _getKeyboardType(),
            textCapitalization: hint.contains("PAN Card Number")
                ? TextCapitalization.characters
                : TextCapitalization.none,
            decoration: _inputDecoration(),
            onTap: onTap
            // onChanged: (value) {
            //   errorNotifier.value = _validate(value);
            //   if (hint == "Enter mobile number" && value.length == 10) {
            //     focusNode?.unfocus();
            //   }
            //   if (label == "Email") {
            //     mainController?.onEmailChanged(value);
            //   }
            // },
          ),

          /// Error Text
          // ValueListenableBuilder<String?>(
          //   valueListenable: errorNotifier,
          //   builder: (_, error, __) {
          //     if (error == null) return const SizedBox(height: 6);
          //     return Padding(
          //       padding: const EdgeInsets.only(left: 16, top: 6),
          //       child: Text(
          //         error,
          //         style: const TextStyle(
          //           fontSize: 12,
          //           color: Colors.redAccent,
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }

  /// 🔹 Input Decoration
  InputDecoration _inputDecoration() {
    return InputDecoration(
      hintText: hint,
      counterText: "",
      filled: true,
      fillColor: Colors.white,
      hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
      enabledBorder: _border(Colors.grey.shade200),
      focusedBorder: _border(AppColors.secondary),
      errorBorder: _border(Colors.red),
      suffixIcon: _buildSuffix(),
      prefixIcon: SizedBox(
        width: 40,
        child: Center(
          child: preffix
        ),
      ),
      prefixIconConstraints: BoxConstraints(
        minWidth: 15,
        minHeight: 15,
      )
    );
  }

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: color, width: 2),
  );

  Widget? _buildPrefix() {
    if (!hint.contains("Enter mobile number")) return null;

    return SizedBox(
      width: 40,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            '91+',
            style: TextStyle(
              fontSize: 14,
              color: controller.text.isNotEmpty
                  ? Colors.black
                  : Colors.grey.shade500,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget? _buildSuffix() {
    if (suffix == null && onToggleVisibility == null) return null;

    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (suffix != null) suffix!,
          if (onToggleVisibility != null)
            GestureDetector(
              onTap: onToggleVisibility,
              child: obscureText
                  ? Icon(Icons.remove_red_eye)
                  : Icon(Icons.visibility_off_sharp),
            ),
        ],
      ),
    );
  }

  TextInputType _getKeyboardType() {
    if (hint.contains("mobile") ||
        hint.contains("pincode") ||
        hint.contains("aadhaar") ||
        hint.contains("Otp") ||
        hint.contains("mpin")) {
      return TextInputType.phone;
    }
    return TextInputType.text;
  }

  String? _validate(String value) {
    if (value.isEmpty) return '$label is required';
    return null;
  }
}
