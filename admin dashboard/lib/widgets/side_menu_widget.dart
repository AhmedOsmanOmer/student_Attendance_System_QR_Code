// ignore_for_file: must_be_immutable

import 'package:fitness_dashboard_ui/const/constant.dart';
import 'package:fitness_dashboard_ui/data/side_menu_data.dart';
import 'package:fitness_dashboard_ui/screens/main_screen/main_screen.dart';
import 'package:flutter/material.dart';

class SideMenuWidget extends StatelessWidget {
  final Function(int) onItemSelected;
  int selectedIndex = 0;

  SideMenuWidget({required this.onItemSelected});
  @override
  Widget build(BuildContext context) {
    final data = SideMenuData();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      color: const Color(0xFF171821),
      child: ListView.builder(
        itemCount: data.menu.length,
        itemBuilder: (context, index) => buildMenuEntry(context, data, index),
      ),
    );
  }

  Widget buildMenuEntry(BuildContext context, SideMenuData data, int index) {
    final isSelected = index == pageIndex;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(6.0),
        ),
        color: isSelected ? selectionColor : Colors.transparent,
      ),
      child: InkWell(
        onTap: () {
          onItemSelected(index);
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
              child: data.menu[index].icon,
            ),
            Text(
              data.menu[index].title,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.black : Colors.grey,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            )
          ],
        ),
      ),
    );
  }
}
