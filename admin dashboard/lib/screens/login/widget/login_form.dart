import 'dart:convert';
import 'package:fitness_dashboard_ui/const/constant.dart';
import 'package:fitness_dashboard_ui/main.dart';
import 'package:fitness_dashboard_ui/screens/login/widget/login_text_form_field.dart';
import 'package:fitness_dashboard_ui/screens/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isLoading = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height,
      color: cardBackgroundColor,
      child: isLoading
          ? Center(child: CircularProgressIndicator())
          : Form(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 100.w),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "LOGIN",
                        style: TextStyle(
                            fontSize: 40.sp,
                            fontWeight: FontWeight.bold,
                            color: selectionColor),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      const Text(
                        "Please Login To Perform Attendance",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: selectionColor),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      LoginTextFormField(
                        controller: usernameController,
                        hintText: "Username",
                        obscureText: false,
                        prefixIcon: const Icon(Icons.person_2_outlined,
                            color: selectionColor),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      LoginTextFormField(
                        controller: passwordController,
                        hintText: "Password",
                        obscureText: true,
                        prefixIcon:
                            const Icon(Icons.lock, color: selectionColor),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      const Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "Forget Password",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: selectionColor),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      MaterialButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          var request = await http.post(
                              Uri.parse(
                                  'http://localhost/attendance_system/teacher_login.php'),
                              body: {
                                'username': usernameController.text,
                                'password': passwordController.text.toString()
                              });
                          var response = json.decode(request.body);
                          if (response['status'] == 'Success') {
                            setState(() {
                              isLoading = false;
                            });
                            pref.setString('id', response['data']['id']);
                            pref.setString('name', response['data']['name']);
                            pref.setString(
                                'username', response['data']['username']);
                            pref.setString('role', response['data']['role']);
                            pref.setString(
                                'url', response['data']['image_url']);
                            print(pref.getString('role'));

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (builder) => MainScreen()));
                          } else {
                            setState(() {
                              isLoading = false;
                            });
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Alert'),
                                  content:
                                      Text('Username or Password incorrect'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 200.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: selectionColor),
                          child: const Text(
                            "Login Now",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      )
                    ]),
              ),
            ),
    );
  }
}
