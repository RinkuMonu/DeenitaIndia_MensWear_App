import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController{
  final LatLng initialPosition = LatLng(28.6139, 77.2090);
  var driverName = "Tinku Yadav".obs;
  var timeLeft = "05:00 left".obs;
}
