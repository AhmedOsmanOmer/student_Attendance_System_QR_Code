import 'package:fitness_dashboard_ui/screens/login/widget/login_form.dart';
import 'package:fitness_dashboard_ui/screens/login/widget/login_interface.dart';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        const LoginForm(),
        /* Flexible(
            child: Image.asset(
          'assets/images/bg.png',
          fit: BoxFit.fill,
          height: double.infinity,
          width: double.infinity,
        )) */
        LoginInterface()
      ],
    ));
  }
}
