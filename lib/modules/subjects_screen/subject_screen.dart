import 'package:flutter/material.dart';

class Subject_Screen extends StatelessWidget {
  const Subject_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'SUBJECTS',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
