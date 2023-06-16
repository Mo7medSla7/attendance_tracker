// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:attendance_tracker/layout/cubit/cubit.dart';
import 'package:attendance_tracker/shared/component.dart';
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
/*
      if (!isPageOpened) {
*/
      var cubit = AppCubit.get(context);
      await cubit.qrScan(scanData.code!, widget.id);
      if (cubit.qrSuccessScan) {
        showDefaultSnackBar(
          context,
          'Attendance recorded successfully',
          Colors.green,
          Colors.white,
        );
        if (!isPageOpened) {
          Navigator.pop(context);
          isPageOpened = true;
        }
        return;
      } else {
        showDefaultSnackBar(
          context,
          'Failed to record attendance',
          Colors.red,
          Colors.white,
        );
        if (!isPageOpened) {
          Navigator.pop(context);
          isPageOpened = true;
        }
        return;
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
