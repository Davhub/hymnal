import 'package:flutter/material.dart';
import 'package:dlgc_hymnal/core/services/settings_service.dart';

class TextSizeProvider extends ChangeNotifier {
  double _textSize = 16.0;

  double get textSize => _textSize;

  TextSizeProvider() {
    _loadTextSize();
  }

  void _loadTextSize() {
    _textSize = SettingsService.textSize;
    notifyListeners();
  }

  Future<void> updateTextSize(double newSize) async {
    _textSize = newSize;
    await SettingsService.setTextSize(newSize);
    notifyListeners();
  }

  // Helper methods to get scaled text sizes
  double get smallText => _textSize * 0.75;      // 12pt when base is 16pt
  double get mediumText => _textSize;            // 16pt base
  double get largeText => _textSize * 1.125;     // 18pt when base is 16pt
  double get titleText => _textSize * 1.25;      // 20pt when base is 16pt
  double get headingText => _textSize * 1.5;     // 24pt when base is 16pt
  double get verseText => _textSize * 1.0625;    // 17pt when base is 16pt (optimized for reading)
}