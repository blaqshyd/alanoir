// ignore_for_file: camel_case_types, must_be_immutable

import 'package:flutter/material.dart';

class customTextField extends StatelessWidget {
  final String? Function(String?)? validator;
  final String? inputHint, inputLabel;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  bool? obscureText;

  customTextField({
    Key? key,
    this.inputHint,
    this.inputLabel,
    this.controller,
    this.validator,
    this.obscureText,
    required this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyFormField(
      keyboardType: keyboardType,
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      inputAction: TextInputAction.next,
      inputHint: inputHint,
      inputLabel: inputLabel,
      // inputFilled: true,
      // inputFillColor: Colors.grey[400],
      border: const OutlineInputBorder(

          // borderSide: BorderSide.none,
          ),
    );
  }
}
