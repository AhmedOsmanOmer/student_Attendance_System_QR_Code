import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCode extends StatelessWidget {
  final String val;
  const QrCode({super.key, required this.val});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: CircleAvatar(
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: QrImageView(
          backgroundColor: Colors.white,
          data: val,
          version: QrVersions.auto,
          size: 650,
        ),
      ),
    );
  }
}
