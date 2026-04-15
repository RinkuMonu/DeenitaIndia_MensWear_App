// import 'package:deenitaindia/constants/image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:deenitaindia/widgets/customAppBar.dart';
//
// import '../controller/order_detail_controller.dart';
//
// // ─── Controller ───────────────────────────────────────────────
//
//
// // ─── Screen ───────────────────────────────────────────────────
// class OrderDetailScreen extends StatelessWidget {
//   const OrderDetailScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(OrderDetailController());
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: CustomAppBar(
//         title: "Orders Details",
//         showNotification: true,
//         showWishlist: false,
//         showMenu: false,
//         appBarBgColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(vertical: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//             /// 🔹 Order Card
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//               child: Container(
//                 padding: EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   border: Border.all(color: Colors.grey.shade200),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(
//                   children: [
//                     // Product image
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(8),
//                       child: Image.network(
//                         "https://i.pinimg.com/736x/3a/47/7e/3a477e02e59b2f3a5ae8eddd7de7c68d.jpg",
//                         width: 90,
//                         height: 100,
//                         fit: BoxFit.cover,
//                         errorBuilder: (_, __, ___) => Container(
//                           width: 90, height: 100,
//                           color: Colors.grey.shade200,
//                           child: Icon(Icons.image, color: Colors.grey),
//                         ),
//                       ),
//                     ),
//
//                     SizedBox(width: 12),
//
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Order number row
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                   "Order#115642446459576",
//                                   style: TextStyle(
//                                     fontSize: 13,
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                               Icon(Icons.chevron_right, size: 18, color: Colors.black54),
//                             ],
//                           ),
//
//                           SizedBox(height: 4),
//
//                           Text(
//                             "Genzi  |  OFF PINK PARTY SH..",
//                             style: TextStyle(fontSize: 13, color: Colors.black87),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//
//                           SizedBox(height: 4),
//
//                           Text(
//                             "Size L  |  Prepaid",
//                             style: TextStyle(fontSize: 12, color: Colors.grey),
//                           ),
//
//                           SizedBox(height: 10),
//
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "Rs. 1,100",
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.black54,
//                                 ),
//                               ),
//
//                               // Order Return button
//                               Container(
//                                 padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                                 decoration: BoxDecoration(
//                                   color: Color(0xffE8F1FF),
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 child: Text(
//                                   "Order Return",
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     color: Colors.blue,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             SizedBox(height: 16),
//
//             /// 🔹 Delivery Info Banner
//             Container(
//               width: double.infinity,
//               color: Color(0xffF5F0E4),
//               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Box icon
//                   Container(
//                     width: 40, height: 40,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Image.asset(AppImage.parcelBox, fit: BoxFit.cover,)
//                   ),
//
//                   SizedBox(width: 14),
//
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Dilvered on 08/02/26",
//                         style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
//                       ),
//                       SizedBox(height: 6),
//                       Text("Vinod", style: TextStyle(fontSize: 13, color: Colors.black87)),
//                       SizedBox(height: 2),
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width - 100,
//                         child: Text(
//                           "Plot No. 97 near Somya Sky Legend Apartment,\nDakshinpuri - I, Shrikishan, Sanganer, Jagatpura, Jaipur",
//                           style: TextStyle(fontSize: 12, color: Colors.black87, height: 1.5),
//                         ),
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         "91+ 00000 00000",
//                         style: TextStyle(fontSize: 12, color: Colors.black87),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//
//             SizedBox(height: 32),
//
//             /// 🔹 Rating Section
//             Center(
//               child: Text(
//                 "How was the product?",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//               ),
//             ),
//
//             SizedBox(height: 16),
//
//             Obx(() => Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(5, (index) {
//                 final filled = index < controller.rating.value;
//                 return GestureDetector(
//                   onTap: () => controller.rating.value = index + 1,
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 10),
//                     child: Icon(
//                       filled ? Icons.star_rounded : Icons.star_border_rounded,
//                       size: 42,
//                       color: filled ? Colors.amber : Colors.black,
//                     ),
//                   ),
//                 );
//               }),
//             )),
//
//             SizedBox(height: 32),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:deenitaindia/constants/image.dart';
import 'package:deenitaindia/view/map_screen.dart';
import 'package:deenitaindia/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:deenitaindia/widgets/customAppBar.dart';

import '../constants/colors.dart';
import '../controller/order_detail_controller.dart';
import '../widgets/app_pop_up.dart';

// ─── Controller ───────────────────────────────────────────────


// ─── Screen ───────────────────────────────────────────────────
class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderDetailController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Orders Details",
        showNotification: true,
        showWishlist: false,
        showMenu: false,
        appBarBgColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🔹 Order Card
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        "https://i.pinimg.com/736x/3a/47/7e/3a477e02e59b2f3a5ae8eddd7de7c68d.jpg",
                        width: 90, height: 100, fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 90, height: 100,
                          color: Colors.grey.shade200,
                          child: Icon(Icons.image, color: Colors.grey),
                        ),
                      ),
                    ),

                    SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Order#115642446459576",
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Icon(Icons.chevron_right, size: 18, color: Colors.black54),
                            ],
                          ),

                          SizedBox(height: 4),

                          Text(
                            controller.isDelivered
                                ? "Genzi  |  OFF PINK PARTY SH.."
                                : "Polo  |  GREEN-SHIRT",
                            style: TextStyle(fontSize: 13, color: Colors.black87),
                            overflow: TextOverflow.ellipsis,
                          ),

                          SizedBox(height: 4),
                          Text("Size L  |  Prepaid", style: TextStyle(fontSize: 12, color: Colors.grey)),
                          SizedBox(height: 10),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Rs. 1,100",
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black54),
                              ),

                              // ✅ Button changes based on status
                              GestureDetector(
                                onTap: () {
                                  if(controller.isDelivered) {
                                    orderCancelPopup();
                                  }else{

                                    Get.dialog(
                                      AppPopUp(
                                        image: "assets/images/success.png",
                                        title: "Return Confirmed",
                                        subTitle: "Your return is scheduled. We’ll notify you when the pickup agent arrives.",
                                        buttonText: "Continue",
                                        onTap: () {
                                          Get.back();
                                        },
                                      ),
                                      barrierDismissible: false,
                                    );

                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: controller.isDelivered
                                        ? Color(0xffE8F1FF)
                                        : Color(0xffFFE8E8),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    controller.isDelivered ? "Order Return" : "Cancel Order",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: controller.isDelivered ? Colors.blue : Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // ✅ Show tracker OR rating based on status
            if (!controller.isDelivered) ...[

              /// 🔹 Order Status Tracker
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Order Status",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    GestureDetector(
                      onTap: () {
                        Get.to(()=> MapScreen());
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.alt_route_outlined, size: 16, color: Colors.blue),
                            SizedBox(width: 6),
                            Text("View Map",
                                style: TextStyle(color: Colors.blue, fontSize: 13, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 28),

              /// 🔹 Step Tracker
              _OrderTracker(currentStep: controller.currentStep),

              SizedBox(height: 28),

            ] else ...[

              /// 🔹 Rating Section
              Center(
                child: Text("How was the product?",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),

              SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  final filled = index < controller.rating.value;
                  return GestureDetector(
                    onTap: () => controller.rating.value = index + 1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(
                        filled ? Icons.star_rounded : Icons.star_border_rounded,
                        size: 42,
                        color: filled ? Colors.amber : Colors.black,
                      ),
                    ),
                  );
                }),
              ),

              SizedBox(height: 28),
            ],

            /// 🔹 Delivery Info Banner (always shown)
            Container(
              width: double.infinity,
              color: AppColors.yellow_shade,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(AppImage.parcelBox, height: 30, width: 30),
                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Dilvered on 08/02/26",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                        SizedBox(height: 6),
                        Text("Vinod", style: TextStyle(fontSize: 13)),
                        SizedBox(height: 2),
                        Text(
                          "Plot No. 97 near Somya Sky Legend Apartment,\nDakshinpuri - I, Shrikishan, Sanganer, Jagatpura, Jaipur",
                          style: TextStyle(fontSize: 12, color: Colors.black87, height: 1.5),
                        ),
                        SizedBox(height: 4),
                        Text("91+ 00000 00000", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          ],
        )),
      ),
    );
  }


  void orderCancelPopup() {
    Get.dialog(
      Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,  // 👈 Important: shrink to content
              children: [

                Text(
                  "Are you sure you want to cancel this order?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),

                SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    title: "Yes, cancel",
                    onTap: () {
                      Get.back();
                      showReasonBottomSheet();
                    },
                    bgColor: Colors.red,
                    textColor: Colors.white,
                  ),
                ),

                SizedBox(height: 10),

                GestureDetector(
                  onTap: () { Get.back(); },
                  child: Text(
                    "Back to the order",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }


  void showReasonBottomSheet() {
    final List<String> reasons = [
      "Wrong item",
      "Wrong size",
      "Damaged/defective product",
      "Poor quality",
      "Ordered by mistake",
      "Changed mind",
      "Missing items",
      "Other",
    ];

    final RxString selectedReason = ''.obs;
    final TextEditingController describeController = TextEditingController();
    final TextEditingController addressController = TextEditingController();

    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      Obx(() => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(Get.context!).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              /// 🔹 HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order Return Reason",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(Icons.close, color: Colors.black),
                  ),
                ],
              ),

              SizedBox(height: 16),

              /// 🔹 REASON LIST
              ...reasons.map((reason) {
                return GestureDetector(
                  onTap: () => selectedReason.value = reason,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            color: selectedReason.value == reason
                                ? Colors.black
                                : Colors.transparent,
                            border: Border.all(
                              color: selectedReason.value == reason
                                  ? Colors.black
                                  : Colors.grey.shade400,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: selectedReason.value == reason
                              ? Icon(Icons.check, color: Colors.white, size: 16)
                              : null,
                        ),
                        SizedBox(width: 12),
                        Text(
                          reason,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),

              /// 🔹 SHOW TEXTFIELDS IF "OTHER" SELECTED
              if (selectedReason.value == "Other") ...[
                SizedBox(height: 12),
                TextField(
                  controller: describeController,
                  decoration: InputDecoration(
                    hintText: "Describe your reason",
                    hintStyle: TextStyle(color: Colors.grey),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(
                    hintText: "Pickup Address",
                    hintStyle: TextStyle(color: Colors.grey),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ],

              SizedBox(height: 24),

              /// 🔹 SUBMIT BUTTON
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  title: "Submit",
                  onTap: () {
                    if (selectedReason.value.isEmpty) {
                      Get.snackbar("Error", "Please select a reason");
                      return;
                    }
                    // Handle submit
                    Get.back();
                  },
                  bgColor: AppColors.yellow_shade,
                  textColor: Colors.black,
                ),
              ),

              SizedBox(height: 10),
            ],
          ),
        ),
      )),
    );
  }
}

