import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teste_cars/src/constants/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final void Function(String?) onSaved;
  final String? Function(String?) validator;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.onSaved,
    required this.validator,
    this.controller,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      inputFormatters: inputFormatters,
      style: TextStyle(color: CustomColors.terciaryColor),
      decoration: InputDecoration(
        hintStyle: TextStyle(color: CustomColors.white),
        labelStyle: TextStyle(color: CustomColors.white),
        labelText: labelText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: CustomColors.white, width: 2),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
      ),
      onSaved: onSaved,
      validator: validator,
    );
  }
}
