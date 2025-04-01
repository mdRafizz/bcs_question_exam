import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
    this.label,
    this.controller, {
    super.key,
    this.keyboardType = TextInputType.text,
  });

  final String label;
  final RxString controller;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        child: TextField(
          onChanged: (value) => controller.value = value,
          keyboardType: keyboardType,
          style: TextStyle(fontFamily: 'bn'),
          decoration: InputDecoration(
            labelStyle: TextStyle(fontFamily: 'ferdoka'),
            hintStyle: TextStyle(fontFamily: 'bn'),
            labelText: label,
            border: InputBorder.none,
            filled: true,
            fillColor: const Color(0xfff8f9fa),
          ),
        ),
      ),
    );
  }
}
