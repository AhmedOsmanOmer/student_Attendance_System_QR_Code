import 'package:flutter/material.dart';
import 'package:student_app/contant.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:student_app/main.dart';
import 'package:student_app/screens/qr_scanning.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _expanded = false;

  void _toggleExpanded() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        GestureDetector(
          onTap: _toggleExpanded,
          child: Container(
            padding: const EdgeInsets.all(30),
            margin: const EdgeInsets.only(bottom: 30),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: fillColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 70.0,
                  backgroundImage: NetworkImage(pref.getString('url')!),
                ),
                const SizedBox(height: 10.0),
                Text(
                  pref.getString('name')!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'NotoSansBold',
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (_expanded)
                  Column(
                    children: [
                      const SizedBox(height: 20.0),
                      Column(
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'ID : ',
                                    style: TextStyle(
                                        color: buttonColor, fontSize: 20)),
                                TextSpan(
                                    text: '${pref.getString('id')!}\n',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 20)),
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
                                        color: buttonColor, fontSize: 20)),
                                TextSpan(
                                    text: '${pref.getString('class')!}\n',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 20)),
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
                                        color: buttonColor, fontSize: 20)),
                                TextSpan(
                                    text: pref.getString('index')!,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 20)),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                const SizedBox(height: 10.0),
                Icon(
                  _expanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: 30.0,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        const Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            "This Chart Display an evaluation of your attendance",
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 100),
        SizedBox(
          height: 200,
          width: 200,
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
        ),
        const SizedBox(height: 50),
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (builder) => const QrCodeScanningScreen()));
          },
          child: Center(
            child: Container(
              alignment: Alignment.center,
              height: 70,
              width: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: buttonColor),
              child: Text(
                "SCAN QR CODE",
                style: TextStyle(
                    color: backgroundColor,
                    fontSize: 20,
                    fontFamily:
                        'NotoSansBold' /* fontWeight: FontWeight.bold */),
              ),
            ),
          ),
        ),
      ]),
    ));
  }
}
