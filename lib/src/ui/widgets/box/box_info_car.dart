import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teste_cars/src/constants/mixins/screen_utils.dart';
import 'package:teste_cars/src/ui/widgets/text/custom_text.dart';

class BoxInfoCar extends StatelessWidget with ScreenUtilityMixin {
  final String icon;
  final String title;
  final String value;
  const BoxInfoCar(
      {super.key,
      required this.icon,
      required this.title,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: setWidth(90),
      height: setHeight(80),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(icon, width: setWidth(30), height: setHeight(30)),
          CustomText(
            text: title,
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: setFontSize(12.0),
          ),
          CustomText(
            text: value,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: setFontSize(12.0),
          ),
        ],
      ),
    );
  }
}
