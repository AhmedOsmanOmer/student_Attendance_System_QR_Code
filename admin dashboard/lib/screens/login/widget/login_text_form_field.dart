import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginTextFormField extends StatelessWidget {
  TextEditingController? controller;
  final String hintText;
  final Widget prefixIcon;
  final bool obscureText;
  LoginTextFormField(
      {super.key,
      this.controller,
      required this.hintText,
      required this.prefixIcon,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
          contentPadding: const EdgeInsetsDirectional.symmetric(
              horizontal: 10, vertical: 25),
          prefixIcon: prefixIcon,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          filled: true,
          fillColor: const Color.fromARGB(100, 240, 237, 255),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20))),
    );
  }
}
