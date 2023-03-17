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
  final facultyController =
      TextEditingController(text: CacheHelper.getData('STUDENT_FACULTY'));
  final academicYearController =
      TextEditingController(text: CacheHelper.getData('STUDENT_ACADEMIC_YEAR'));
  final semesterController =
      TextEditingController(text: CacheHelper.getData('STUDENT_SEMESTER'));
  final studentIdController =
      TextEditingController(text: CacheHelper.getData('STUDENT_ID').toString());

  @override
  Widget build(BuildContext context) {
    /*
    String numOfSubjects
     */
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Subtitle(
                title: 'Student Information',
                color: Colors.indigo,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultTextField(
                    controller: nameController,
                    title: 'Name',
                  ),
                  DefaultTextField(
                    controller: emailController,
                    title: 'Email',
                  ),
                  DefaultTextField(
                    title: 'Faculty',
                    controller: facultyController,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: DefaultTextField(
                        title: 'Academic Year',
                        controller: academicYearController,
                      )),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                          child: DefaultTextField(
                        title: 'Semester',
                        controller: semesterController,
                      )),
                    ],
                  ),
                  DefaultTextField(
                    title: 'Student ID',
                    controller: studentIdController,
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
      ),
    );
  }
}
