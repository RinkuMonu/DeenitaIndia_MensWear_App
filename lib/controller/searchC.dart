import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SearchC extends GetxController {

  // ── Text Controller ───────────────────────────────────
  final searchController = TextEditingController();

  // ── Speech to Text ────────────────────────────────────
  final stt.SpeechToText _speech = stt.SpeechToText();
  var isListening    = false.obs;   // mic active
  var isSpeechReady  = false.obs;   // speech engine ready

  // ── States ────────────────────────────────────────────
  var recentSearch   = true.obs;
  var searchQuery    = ''.obs;
  var isLoading      = false.obs;
  var hasResults     = true.obs;

  // ── Recent Search List ────────────────────────────────
  var recentList = <String>[
    'Jeans',
    'Casual clothes',
    'V-neck tshirt',
    'Winter clothes',
  ].obs;

  // ── Search Results List ───────────────────────────────
  var searchResults = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initSpeech();

    // ── Listen to text field changes ────────────────────
    searchController.addListener(() {
      final query = searchController.text.trim();
      searchQuery.value = query;

      if (query.isEmpty) {
        recentSearch.value = true;
        searchResults.clear();
        hasResults.value = true;
      } else {
        recentSearch.value = false;
        _onSearch(query);
      }
    });
  }

  // ── Initialize Speech Engine ──────────────────────────
  Future<void> _initSpeech() async {
    isSpeechReady.value = await _speech.initialize(
      onError: (error) {
        isListening.value = false;
        Get.snackbar(
          'Error',
          'Speech recognition error: ${error.errorMsg}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade100,
          colorText: Colors.red.shade800,
        );
      },
      onStatus: (status) {
        // ── Auto stop when speech ends ──────────────────
        if (status == 'done' || status == 'notListening') {
          isListening.value = false;
        }
      },
    );
  }

  // ── Start / Stop Listening ────────────────────────────
  Future<void> toggleListening() async {
    if (!isSpeechReady.value) {
      Get.snackbar(
        'Unavailable',
        'Speech recognition is not available on this device',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (isListening.value) {
      // ── Stop listening ──────────────────────────────
      await _speech.stop();
      isListening.value = false;
    } else {
      // ── Start listening ─────────────────────────────
      isListening.value = true;
      await _speech.listen(
        onResult: (result) {
          final words = result.recognizedWords;
          searchController.text = words;
          searchController.selection = TextSelection.fromPosition(
            TextPosition(offset: words.length), // ← cursor at end
          );
          searchQuery.value = words;

          // ── Auto search when speech finalizes ────────
          if (result.finalResult && words.isNotEmpty) {
            isListening.value = false;
            recentSearch.value = false;
            _onSearch(words);
          }
        },
        listenFor: const Duration(seconds: 30),    // max listen duration
        pauseFor: const Duration(seconds: 3),      // stop after 3s silence
        partialResults: true,                      // show words while speaking
        localeId: 'en_US',                         // change to your locale
        cancelOnError: true,
      );
    }
  }

  // ── Search Logic (replace with your API call) ─────────
  void _onSearch(String query) {
    isLoading.value = true;

    Future.delayed(const Duration(milliseconds: 400), () {
      final mock = [
        {'image': 'assets/images/shirt.png', 'name': 'Polo', 'subtitle': 'BROWN T-SHIRT'},
        {'image': 'assets/images/shirt.png', 'name': 'Polo', 'subtitle': 'BLUE T-SHIRT'},
        {'image': 'assets/images/shirt.png', 'name': 'Polo', 'subtitle': 'WHITE T-SHIRT'},
      ];

      final filtered = mock
          .where((item) =>
      item['name']!.toLowerCase().contains(query.toLowerCase()) ||
          item['subtitle']!.toLowerCase().contains(query.toLowerCase()))
          .toList();

      searchResults.assignAll(filtered);
      hasResults.value = filtered.isNotEmpty;
      isLoading.value = false;
    });
  }

  // ── Recent helpers ────────────────────────────────────
  void addToRecent(String query) {
    if (query.isEmpty) return;
    recentList.remove(query);
    recentList.insert(0, query);
    if (recentList.length > 10) recentList.removeLast();
  }

  void removeRecent(int index) {
    recentList.removeAt(index);
    if (recentList.isEmpty) recentSearch.value = false;
  }

  void clearAllRecent() {
    recentList.clear();
    recentSearch.value = false;
  }

  void selectRecent(String text) {
    searchController.text = text;
    searchQuery.value = text;
    recentSearch.value = false;
    _onSearch(text);
  }

  @override
  void onClose() {
    _speech.stop();
    searchController.dispose();
    super.onClose();
  }
}