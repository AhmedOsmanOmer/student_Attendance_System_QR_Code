import 'dart:convert';
import 'package:fitness_dashboard_ui/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SpecialCases extends StatefulWidget {
  const SpecialCases({super.key});

  @override
  State<SpecialCases> createState() => _SpecialCasesState();
}

class _SpecialCasesState extends State<SpecialCases> {
  String name = '';
  String class_ = '';
  String index = '';
  String student_id = '';
  String url = '';
  bool isFounded = false;
  TextEditingController id = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: Text(
                  "If any Student faced a problem .enter his id then you can confirm the attendance",
                  style: TextStyle(color: Colors.white, fontSize: 15)),
            ),
            Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                  color: cardBackgroundColor,
                  borderRadius: BorderRadius.circular(15)),
              margin: EdgeInsets.only(left: 50, right: 50),
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: id,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 10, vertical: 19),
                        prefixIcon: Icon(Icons.numbers),
                        label: Text(
                          'Enter Student ID',
                          style: TextStyle(color: Colors.grey),
                        ),
                        filled: true,
                        fillColor: backgroundColor,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20))),
                  )),
                  SizedBox(width: 20),
                  InkWell(
                    onTap: () async {
                      var request = await http.post(
                          Uri.parse(
                              'http://localhost/attendance_system/get_student_data.php'),
                          body: {'id': id.text});
                      var response = json.decode(request.body);
                      if (response['status'] == 'success') {
                        setState(() {
                          name = response['data']['name'];
                          class_ = response['data']['class'];
                          index = response['data']['index_number'];
                          student_id = response['data']['id'];
                          url = response['data']['image_url'];
                          isFounded = true;
                        });
                      } else {
                        setState(() {
                          isFounded = false;
                        });
                      }
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: selectionColor),
                      child: const Text(
                        "Search",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            isFounded
                ? Container(
                    padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                    width: 700,
                    height: 420,
                    decoration: BoxDecoration(
                        color: cardBackgroundColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(url),
                              radius: 80,
                              /* child: Image.network(
                                url,
                                fit: BoxFit.contain,
                              ), */
                            ),
                            SizedBox(width: 50),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 400,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: backgroundColor),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'Student ID : ',
                                            style: TextStyle(
                                                color: selectionColor,
                                                fontSize: 20)),
                                        TextSpan(
                                            text: student_id,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20)),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width: 400,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: backgroundColor),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'Name : ',
                                            style: TextStyle(
                                                color: selectionColor,
                                                fontSize: 20)),
                                        TextSpan(
                                            text: name,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20)),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width: 400,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: backgroundColor),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'Class : ',
                                            style: TextStyle(
                                                color: selectionColor,
                                                fontSize: 20)),
                                        TextSpan(
                                            text: class_,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20)),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width: 400,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: backgroundColor),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'Index Number : ',
                                            style: TextStyle(
                                                color: selectionColor,
                                                fontSize: 20)),
                                        TextSpan(
                                            text: index,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 30),
                        InkWell(
                          onTap: () async {
                            var request = await http.post(
                                Uri.parse(
                                    'http://localhost/attendance_system/make_attendance_admin.php'),
                                body: {'id': id.text, 'class': class_});
                            var response = json.decode(request.body);
                            if (response['status'] == 'success') {
                              print(
                                  "DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDone");
                            }
                            if (response['status'] == 'twice_attendence') {
                              print(
                                  "twice_attendencetwice_attendencetwice_attendence");
                            }
                            if (response['status'] == 'system_off') {
                              print("system_offsystem_offsystem_offsystem_off");
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 150),
                            width: 300,
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: selectionColor),
                            child: const Text(
                              "Make Attendance",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : Center(
                    child: Container(
                      child: Text(
                        "Student Not Found make sure the ID is Correct",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
