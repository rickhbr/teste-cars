import 'package:flutter/material.dart';
import 'package:teste_cars/src/constants/mixins/screen_utils.dart';
import 'package:teste_cars/src/utils/color_utils.dart';

class CustomBoxColor extends StatelessWidget with ScreenUtilityMixin {
  final String color;
  const CustomBoxColor({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: setWidth(60),
      height: setHeight(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black, width: 0.5),
        color: ColorUtils.getColorFromString(color),
      ),
    );
  }
}
