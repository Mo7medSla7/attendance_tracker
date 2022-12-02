import 'package:attendance_tracker/helpers/dio_helper.dart';
import 'package:attendance_tracker/layout/layout_screen.dart';
import 'package:attendance_tracker/modules/login_screen/login_screen.dart';
import 'package:attendance_tracker/modules/on_boarding_screen/on_boarding_screen.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Attendance tracker',
      theme: ThemeData(
        fontFamily: 'RivalSans',
        primarySwatch: Colors.indigo,
      ),
      home: Layout_Screen(),
    );
  }
}
