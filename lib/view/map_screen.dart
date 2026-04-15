import 'package:deenitaindia/controller/map_controller.dart';
import 'package:deenitaindia/widgets/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../widgets/app_pop_up.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final controller = Get.put(MapController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.dialog(
        AppPopUp(
          image: "assets/images/success.png",
          title: "Success",
          subTitle: "Your order has been placed successfully",
          buttonText: "Continue",
          onTap: () {
            Get.back();
          },
        ),
        barrierDismissible: false,
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// ❌ REMOVE AppBar if you want exact UI like screenshot
      appBar: CustomAppBar(
        title: "ViewMap",
        showNotification: true,
        showWishlist: false,
        showMenu: false,
        appBarBgColor: Colors.white,
      ),

      body: SafeArea(
        child: Stack(
          children: [
        
            /// 🔥 FULL SCREEN MAP
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: controller.initialPosition,
                zoom: 14,
              ),
              mapType: MapType.normal,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              padding: EdgeInsets.only(bottom: 220),
            ),
        
            /// 🔹 TOP GRADIENT
            Container(
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.transparent
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
        
            /// 🔥 TOP CARD
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _topCard(),
            ),
        
            /// 🔥 BOTTOM CARD
            _bottomCard(),
          ],
        ),
      ),
    );
  }

  /// 🔥 TOP CARD
  Widget _topCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Text(
            "Order Status",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(Icons.alt_route_outlined,
                    size: 16, color: Colors.blue),
                SizedBox(width: 6),
                Text(
                  "Timeline",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// 🔥 BOTTOM CARD
  Widget _bottomCard() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Obx(() {
        return Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),
            topRight: Radius.circular(20)),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 10)
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              /// DRIVER INFO
              Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage(
                        "https://randomuser.me/api/portraits/men/1.jpg"),
                  ),

                  SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.driverName.value,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),

                        SizedBox(height: 6),

                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.access_time,
                                  size: 14, color: Colors.blue),
                              SizedBox(width: 4),
                              Text(
                                controller.timeLeft.value,
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// CALL BUTTON
                  Container(
                    height: 44,
                    width: 44,
                    decoration: BoxDecoration(
                      color: Color(0xffE6DFC9),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.call),
                  )
                ],
              ),

              SizedBox(height: 12),

              /// OTP
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,

                children: [
                  Text("OTP", style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w400)),

                  SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: ["1", "4", "2", "0", "0", "0"]
                        .map((e) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 3),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(e),
                    ))
                        .toList(),
                  )
                ],
              ),

              SizedBox(height: 12),

              /// PICKUP
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Pick up",
                    style: TextStyle(color: Colors.grey)),
              ),

              SizedBox(height: 4),

              Text("Plot No. 97 near Soumya Sky Legend Apartment, Jaipur",
                style: TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        );
      }),
    );
  }
}