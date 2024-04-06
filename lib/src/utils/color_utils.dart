import 'package:flutter/material.dart';

class ColorUtils {
  static final Map<String, Color> _colorMap = {
    "BEGE": Colors.orangeAccent.withOpacity(0.3),
    "AZUL": Colors.blue,
    "VERMELHO": Colors.red,
    "AMARELO": Colors.yellow,
    "VERDE": Colors.green,
    "ROXO": Colors.purple,
    "LARANJA": Colors.orange,
    "CINZA": Colors.grey,
    "MARROM": Colors.brown,
    "PRETO": Colors.black,
    "BRANCO": Colors.grey.shade200,
  };

  static Color getColorFromString(String colorString) {
    return _colorMap[colorString.toUpperCase()] ?? Colors.grey;
  }
}
