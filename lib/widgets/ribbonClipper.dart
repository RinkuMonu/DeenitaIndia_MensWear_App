import 'package:flutter/material.dart';

class RibbonLabel extends StatelessWidget {
  final String text;

  const RibbonLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width/1.5,  // full width like the image
      height: 30,
      child: ClipPath(
        clipper: RibbonClipper(),
        child: Container(
          color: const Color(0xFFCC2936),
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 17,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}

class RibbonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const double notchDepth = 12; // ✅ safe value for height 48
    final double mid = size.height / 2;

    final path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);

    // Right inward notch
    path.lineTo(size.width, mid - notchDepth);
    path.lineTo(size.width - notchDepth, mid);
    path.lineTo(size.width, mid + notchDepth);
    path.lineTo(size.width, size.height);

    path.lineTo(0, size.height);

    // Left inward notch
    path.lineTo(0, mid + notchDepth);
    path.lineTo(notchDepth, mid);
    path.lineTo(0, mid - notchDepth);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}