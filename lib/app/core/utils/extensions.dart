import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension PercentSized on double {
  double get hp => (Get.height * (this / 100));
  double get wp => (Get.width * (this / 100));
}

extension ResponsiveText on double {
  double get sp => (Get.width / 100) * (this / 3);
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    // If the input hexString has 6 or 7 characters, add 'ff' to the buffer, representing full opacity.
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');

    // Remove the '#' character from the input hexString and add it to the buffer.

    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
