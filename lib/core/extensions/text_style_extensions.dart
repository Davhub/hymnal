import 'package:flutter/material.dart';

extension TextStyleExtensions on TextStyle {
  TextStyle get primary => copyWith(color: Colors.black);
  TextStyle get secondary => copyWith(color: Colors.grey[800]);
  TextStyle get tertiary => copyWith(color: Colors.grey[600]);
  
  TextStyle withColor(Color color) => copyWith(color: color);
  TextStyle withWeight(FontWeight weight) => copyWith(fontWeight: weight);
  TextStyle withSize(double size) => copyWith(fontSize: size);
}