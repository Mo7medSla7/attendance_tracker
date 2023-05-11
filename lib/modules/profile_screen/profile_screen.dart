import 'package:attendance_tracker/layout/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helpers/cache_helper.dart';
import '../../layout/cubit/cubit.dart';
import '../../shared/component.dart';
import '../login_screen/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController =
        TextEditingController(text: CacheHelper.getData('STUDENT_NAME'));
    var emailController =
        TextEditingController(text: CacheHelper.getData('STUDENT_EMAIL'));
    var facultyController =
        TextEditingController(text: CacheHelper.getData('STUDENT_FACULTY'));
    var academicYearController = TextEditingController(
        text: CacheHelper.getData('STUDENT_ACADEMIC_YEAR'));
    var semesterController =
        TextEditingController(text: CacheHelper.getData('STUDENT_SEMESTER'));
    var studentIdController = TextEditingController(
        text: CacheHelper.getData('STUDENT_ID').toString());

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        bool isEnabled = AppCubit.get(context).isEnabled;

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
                        isEnabled: isEnabled,
                      ),
                      DefaultTextField(
                        controller: emailController,
                        title: 'Email',
                        isEnabled: isEnabled,
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
                            isEnabled: isEnabled,
                          )),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                              child: DefaultTextField(
                            title: 'Semester',
                            controller: semesterController,
                            isEnabled: isEnabled,
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
                  height: 32,
                ),
                FullWidthElevatedButton(
                  text: 'Log Out',
                  color: Colors.red,
                  onTap: () {
                    CacheHelper.putData(key: 'isLoggedIn', value: false);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                        (route) => false);
                    BlocProvider.of<AppCubit>(context).logout();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
