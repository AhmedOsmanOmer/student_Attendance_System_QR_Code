import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_dashboard_ui/const/constant.dart';
import 'package:fitness_dashboard_ui/main.dart';
import 'package:fitness_dashboard_ui/widgets/helper.dart';
import 'package:fitness_dashboard_ui/widgets/profile_label_text.dart';
import 'package:fitness_dashboard_ui/widgets/profile_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController password_controller = TextEditingController();
  TextEditingController new_password_controller = TextEditingController();
  TextEditingController confirm_controller = TextEditingController();
  TextEditingController name_controller = TextEditingController();
  TextEditingController username_controller = TextEditingController();

  @override
  void initState() {
    name_controller.text = pref.getString('name')!;
    username_controller.text = pref.getString('username')!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl: pref.getString('url')!,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              ProfileLabelText(
                  text: "${pref.getString('name')!}\n",
                  fontSize: 15,
                  color: Colors.white,
                  isBold: false),
              ProfileLabelText(
                  text: pref.getString('role')!,
                  fontSize: 10,
                  color: Colors.white,
                  isBold: false),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileLabelText(
                        text: "User Information",
                        fontSize: 15,
                        color: Colors.grey,
                        isBold: true),
                    verticalSpace(20),
                    ProfileLabelText(
                        text: "Name",
                        fontSize: 15,
                        color: primaryColor,
                        isBold: false),
                    verticalSpace(10),
                    ProfileTextField(
                      controller: name_controller,
                      readOnly: true,
                      hint: 'Enter Your Name',
                      isObsec: false,
                    ),
                    verticalSpace(20),
                    ProfileLabelText(
                        text: "Username",
                        fontSize: 15,
                        color: primaryColor,
                        isBold: false),
                    verticalSpace(10),
                    ProfileTextField(
                      controller: username_controller,
                      readOnly: false,
                      hint: 'Enter Your Username',
                      isObsec: false,
                    ),
                    verticalSpace(20),
                    ProfileLabelText(
                        text: "Current Password",
                        fontSize: 15,
                        color: primaryColor,
                        isBold: false),
                    verticalSpace(10),
                    ProfileTextField(
                      controller: password_controller,
                      readOnly: false,
                      hint: 'Enter Your Current Password',
                      isObsec: true,
                    ),
                    verticalSpace(20),
                    ProfileLabelText(
                        text: "New Password",
                        fontSize: 15,
                        color: primaryColor,
                        isBold: false),
                    verticalSpace(10),
                    ProfileTextField(
                      controller: new_password_controller,
                      readOnly: false,
                      hint: 'Enter Your New Password',
                      isObsec: true,
                    ),
                    verticalSpace(20),
                    ProfileLabelText(
                        text: "Confirm New Password",
                        fontSize: 15,
                        color: primaryColor,
                        isBold: false),
                    verticalSpace(10),
                    ProfileTextField(
                      controller: confirm_controller,
                      readOnly: false,
                      hint: 'Confirm Your Current Password',
                      isObsec: true,
                    ),
                    verticalSpace(30),
                    InkWell(
                      onTap: () async {
                        if (new_password_controller.text ==
                            confirm_controller.text) {
                          var request = await http.post(
                              Uri.parse(
                                  'http://localhost/attendance_system/update_user_data.php'),
                              body: {
                                'id': pref.getString('id'),
                                'username': username_controller.text,
                                'password': password_controller.text,
                                'new_password': new_password_controller.text,
                              });
                          var response = json.decode(request.body);
                          if (response['status'] == 'success') {
                            setState(() {
                              username_controller.text =
                                  response['data']['username'];
                              print("Dooooone");
                            });
                          }
                        } else {
                          print(confirm_controller.text);
                          print(password_controller.text);
                          print("Not Match");
                        }
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: selectionColor),
                        child: const Text(
                          "Save",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
