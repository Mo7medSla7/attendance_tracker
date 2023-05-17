import 'dart:io';

import 'package:attendance_tracker/layout/cubit/cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen(this.id, {super.key});
  final String id;

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool isPageOpened = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QRView(
        overlay: QrScannerOverlayShape(
          borderColor: Colors.indigo,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: 300,
        ),
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      if (!isPageOpened) {
        var cubit = AppCubit.get(context);
        cubit.qrScan(scanData.code!, widget.id).then((value) {
          if (cubit.qrSuccessScan) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Attendance recorded successfully'),
                backgroundColor: Colors.green,
              ),
            );
          } else {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to record attendance'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }).catchError((e) => print(e));
        isPageOpened = true;
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

class AfterScanScreen extends StatelessWidget {
  const AfterScanScreen(this.scannedData, {super.key});

  final String scannedData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(scannedData)));
  }
}
