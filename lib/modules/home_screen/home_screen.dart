import 'package:attendance_tracker/helpers/cache_helper.dart';
import 'package:attendance_tracker/models/lecture_model.dart';
import 'package:attendance_tracker/modules/login_screen/login_screen.dart';
import 'package:attendance_tracker/shared/component.dart';
import 'package:flutter/material.dart';

class Home_Screen extends StatelessWidget {
  const Home_Screen({super.key,});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DefaultGridView(),
    );
   /* return Center(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: FullWidthElevatedButton(
        text: 'Log Out',
        color: Colors.red,
        onTap: () {
          CacheHelper.putData(key: 'isLoggedIn', value: false);
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
        },
      ),
    ));*/
  }
}
