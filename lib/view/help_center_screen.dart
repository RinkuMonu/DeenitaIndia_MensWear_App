import 'package:deenitaindia/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../widgets/customAppBar.dart';
import 'chatbot_screen.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  _HelpCenterScreenState createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  final String address =
      'Plot No. 97 near Somya Sky Legend Apartment, Dakshinpuri - I, Shrikishan, Sanganer, Jagatpura, Jaipur';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Help Center",
        showWishlist: false,
        showNotification: true,
        showMenu: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Subtitle ──
            Center(
              child: Text(
                "We're always happy to listen, whether it's feedback, support, or a simple hello.",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            const SizedBox(height: 28),

            // ── Contact Cards ──
            Row(
              children: [
                Expanded(
                  child: _contactCard(
                    icon: Icons.phone_outlined,
                    title: 'Call us',
                    subtitle: 'Mon-Sat\n9AM - 6PM',
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _contactCard(
                    icon: Icons.mail_outline,
                    title: 'Email us',
                    subtitle: 'Mon-Sat\n9AM - 6PM',
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _contactCard(
                    icon: Icons.chat_bubble_outline,
                    title: 'Chat\nwith us',
                    subtitle: 'Available 24/7',
                    onTap: () {
                      Get.to(() => ChatbotScreen());
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // ── Address Section ──
            const Text(
              'Address',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      address,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: address));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Address copied!')),
                      );
                    },
                    child: Icon(
                      Icons.copy_rounded,
                      color: Colors.black54,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── Policy Links ──
            _policyTile(title: 'Privacy Policy', onTap: () {}),
            const SizedBox(height: 12),
            _policyTile(title: 'Terms & Conditions', onTap: () {}),
            const SizedBox(height: 12),
            _policyTile(title: 'Refund & Cancellation', onTap: () {}),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // ── Contact Card Widget ──
  Widget _contactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFFDF6E3), // warm yellow-cream
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE8D9A0), width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon circle
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: Color(0xFFEDD98A), // darker golden circle
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 20, color: Colors.black87),
            ),

            const SizedBox(height: 14),

            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 8),

            // Subtitle / time
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.black54,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Policy Tile Widget ──
  Widget _policyTile({required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.black54, size: 22),
          ],
        ),
      ),
    );
  }
}