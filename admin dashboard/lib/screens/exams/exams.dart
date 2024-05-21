import 'dart:convert';
import 'package:fitness_dashboard_ui/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Exams extends StatefulWidget {
  const Exams({super.key});

  @override
  State<Exams> createState() => _ExamsState();
}

class _ExamsState extends State<Exams> {
  String name = '';
  String class_ = '';
  String index = '';
  String student_id = '';
  String url = '';
  String payment = '';
  bool isFounded = false;
  TextEditingController id = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                  color: cardBackgroundColor,
                  borderRadius: BorderRadius.circular(15)),
              margin: EdgeInsets.only(left: 50, right: 50, top: 70),
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
                          payment = response['data']['payment'];
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
                    padding: EdgeInsets.all(50),
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
                                RichText(
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
                                RichText(
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
                                RichText(
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
                                RichText(
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
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Payment Status : ',
                                          style: TextStyle(
                                              color: selectionColor,
                                              fontSize: 20)),
                                      TextSpan(
                                          text: payment,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20)),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
