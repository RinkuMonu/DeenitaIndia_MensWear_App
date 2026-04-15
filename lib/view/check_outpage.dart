import 'package:deenitaindia/constants/colors.dart';
import 'package:deenitaindia/widgets/button.dart';
import 'package:deenitaindia/widgets/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../controller/checkout_controller.dart';

class CheckOutpage extends StatefulWidget {
  const CheckOutpage({Key? key}) : super(key: key);

  @override
  _CheckOutpageState createState() => _CheckOutpageState();
}

class _CheckOutpageState extends State<CheckOutpage> {
  final controller = Get.put(CheckoutController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Checkout",
        showNotification: true,
        showWishlist: false,
        showMenu: false,
        appBarBgColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🔹 Delivery Address
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Delivery Address",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                GestureDetector(
                  onTap: () {
                    _openAddressSheet(context);
                  },
                  child: Text(
                    "Change",
                    style: TextStyle(
                      color: Colors.black54,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.location_on_outlined, size: 20),
                SizedBox(width: 10),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Home",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500)),
                          Spacer(),
                          Text("30mins Delivery",
                              style: TextStyle(
                                  color: Colors.blue, fontSize: 12)),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Plot no.10 Ramghar, Sikar, Rajasthan",
                        style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16,),
            Divider(height: 12),
            SizedBox(height: 16,),


            /// 🔹 Promo Code
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.shade200,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Enter promo code",
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.local_offer, color: Colors.orange),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text("Add"),
                )
              ],
            ),

            SizedBox(height: 20),

            /// 🔹 Payment Method
            Text("Payment Method",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),

            SizedBox(height: 12),

            Obx(() {
              final controller = Get.find<CheckoutController>();
              final selected = controller.selectedPayment.value;

              Widget paymentContent;

              switch (selected) {
                case "UPI":
                  paymentContent = Column(children: [
                    _paymentItem("PhonePe", "https://i.pinimg.com/736x/b2/e1/af/b2e1af76fbbe9bc446544b8fa71b37b1.jpg"),
                    _paymentItem("Paytm", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEOUQybXzppNik-pBxR-UzHVKwW2_8eGkzFQ&s"),
                    _paymentItem("Google Pay", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTAFyk2Hu-hbJkgcF7nkVkuxTwwYZztsPc_wQ&s"),
                    SizedBox(height: 5),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Add New Method  >", style: TextStyle(color: Colors.grey)),
                    ),
                  ]);
                  break;

                case "Use Coin":
                  paymentContent = Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(children: [
                      Icon(Icons.monetization_on, color: Colors.blue),
                      SizedBox(width: 8),
                      Text("Coin", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                    ]),
                  );
                  break;

                case "Debit/Credit Card":
                  paymentContent = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text("VISA", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue.shade900)),
                    Divider(),
                    TextField(decoration: InputDecoration(labelText: "Card Number")),
                    Row(children: [
                      Expanded(child: TextField(decoration: InputDecoration(labelText: "Expiry Date"))),
                      SizedBox(width: 12),
                      Expanded(child: TextField(decoration: InputDecoration(labelText: "CVV"))),
                    ]),
                  ]);
                  break;

                case "Net Banking":
                  paymentContent = Column(children: [
                    ...banks.take(3).map((bank) => _bankItem(bank)).toList(),
                    SizedBox(height: 4),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => _showAllBanks(),
                        child: Text("View All Banks >", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ),
                    ),
                  ]);
                  break;

                default:
                  paymentContent = SizedBox();
              }

              return Column(
                children: [
                  // ✅ TABS ROW — this was commented out before
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: ["UPI", "Use Coin", "Debit/Credit Card", "Net Banking"]
                          .map((e) {
                        final isSelected = selected == e;
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: () => controller.selectedPayment.value = e,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade200),
                                color: isSelected ? AppColors.yellow_shade : Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                e,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  SizedBox(height: 15),

                  // ✅ PAYMENT PANEL
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: paymentContent,
                  ),
                ],
              );
            }),

            // Obx(
            //     (){
            //       return Column(
            //         children: [
            //           SingleChildScrollView(
            //             scrollDirection: Axis.horizontal,
            //             child: Row(
            //               children: ["UPI", "Use Coin", "Debit/Credit Card", "Net Banking"]
            //                   .map((e) => Padding(
            //                 padding: const EdgeInsets.only(right: 10),
            //                 child: Obx(() {
            //                   final controller = Get.find<CheckoutController>();
            //
            //                   final isSelected =
            //                       controller.selectedPayment.value == e;
            //
            //                   return GestureDetector(
            //                     onTap: () {
            //                       controller.selectedPayment.value = e;
            //                     },
            //                     child: Container(
            //                       padding: EdgeInsets.symmetric(
            //                           horizontal: 14, vertical: 8),
            //                       decoration: BoxDecoration(
            //                         border: Border.all(
            //                             color: Colors.grey.shade200
            //                         ),
            //                         color: isSelected
            //                             ? AppColors.yellow_shade // selected color
            //                             : Colors.white,
            //                         borderRadius: BorderRadius.circular(10),
            //                       ),
            //                       child: Text(
            //                         e,
            //                         style: TextStyle(
            //                           fontSize: 12,
            //                           fontWeight:
            //                           isSelected ? FontWeight.w600 : FontWeight.w400,
            //                         ),
            //                       ),
            //                     ),
            //                   );
            //                 }),
            //               ))
            //                   .toList(),
            //             ),
            //           ),
            //
            //           SizedBox(height: 15),
            //
            //           /// 🔹 Payment List Card
            //           Container(
            //             padding: EdgeInsets.all(12),
            //             decoration: BoxDecoration(
            //               color: Colors.white,
            //               border: Border.all(
            //                   color: Colors.grey.shade200
            //               ),
            //               borderRadius: BorderRadius.circular(12),
            //             ),
            //             child: Column(
            //               children: [
            //                 _paymentItem("PhonePe", "https://i.pinimg.com/736x/b2/e1/af/b2e1af76fbbe9bc446544b8fa71b37b1.jpg"),
            //                 _paymentItem("Paytm", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEOUQybXzppNik-pBxR-UzHVKwW2_8eGkzFQ&s"),
            //                 _paymentItem("Google Pay", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTAFyk2Hu-hbJkgcF7nkVkuxTwwYZztsPc_wQ&s"),
            //
            //                 SizedBox(height: 5),
            //                 Align(
            //                   alignment: Alignment.centerLeft,
            //                   child: Text("Add New Method  >",
            //                       style: TextStyle(color: Colors.grey)),
            //                 )
            //               ],
            //             ),
            //           ),
            //         ],
            //       );
            //     }
            // ),

            SizedBox(height: 20),

            /// 🔹 Price Details
            _priceRow("Sub-total", "Rs 2,200"),
            _priceRow("GST (%)", "Rs 50"),
            _priceRow("Shipping fee", "Rs 50"),

            Divider(),

            _priceRow("Total", "Rs 2,300", isBold: true),

            SizedBox(height: 20),

            /// 🔹 Pay Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: AppButton(title: "Pay", onTap: (){}, bgColor: AppColors.secondary,
              textColor: Colors.white,),
            )
          ],
        ),
      ),
    );



  }

  void _showAllBanks() {
    Get.bottomSheet(
      Container(
        height: MediaQuery.of(context).size.height * 0.6,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("All Banks", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                GestureDetector(onTap: () => Get.back(), child: Icon(Icons.close)),
              ],
            ),
            SizedBox(height: 12),
            Expanded(
              child: ListView(
                children: banks.map((bank) => _bankItem(bank)).toList(),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }


  Widget _priceRow(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: isBold ? Colors.black : Colors.grey.shade700,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentItem(String name, String image) {
    return Obx(() {


      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            CircleAvatar(radius: 14,  child: Image.network(image, fit: BoxFit.cover,),),
            SizedBox(width: 10),

            Expanded(child: Text(name)),

            GestureDetector(
              onTap: () {
                controller.selectedPayment.value = name;
              },
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey),
                  color: controller.selectedPayment.value == name
                      ? Colors.green
                      : Colors.transparent,
                ),
                child: controller.selectedPayment.value == name
                    ? Icon(Icons.check, size: 14, color: Colors.white)
                    : null,
              ),
            )
          ],
        ),
      );
    });
  }

  // Net Banking Panel Widget
  Widget _netBankingPanel() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ...banks.take(3).map((bank) => _bankItem(bank)).toList(),
          SizedBox(height: 4),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () => _showAllBanks(),
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: Text(
                "View All Banks >",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

// Single bank item
  Widget _bankItem(BankModel bank) {
    return Obx(() {
      final controller = Get.find<CheckoutController>();
      final isSelected = controller.selectedBank.value == bank.name;

      return GestureDetector(
        onTap: () => controller.selectedBank.value = bank.name,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade100, width: 0.5),
            ),
          ),
          child: Row(
            children: [
              // Bank logo circle
              CircleAvatar(
                radius: 17,
                backgroundColor: bank.color,
                child: bank.logoUrl.isNotEmpty
                    ? ClipOval(
                  child: Image.network(
                    bank.logoUrl,
                    width: 34, height: 34,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Text(
                      bank.name[0],
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
                    : Text(
                  bank.name[0],
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(width: 12),

              // Bank name
              Expanded(
                child: Text(
                  bank.name,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                ),
              ),

              // Checkbox
              AnimatedContainer(
                duration: Duration(milliseconds: 150),
                width: 20, height: 20,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.green : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? Colors.green : Colors.grey.shade300,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: isSelected
                    ? Icon(Icons.check, size: 13, color: Colors.white)
                    : null,
              ),
            ],
          ),
        ),
      );
    });
  }
  void _openAddressSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        height: MediaQuery.of(context).size.height * 0.65,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Obx(() {
          return Column(
            children: [

              /// 🔹 Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Select Address",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(Icons.close),
                  )
                ],
              ),

              SizedBox(height: 16),

              /// 🔹 Address Box
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListView(
                    children: [

                      /// 🔹 Address List
                      ...controller.addressList.map((e) {
                        final isSelected =
                            controller.address.value == e["address"];

                        return GestureDetector(
                          onTap: () {
                            controller.address.value = e["address"];
                          },
                          child: Container(
                            color: isSelected
                                ? Color(0xffEAF3FF)
                                : Colors.white,
                            padding: EdgeInsets.all(14),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.location_on_outlined,
                                        size: 20),
                                    SizedBox(width: 10),

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                e["title"],
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w600),
                                              ),
                                              SizedBox(width: 6),

                                              if (e["isDefault"] == true)
                                                Container(
                                                  padding: EdgeInsets
                                                      .symmetric(
                                                      horizontal: 6,
                                                      vertical: 2),
                                                  decoration: BoxDecoration(
                                                    color: Colors
                                                        .grey.shade200,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(6),
                                                  ),
                                                  child: Text(
                                                    "Default",
                                                    style: TextStyle(
                                                        fontSize: 10),
                                                  ),
                                                ),
                                            ],
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            e["address"],
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),

                      /// 🔹 Add New Address
                      GestureDetector(
                        onTap: () {
                          controller.addEmptyAddress();
                        },
                        child: Container(
                          padding: EdgeInsets.all(14),
                          alignment: Alignment.center,
                          child: Text(
                            "+ Add New Address",
                            style: TextStyle(
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16),

              /// 🔹 Done Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffDCD3BF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Done",
                      style: TextStyle(color: Colors.black)),
                ),
              ),
            ],
          );
        }),
      ),
      isScrollControlled: true,
    );
  }
}
