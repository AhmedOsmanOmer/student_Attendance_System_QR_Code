// ignore_for_file: must_be_immutable

import 'package:fitness_dashboard_ui/screens/attendance/attendance.dart';
import 'package:fitness_dashboard_ui/screens/exams/exams.dart';
import 'package:fitness_dashboard_ui/screens/login/login.dart';
import 'package:fitness_dashboard_ui/screens/profile/profile.dart';
import 'package:fitness_dashboard_ui/screens/special_cases/special_cases.dart';
import 'package:fitness_dashboard_ui/util/responsive.dart';
import 'package:fitness_dashboard_ui/widgets/dashboard_widget.dart';
import 'package:fitness_dashboard_ui/widgets/side_menu_widget.dart';
import 'package:fitness_dashboard_ui/widgets/summary_widget.dart';
import 'package:flutter/material.dart';

int pageIndex = 0;

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> homeWidgets = [
    DashboardWidget(),
    Profile(),
    Attendance(),
    SpecialCases(),
    Exams(),
    Login()
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      drawer: !isDesktop
          ? SizedBox(
              width: 250,
              child: Column(
                children: [
                  SideMenuWidget(onItemSelected: _onMenuItemSelected),
                ],
              ),
            )
          : null,
      endDrawer: Responsive.isMobile(context)
          ? SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: const SummaryWidget(),
            )
          : null,
      body: SafeArea(
        child: Row(
          children: [
            if (isDesktop)
              Expanded(
                flex: 3,
                child: SizedBox(
                  child: SideMenuWidget(onItemSelected: _onMenuItemSelected),
                ),
              ),
            Expanded(
              flex: 8,
              child: homeWidgets[pageIndex],
            ),
            if (isDesktop)
              Expanded(
                flex: 3,
                child: SummaryWidget(),
              ),
          ],
        ),
      ),
    );
  }

  void _onMenuItemSelected(int index) {
    setState(() {
      pageIndex = index;
    });
  }
}
