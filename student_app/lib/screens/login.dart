// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:student_app/contant.dart';
import 'package:student_app/main.dart';
import 'package:student_app/screens/home.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController student_id = TextEditingController();
  TextEditingController password = TextEditingController();
  final FocusNode _idFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _isLoading = false;
  bool _isIdFocused = false;
  bool _isPasswordFocused = false;

  @override
  void initState() {
    super.initState();
    _idFocusNode.addListener(() {
      setState(() {
        _isIdFocused = _idFocusNode.hasFocus;
      });
    });
    _passwordFocusNode.addListener(() {
      setState(() {
        _isPasswordFocused = _passwordFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _idFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              Center(
                child: Image.asset(
                  "assets/anime.gif",
                  height: 200.0,
                  width: 200.0,
                  scale: 0.5,
                  filterQuality: FilterQuality.high,
                ),
              ),
              const SizedBox(height: 50),
              const Text('LOGIN',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              const Text('Please Sign in to continue',
                  style: TextStyle(
                    color: Colors.grey,
                  )),
              const SizedBox(height: 30),
              TextFormField(
                controller: student_id,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                focusNode: _idFocusNode,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.numbers,
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                  filled: _isIdFocused ? true : false,
                  fillColor: _isIdFocused ? fillColor : null,
                  labelText: 'Your ID',
                  labelStyle: const TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: backgroundColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 25),
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                focusNode: _passwordFocusNode,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                  filled: _isPasswordFocused ? true : false,
                  fillColor: _isPasswordFocused ? fillColor : null,
                  labelText: 'Password',
                  labelStyle: const TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: backgroundColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 25),
                ),
              ),
              const SizedBox(height: 50),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (builder) => const Home()));
                },
                child: Center(
                  child: InkWell(
                    onTap: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      var request = await http.post(
                          Uri.parse(
                              'http://192.168.70.123/attendance_system/student_login.php'),
                          body: {
                            'id': student_id.text
                            //'password': password.text
                          });
                      var response = json.decode(request.body);
                      if (response['status'] == 'success') {
                        setState(() {
                          _isLoading = false;
                        });
                        pref.setString('id', response['data']['id']);
                        pref.setString('name', response['data']['name']);
                        pref.setString('class', response['data']['class']);
                        pref.setString(
                            'index', response['data']['index_number']);
                        pref.setString('url', response['data']['image_url']);
                        pref.setString('qr_value', response['system_data']['qr_value']);

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (builder) => const Home()));
                      }
                      if (response['status'] == 'system_off') {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Alert'),
                              content: const Text('system off'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                      if (response['status'] == 'fail_id') {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Alert'),
                              content:
                                  const Text('Username or Password incorrect'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 70,
                      width: 250,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: buttonColor),
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            color: backgroundColor,
                            fontSize: 20,
                            fontFamily: 'NotoSansBold'),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: <TextSpan>[
                      const TextSpan(
                          text:
                              'IF You have any problem with login please\n \n',
                          style: TextStyle(color: Colors.grey)),
                      TextSpan(
                          text: ' contact the admin',
                          style: TextStyle(color: buttonColor)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
