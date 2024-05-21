import 'dart:convert';

import 'package:fitness_dashboard_ui/const/constant.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SummaryWidget extends StatelessWidget {
  const SummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: cardBackgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 300),
            FutureBuilder(
                future: get_data(),
                builder: (context, AsyncSnapshot snapshot) {
                  double total = double.parse(snapshot.data['canceled']) +
                      double.parse(snapshot.data['not_canceled']);
                  double canceled =
                      double.parse(snapshot.data['canceled']) / total * 360;
                  double not_canceled =
                      double.parse(snapshot.data['not_canceled']) / total * 360;
                  if (snapshot.hasData) {
                    return InkWell(
                      child: Container(
                        height: 1,
                        width: 1,
                        child: PieChart(PieChartData(
                          startDegreeOffset: 200,
                          sectionsSpace: 0,
                          centerSpaceRadius: 50,
                          sections: [
                            PieChartSectionData(
                              titleStyle: TextStyle(color: Colors.white),
                              value: canceled,
                              color: Colors.red[400],
                              radius: 20,
                              showTitle: false,
                            ),
                            PieChartSectionData(
                                titleStyle: TextStyle(color: Colors.white),
                                value: not_canceled,
                                color: Colors.green[400],
                                radius: 20,
                                showTitle: false),
                            /*  PieChartSectionData(
                              titleStyle: TextStyle(color: Colors.white),
                              value: canceled + not_canceled,
                              color: Colors.grey.shade400,
                              radius: 20,
                              showTitle: false,
                            ), */
                          ],
                        )),
                      ),
                    );
                  }
                  return Container();
                }),
            SizedBox(height: 100),
            Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.red[400]),
                ),
                Text("  Represent Canceled lectures",
                    style: TextStyle(color: Colors.white))
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.green[400])),
                Text("  Represent Lectures taught",
                    style: TextStyle(color: Colors.white))
              ],
            ),
            /*  SizedBox(height: 20),
            //Chart(),
            Text(
              'Summary',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            SummaryDetails(),
            SizedBox(height: 40),
           // Scheduled(), */
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
}
