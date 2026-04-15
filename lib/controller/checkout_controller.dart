import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  /// 🔄 Loading
  var isLoading = false.obs;

  final selectedBank = RxString("State Bank of India");
  /// 📍 Address
  var address = "Add your address".obs;

  /// 💰 Price details
  var subTotal = 2200.0.obs;
  var gst = 50.0.obs;
  var deliveryFee = 50.0.obs;

  double get totalAmount => subTotal.value + gst.value + deliveryFee.value;

  /// 💳 Payment method
  var selectedPayment = "UPI".obs;

  /// 🎟️ Promo code
  var promoCode = "".obs;
  var discount = 0.0.obs;

  /// 📦 Change address
  void updateAddress(String newAddress) {
    address.value = newAddress;
  }

  /// 💳 Select payment
  void selectPayment(String method) {
    selectedPayment.value = method;
  }

  /// 🎟️ Apply promo
  void applyPromo(String code) {
    promoCode.value = code;

    // Dummy logic
    if (code == "SAVE10") {
      discount.value = 100;
      Get.snackbar("Success", "Promo Applied");
    } else {
      discount.value = 0;
      Get.snackbar("Error", "Invalid Promo Code");
    }
  }

  /// 🧾 Final payable amount
  double get finalAmount => totalAmount - discount.value;

  /// 🚀 Place order
  void placeOrder() async {
    if (address.value == "Add your address") {
      Get.snackbar("Error", "Please add address");
      return;
    }

    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;

    Get.snackbar("Success", "Order Placed Successfully");
  }


  var addressList = <Map<String, dynamic>>[
    {
      "title": "Home",
      "address": "Plot no.10 Ramghar, Sikar, Rajasthan",
      "isDefault": true
    },
    {
      "title": "Office",
      "address": "Plot no.10 Ramghar, Sikar, Rajasthan",
      "isDefault": false
    }
  ].obs;

  void addEmptyAddress() {
    addressList.add({
      "title": "Title",
      "address": "Address....",
      "isDefault": false,
      "isNew": true
    });

    address.value = "Address...."; // auto select
  }
}


// Bank model
class BankModel {
  final String name;
  final String logoUrl;
  final Color color;

  BankModel({required this.name, required this.logoUrl, required this.color});
}

// Banks list
final List<BankModel> banks = [
  BankModel(name: "State Bank of India", logoUrl: "https://upload.wikimedia.org/wikipedia/commons/c/cc/SBI-logo.svg", color: Colors.blue.shade800),
  BankModel(name: "HDFC Bank",           logoUrl: "https://upload.wikimedia.org/wikipedia/commons/2/28/HDFC_Bank_Logo.svg", color: Colors.red),
  BankModel(name: "Axis Bank",           logoUrl: "https://upload.wikimedia.org/wikipedia/commons/1/1a/Axis_Bank_logo.svg", color: Colors.purple),
  BankModel(name: "ICICI Bank",          logoUrl: "https://upload.wikimedia.org/wikipedia/commons/1/12/ICICI_Bank_Logo.svg", color: Colors.orange),
  BankModel(name: "Kotak Mahindra",      logoUrl: "", color: Colors.amber.shade700),
  BankModel(name: "Punjab National Bank",logoUrl: "", color: Colors.blue.shade600),
];

// In CheckoutController
