
import 'package:flutter/material.dart';

class Constants {
  final Color primaryColor = const Color(0xff1E70FF);
  final Color secondaryColor = const Color(0xff90B2F8);

  LinearGradient get linearGradientBlue => LinearGradient(
    colors: [primaryColor, secondaryColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  Shader get shader => LinearGradient(
    colors: <Color>[Color(0xffADD8E6), Color(0xffB0E0E6)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  Color get greyColor => Colors.grey;

  static String getWeatherText(String conditionText) {
    switch (conditionText.toLowerCase()) {
      case 'clear':
        return 'Clear Sky';
      case 'sunny':
        return 'Sunny';
      case 'partly cloudy':
        return 'Partly Cloudy';
      case 'cloudy':
        return 'Cloudy';
      case 'rain':
        return 'Rainy';
      case 'snow':
        return 'Snowy';
      case 'thunderstorm':
        return 'Thunderstorm';
      case 'light rain':
        return 'Light Rain';
      case 'rain with thunder':
        return 'Rain with Thunder';
      default:
        return 'clear'; // Default or unknown condition
    }
  }
}