// ─── Order Tracker Widget ──────────────────────────────────────
class _OrderTracker extends StatelessWidget {
  final int currentStep; // 0=packing, 1=picked, 2=in_transit, 3=delivered

  const _OrderTracker({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final steps = [
      {"label": "Packing",    "sub": ""},
      {"label": "Picked",     "sub": ""},
      {"label": "In Transit", "sub": ""},
      {"label": "Delivered",  "sub": "within 5min"},
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [

          // ── Dots + Lines row ──
          Row(
            children: List.generate(steps.length, (i) {
              final isDone = i <= currentStep;
              final isLast = i == steps.length - 1;

              return Expanded(
                child: Row(
                  children: [
                    // Dot
                    Container(
                      width: 22, height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDone ? Colors.green : Colors.white,
                        border: Border.all(
                          color: isDone ? Colors.green : Colors.grey.shade400,
                          width: 2,
                        ),
                      ),
                      child: isDone
                          ? Icon(Icons.circle, size: 10, color: Colors.white)
                          : null,
                    ),

                    // Line (not after last)
                    if (!isLast)
                      Expanded(
                        child: Container(
                          height: 2.5,
                          color: i < currentStep ? Colors.green : Colors.grey.shade300,
                        ),
                      ),
                  ],
                ),
              );
            }),
          ),

          SizedBox(height: 10),

          // ── Labels row ──
          Row(
            children: List.generate(steps.length, (i) {
              return Expanded(
                child: Column(
                  crossAxisAlignment: i == 0
                      ? CrossAxisAlignment.start
                      : i == steps.length - 1
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.center,
                  children: [
                    Text(
                      steps[i]["label"]!,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: i <= currentStep ? Colors.black : Colors.grey,
                      ),
                    ),
                    if (steps[i]["sub"]!.isNotEmpty)
                      Text(
                        steps[i]["sub"]!,
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }



}