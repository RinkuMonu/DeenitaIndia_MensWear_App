import 'package:flutter/material.dart';

void showCompleteProfilePopup(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // ❌ tap outside to dismiss? set true if needed
    builder: (context) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),

                /// TITLE
                const Text(
                  'Complete Profile',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 8),

                /// SUBTITLE
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Finish your profile to unlock features',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontWeight: FontWeight.w300
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                const Divider(height: 1),

                /// ACTION BUTTONS
                Row(
                  children: [
                    /// CONTINUE
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          // TODO: Navigate to profile screen
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),

                    Container(
                      width: 1,
                      height: 48,
                      color: Colors.grey.shade300,
                    ),

                    /// SKIP
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: const Text(
                            'Skip',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}