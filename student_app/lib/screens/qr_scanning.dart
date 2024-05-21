import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:student_app/main.dart';
import 'package:student_app/screens/home.dart';

class QrCodeScanningScreen extends StatefulWidget {
  const QrCodeScanningScreen({super.key});

  @override
  State<QrCodeScanningScreen> createState() => _QrCodeScanningScreenState();
}

class _QrCodeScanningScreenState extends State<QrCodeScanningScreen> {
  final qrkey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? qr_result;
  Barcode barcode = Barcode("", BarcodeFormat.qrcode, []);

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.resumeCamera();
    }
    // lc.controller!.resumeCamera();
  }

  Widget buildQrView(BuildContext context) {
    return QRView(
        //cameraFacing: CameraFacing.unknown,
        key: qrkey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
            cutOutSize: 400,
            borderWidth: 1,
            borderLength: 2,
            borderRadius: 10));
  }

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.resumeCamera();
    controller.scannedDataStream.listen((barcode) {
      this.barcode = barcode;
      if (barcode.code == pref.getString('qr_value')) {
        controller.stopCamera();
        makeAttendance();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (builder) => Home()));
        print('atttendeed');
      } else {
        controller.stopCamera();
        print('double');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: buildQrView(context)),
    );
  }

  makeAttendance() async {
    var request = await http.post(
        Uri.parse(
            'http://192.168.70.123/attendance_system/make_attendance.php'),
        body: {'id': pref.getString('id'), 'class': pref.getString('class')});
    var response = json.decode(request.body);
    if (response['status'] == 'success') {
      print("DDDDDDDDDDDone++++++++++++++++++++++++++++++++++++++++++");
    }
    if (response['status'] == 'fail') {
      print("error????????????????????????????????????????????????????");
    }
  }
}
