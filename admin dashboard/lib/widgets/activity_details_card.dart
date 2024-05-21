import 'package:fitness_dashboard_ui/const/constant.dart';
import 'package:fitness_dashboard_ui/data/attendance_details.dart';
import 'package:flutter/material.dart';

class ActivityDetailsCard extends StatelessWidget {
  final String text;
  const ActivityDetailsCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final attendanceDetails = AttendanceDetails();

    return Container(
      decoration: BoxDecoration(
          color: cardBackgroundColor, borderRadius: BorderRadius.circular(15)),
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(color: primaryColor, fontSize: 29),
          ),
          Text(attendanceDetails.attendanceData[0].title,
              style: TextStyle(color: selectionColor))
        ],
      ),
    ); /* GridView.builder(
      itemCount: attendanceDetails.attendanceData.length,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Responsive.isMobile(context) ? 2 : 4,
        crossAxisSpacing: Responsive.isMobile(context) ? 12 : 15,
        mainAxisSpacing: 12.0,
      ),
      itemBuilder: (context, index) => CustomCard(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              attendanceDetails.attendanceData[index].icon,
              width: 40,
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 4),
              child: Text(
                textAlign: TextAlign.center,
                attendanceDetails.attendanceData[index].value,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              attendanceDetails.attendanceData[index].title,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    ); */
  }
}
