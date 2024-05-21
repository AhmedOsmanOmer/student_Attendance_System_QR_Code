import 'dart:async';
import 'dart:convert';
import 'package:fitness_dashboard_ui/const/constant.dart';
import 'package:fitness_dashboard_ui/util/responsive.dart';
import 'package:fitness_dashboard_ui/widgets/activity_details_card.dart';
import 'package:fitness_dashboard_ui/widgets/header_widget.dart';
import 'package:fitness_dashboard_ui/widgets/summary_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({super.key});

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  String formattedTime = DateFormat('hh:mm').format(DateTime.now());
  String dateFormatTime = DateFormat('yyyy-MM-dd').format(DateTime.now());
  late Timer _timer;
/*   int? all_Lectures;
  int? cancleled;
  int? not_cancleled; */

  /* getdata() async {
    var request = await http.post(
        Uri.parse('http://localhost/attendance_system/home_data.php'),
        body: {'id': pref.getString('id'), 'subject': 'HCI'});
    var response = json.decode(request.body);
    if (response['status'] == 'success') {
      setState(() {
        all_Lectures = int.parse(response['data'][1]);
        not_cancleled = int.parse(response['data2'][1]);
        cancleled = int.parse(response['data3'][1]);
      });
      print(
          "$all_Lectures ============= $cancleled =================== $not_cancleled");
    }
  }
 */
  @override
  void initState() {
    get_data();
    super.initState();
    _timer =
        Timer.periodic(const Duration(milliseconds: 500), (timer) => _update());
  }

  void _update() {
    setState(() {
      formattedTime = DateFormat('hh:mm').format(DateTime.now());
      dateFormatTime = DateFormat('yyyy-MM-dd').format(DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const HeaderWidget(),
            const SizedBox(height: 18),
            ActivityDetailsCard(text: '$dateFormatTime  $formattedTime'),
            SizedBox(height: 20),
            Text(
              "This Table Shows a report for all taught and canceled",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 10),
            Center(
              child: SingleChildScrollView(
                child: FutureBuilder(
                  future: get_data(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context)
                            .size
                            .height, // Use full screen width
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: cardBackgroundColor,
                        ),
                        alignment: Alignment.topCenter,
                        child: DataTable(
                          columns: [
                            DataColumn(
                              label: Text(
                                "Subject",
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: primaryColor,
                                ),
                              ),
                              numeric: false,
                              tooltip: "Subject",
                            ),
                            DataColumn(
                              label: Text(
                                "Date",
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: primaryColor,
                                ),
                              ),
                              numeric: false,
                              tooltip: "Date",
                            ),
                            DataColumn(
                              label: Text(
                                "Time",
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: primaryColor,
                                ),
                              ),
                              numeric: false,
                              tooltip: "Time",
                            ),
                            DataColumn(
                              label: Text(
                                "Class",
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: primaryColor,
                                ),
                              ),
                              numeric: false,
                              tooltip: "Class",
                            ),
                          ],
                          rows: List.generate(
                            snapshot.data['data'].length,
                            (index) => getDataRow(
                              index,
                              snapshot.data['data'],
                            ),
                          ),
                          showBottomBorder: true,
                        ),
                      );
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
                              child: Text(
                                'No Data Found... ',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            if (Responsive.isTablet(context)) const SummaryWidget(),
          ],
        ),
      ),
    );
  }

  get_data() async {
    var request = await http.post(
      Uri.parse('http://localhost/attendance_system/home_data.php'),
      body: {'id': '1'},
    );
    var response = json.decode(request.body);
    print(response); // Print the response to verify its structure
    return response;
  }

  DataRow getDataRow(int index, List<dynamic> data) {
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(
          data[index]['subject'],
          style: TextStyle(color: Colors.white),
        )), //add name of your columns here
        DataCell(Text(
          "${data[index]['date']}",
          style: TextStyle(color: Colors.white),
        )),
        DataCell(Text(
          "${data[index]['time']}",
          style: TextStyle(
              color: data[index]['time'] == "canceled"
                  ? Colors.red
                  : Colors.white),
        )),
        DataCell(Text(
          "${data[index]['class']}",
          style: TextStyle(color: Colors.white),
        )),
      ],
    );
  }

  /*  Container(
            height: 1,
            width: 1,
            child: PieChart(PieChartData(
              startDegreeOffset: 200,
              sectionsSpace: 0,
              centerSpaceRadius: 50,
              sections: [
                PieChartSectionData(
                  value: 99,
                  color: Colors.greenAccent,
                  radius: 30,
                  showTitle: false,
                ),
                PieChartSectionData(
                    value: 1,
                    color: Colors.blue.shade900,
                    radius: 25,
                    showTitle: true,
                    title: 'title 1'),
                PieChartSectionData(
                  value: 20,
                  color: Colors.grey.shade400,
                  radius: 20,
                  showTitle: false,
                ),
              ],
            )),
          ),
          SizedBox(height: 200),
          Container(
            height: 1,
            width: 1,
            child: PieChart(PieChartData(
              startDegreeOffset: 250,
              sectionsSpace: 0,
              centerSpaceRadius: 50,
              sections: [
                PieChartSectionData(
                  value: 45,
                  color: Colors.greenAccent,
                  radius: 30,
                  showTitle: false,
                ),
                PieChartSectionData(
                  value: 35,
                  color: Colors.blue.shade900,
                  radius: 25,
                  showTitle: false,
                ),
                PieChartSectionData(
                  value: 20,
                  color: Colors.grey.shade400,
                  radius: 20,
                  showTitle: false,
                ),
              ],
            )),
          ), */
  //const LineChartCard(),
  //const SizedBox(height: 18),
  //const BarGraphCard(),
  //const SizedBox(height: 18),
}
