import 'package:fitness_dashboard_ui/model/menu_model.dart';
import 'package:flutter/material.dart';

class SideMenuData {
  final menu = const <MenuModel>[
    MenuModel(icon: Icon(Icons.home), title: 'Dashboard'),
    MenuModel(icon: Icon(Icons.person), title: 'Profile'),
    MenuModel(
        icon: ImageIcon(AssetImage('assets/images/attendance.png')),
        title: 'Attendance'),
    MenuModel(
        icon: ImageIcon(AssetImage('assets/images/no-phone.png')),
        title: 'Special Cases'),
    MenuModel(
        icon: ImageIcon(AssetImage('assets/images/test.png')), title: 'Exams'),
     MenuModel(icon: Icon(Icons.logout), title: 'SignOut') 
  ];
}
