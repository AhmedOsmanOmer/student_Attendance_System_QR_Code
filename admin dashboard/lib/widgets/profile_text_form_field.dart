// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  final String hint;
  final bool isObsec;
  bool readOnly;
  TextEditingController controller;
  ProfileTextField(
      {super.key,
      required this.hint,
      required this.isObsec,
      required this.readOnly,
      required this.controller
      });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      style: TextStyle(color: Colors.white),
      obscureText: isObsec,
      decoration: InputDecoration(
        hintStyle: TextStyle(fontSize: 13),
        contentPadding: EdgeInsets.all(8),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
