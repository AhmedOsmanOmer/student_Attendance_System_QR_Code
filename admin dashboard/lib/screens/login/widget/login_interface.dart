import 'package:fitness_dashboard_ui/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginInterface extends StatelessWidget {
  const LoginInterface({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Container(
        width: MediaQuery.of(context).size.width / 2,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                end: Alignment.topRight,
                begin: Alignment.bottomLeft,
                colors: [
              backgroundColor,
              cardBackgroundColor,
            ])),
        child: Image.asset("assets/images/rectangle.png"),
      ),
      Container(
        height: MediaQuery.of(context).size.height - 100,
        width: MediaQuery.of(context).size.width / 2 - 150,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(46.sp)),
      ),
      Positioned(
          top: 90,
          left: 90,
          child: SizedBox(
            width: 400.w,
            height: 400.h,
            child: Text(
              "Attendance Managemet System",
              style: TextStyle(
                  fontSize: 40.sp, color: Colors.white, fontFamily: "font1"),
            ),
          )),
      Positioned(
          top: 200,
          left: 200,
          child: Image.asset(
            "assets/images/qr1.png",
            scale: 1.0,
          )),
      Positioned(
        top: 500,
        left: 50,
        child: CircleAvatar(
          radius: 40,
          backgroundColor: selectionColor,
          child: Icon(
            Icons.check,
            size: 30.sp,
            color: Colors.white,
          ),
        ),
      )
    ]);
  }
}
