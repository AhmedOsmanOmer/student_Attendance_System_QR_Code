import 'dart:convert';
import 'package:fitness_dashboard_ui/const/constant.dart';
import 'package:fitness_dashboard_ui/main.dart';
import 'package:fitness_dashboard_ui/screens/attendance/attendance_table.dart';
import 'package:fitness_dashboard_ui/screens/qr_code/qr_code.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Attendance extends StatefulWidget {
  const Attendance({super.key});
  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  String class_id = '';
  String subject_id = '';
  String date = '';
  String time = '';
  TextEditingController qr_value = TextEditingController();
  DateTime? dateTime;
  String? selectedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Please fill the Information bw to perform attendance",
              style: TextStyle(color: selectionColor, fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 500,
              child: DropdownSearch<String>(
                popupProps: PopupProps.menu(
                  showSelectedItems: true,
                  fit: FlexFit.loose,
                  //disabledItemFn: (String s) => s.startsWith('I'),
                ),
                items: ['IT1', 'IT2', 'IT3', 'IT4', 'CS1', 'CS2', 'CS4'],
                dropdownDecoratorProps: DropDownDecoratorProps(
                  baseStyle: TextStyle(color: Colors.white),
                  dropdownSearchDecoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      labelText: "Class",
                      filled: true,
                      fillColor: cardBackgroundColor),
                ),
                onChanged: (val) {
                  setState(() {
                    class_id = val!;
                  });
                },
                selectedItem: 'IT 1',
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 500,
              child: DropdownSearch<String>(
                popupProps: PopupProps.menu(
                  showSelectedItems: true,
                  fit: FlexFit.loose,
                  //disabledItemFn: (String s) => s.startsWith('I'),
                ),
                items: ["HCI", "Java PL", "Math"],
                dropdownDecoratorProps: DropDownDecoratorProps(
                  baseStyle: TextStyle(color: Colors.white),
                  dropdownSearchDecoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      labelText: "Subject",
                      filled: true,
                      fillColor: cardBackgroundColor),
                ),
                onChanged: (val) {
                  setState(() {
                    subject_id = val!;
                  });
                },
                selectedItem: "Math",
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 500,
              child: DropdownSearch<String>(
                popupProps: PopupProps.menu(
                  showSelectedItems: true,
                  fit: FlexFit.loose,
                  //disabledItemFn: (String s) => s.startsWith('I'),
                ),
                items: ["08:00 - 10:00", "10:00 - 12:00", "12:00 - 02:00"],
                dropdownDecoratorProps: DropDownDecoratorProps(
                  baseStyle: TextStyle(color: Colors.white),
                  dropdownSearchDecoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      labelText: "Time",
                      filled: true,
                      fillColor: cardBackgroundColor),
                ),
                onChanged: (val) {
                  setState(() {
                    time = val!;
                  });
                },
                selectedItem: "08:00 - 10:00",
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                color: cardBackgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              width: 500,
              child: TextFormField(
                controller: qr_value,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 13),
                  contentPadding: EdgeInsets.all(8),
                  label: Text(
                    'QR Code Value',
                    style: TextStyle(color: Colors.white),
                  ),
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
              ),
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () async {
                dateTime = (await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030)))!;
                /* .then((value) {
                    setState(() {
                      selectedDate = "${value!.year}/${value.month}/${value.day}";
                    });
                    return selectedDate;
                  }); */
                setState(() {
                  selectedDate =
                      "${dateTime!.day}/${dateTime!.month}/${dateTime!.year}";
                });
              },
              child: Container(
                padding: EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                height: 50,
                width: 500,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                  color: cardBackgroundColor,
                ),
                child: Text(
                  selectedDate!,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    print(
                        "${pref.getString('id')} ******* $class_id ****** ${qr_value.text}  *** ${subject_id}  ********* ${time} ********  ${selectedDate} ");
                    try {
                      var request = await http.post(
                          Uri.parse(
                              'http://localhost/attendance_system/run_system.php'),
                          body: {
                            'teacher_id': pref.getString('id'),
                            'class': class_id,
                            'qr_value': qr_value.text,
                            'subject': subject_id,
                            'time': time,
                            'date': selectedDate,
                          });
                      var response = json.decode(request.body);
                      if (response['status'] == 'success') {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (builder) => QrCode(val: qr_value.text)));
                      } else if (response['status'] == 'system_on') {
                        print("system _on Success");

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (builder) => QrCode(val: qr_value.text)));
                      } else {
                        print("EEELLLSSEE");
                      }
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: selectionColor),
                    child: const Text(
                      "Generate QR Code ",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(width: 50),
                InkWell(
                  onTap: () async {
                    var request = await http.post(
                        Uri.parse(
                            'http://localhost/attendance_system/cancel_lecture.php'),
                        body: {
                          'teacher_id': pref.getString('id'),
                          'class': class_id,
                          'qr_value': qr_value.text,
                          'subject': subject_id,
                          'date': selectedDate,
                        });
                    var response = json.decode(request.body);
                    if (response['status'] == 'success') {
                      print("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
                    } else {
                      print("EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: selectionColor),
                    child: const Text(
                      "Cancel Lecture",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                /////
                ///
                ///
                ///
                ///
              },
              child: Container(
                width: 500,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: selectionColor),
                child: const Text(
                  "Approve Attendance",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (builder) => AttendanceTable(class_: class_id)));
              },
              child: Container(
                width: 500,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: selectionColor),
                child: const Text(
                  "Show Attendance",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
