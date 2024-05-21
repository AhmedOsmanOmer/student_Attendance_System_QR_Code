import 'package:fitness_dashboard_ui/model/attendance_model.dart';
import 'package:intl/intl.dart';

class AttendanceDetails {
  final attendanceData = [
    AttendanceModel(
        icon: 'assets/images/time2.png',
        value:
            '${DateFormat('yyyy-MM-dd').format(DateTime.now()) + '  ' + DateFormat('HH:mm').format(DateTime.now())}',
        title: 'Current Date & Time'),
    /*  AttendanceModel(
        icon: 'assets/images/conference.png',
        value: "10",
        title: "Number of Lectures"), */
  ];
}
