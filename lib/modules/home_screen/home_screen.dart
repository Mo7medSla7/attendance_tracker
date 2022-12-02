import 'package:flutter/material.dart';

class Home_Screen extends StatelessWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
          'HOME',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
