import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationServices extends GetxService {
  /// Reactive values
  final RxDouble latitude = 0.0.obs;
  final RxDouble longitude = 0.0.obs;
  final RxString pinCode = ''.obs;
  final RxString address = ''.obs;

  final RxBool locationEnabled = false.obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  /// Initialize at app start
  Future<LocationServices> init() async {
    await fetchCurrentLocation();
    return this;
  }

  /// Main method to fetch location
  Future<void> fetchCurrentLocation() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // 1️⃣ Check service enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        locationEnabled.value = false;
        errorMessage.value = "Location services are disabled";
        return;
      }

      locationEnabled.value = true;

      // 2️⃣ Check permission
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        errorMessage.value = "Location permission denied";
        return;
      }

      if (permission == LocationPermission.deniedForever) {
        errorMessage.value =
        "Location permission permanently denied. Please enable from settings.";
        await Geolocator.openAppSettings();
        return;
      }

      // 3️⃣ Get location with timeout
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      latitude.value = position.latitude;
      longitude.value = position.longitude;

      await _resolveAddress(position.latitude, position.longitude);

    } catch (e) {
      errorMessage.value = "Failed to get location";
      print("Location Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Resolve pincode + address (single call)
  Future<void> _resolveAddress(double lat, double long) async {
    try {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(lat, long);

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;

        pinCode.value = place.postalCode ?? '';
        address.value =
        "${place.name ?? ''}, ${place.locality ?? ''}, ${place.administrativeArea ?? ''}";
      }
    } catch (e) {
      print("Geocoding Error: $e");
    }
  }

  /// Manual refresh
  Future<void> refreshLocation() async {
    await fetchCurrentLocation();
  }
}