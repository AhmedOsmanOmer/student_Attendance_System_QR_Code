import 'dart:convert';
import 'package:fitness_dashboard_ui/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AttendanceTable extends StatefulWidget {
  final String class_;
  const AttendanceTable({super.key, required this.class_});

  @override
  State<AttendanceTable> createState() => _AttendanceTableState();
}

class _AttendanceTableState extends State<AttendanceTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: CircleAvatar(
          child: Icon(Icons.arrow_back),
        ),
      ) ,
      body: Center(
        child: FutureBuilder(
          future: showAttendance(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              //controller.tableData = snapshot.data;
              if (snapshot.data!.length != 0) {
                return Container(
                    padding: const EdgeInsets.all(30),
                    width: 700,
                    height: 600,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: cardBackgroundColor),
                    alignment: Alignment.topCenter,
                    child: DataTable(
                      columns: [
                        DataColumn(
                          label: Text(
                            "ID",
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                            ),
                          ),
                          numeric: false,
                          tooltip: "ID",
                        ),
                        DataColumn(
                          label: Text(
                            "Name",
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                            ),
                          ),
                          numeric: false,
                          tooltip: "Name",
                        ),
                        DataColumn(
                          label: Text(
                            "Status",
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                            ),
                          ),
                          numeric: false,
                          tooltip: "#",
                        ),
                      ],
                      rows: List.generate(
                        snapshot.data['data'].length,
                        (index) => getDataRow(
                          index,
                          snapshot.data,
                        ),
                      ),
                      showBottomBorder: true,
                    ));
              } else {
                return Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      SizedBox(
                        // ignore: sort_child_properties_last
                        child: CircularProgressIndicator(),
                        width: 30,
                        height: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.all(40),
                        child: Text('No Data Found...'),
                      ),
                    ],
                  ),
                );
              }
            } else {
              return Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    SizedBox(
                      // ignore: sort_child_properties_last
                      child: CircularProgressIndicator(),
                      width: 30,
                      height: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.all(40),
                      child: Text('No Data Found...'),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  showAttendance() async {
    var request = await http.post(
        Uri.parse('http://localhost/attendance_system/show_attendance.php'),
        body: {
          'class': widget.class_,
        });
    var response = json.decode(request.body);
    if (response['status'] == 'success') {
      return response;
    }
  }

  DataRow getDataRow(index, data) {
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(
          data['data'][index]['id'],
          style: TextStyle(color: Colors.white),
        )), //add name of your columns here
        DataCell(Text(
          "${data['data'][index]['name']}",
          style: TextStyle(color: Colors.white),
        )),
        DataCell(data['data1'][index]['status'] == "1"
            ? const Icon(
                Icons.check_circle,
                color: Colors.white,
              ) //(Icons.check_circle)
            : const Icon(
                Icons.circle,
                color: cardBackgroundColor,
              ))
      ],
    );
  }
}
