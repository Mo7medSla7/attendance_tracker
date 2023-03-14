import 'package:flutter/material.dart';

import '../../helpers/cache_helper.dart';
import '../../shared/component.dart';
import '../login_screen/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final nameController =
      TextEditingController(text: CacheHelper.getData('STUDENT_NAME'));
  final emailController =
      TextEditingController(text: CacheHelper.getData('STUDENT_EMAIL'));

  @override
  Widget build(BuildContext context) {
    /*
    String numOfSubjects
  String email;
  String name;
  String faculty;
  String academicYear;
  String semester;
  num studentId;
     */
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Subtitle(title: 'Student Information'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainBody(text: 'Name', color: Colors.grey[700]),
                TextField(
                  controller: nameController,
                  enabled: false,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          FullWidthElevatedButton(
            text: 'Log Out',
            color: Colors.red,
            onTap: () {
              CacheHelper.putData(key: 'isLoggedIn', value: false);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ));
            },
          ),
        ],
      ),
    );
  }
}
