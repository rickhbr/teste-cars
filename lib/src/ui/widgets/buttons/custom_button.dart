import 'package:flutter/material.dart';
import 'package:teste_cars/src/constants/colors.dart';
import 'package:teste_cars/src/constants/mixins/screen_utils.dart';
import 'package:teste_cars/src/ui/widgets/text/custom_text.dart';

class CustomButton extends StatelessWidget with ScreenUtilityMixin {
  final void Function()? onTap;
  final String text;
  final Color? colorButton;
  final double? height;
  final double? width;
  const CustomButton(
      {super.key,
      this.onTap,
      required this.text,
      this.colorButton,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? MediaQuery.of(context).size.width * 0.95,
        height: height ?? setHeight(45),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: colorButton ?? CustomColors.blackColor),
        child: Center(
          child: CustomText(
            text: text,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
