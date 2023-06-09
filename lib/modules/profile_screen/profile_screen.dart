import 'package:attendance_tracker/layout/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helpers/cache_helper.dart';
import '../../layout/cubit/cubit.dart';
import '../../shared/component.dart';
import '../my_subjects_screen/my_subject_screen.dart';
import '../subject_details_screen/subject_details_screen.dart';

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
                      const SizedBox(
                        height: 8,
                      ),
                      DefaultTextField(
                        controller: nameController,
                        title: 'Name',
                        fieldName: 'name',
                        isEnabled: isEnabled,
                      ),
                      DefaultTextField(
                        controller: emailController,
                        title: 'Email',
                        fieldName: 'email',
                        isEnabled: isEnabled,
                      ),
                      DefaultTextField(
                        title: 'Faculty',
                        fieldName: 'faculty',
                        controller: facultyController,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: DefaultTextField(
                            title: 'Academic Year',
                            fieldName: 'year',
                            controller: academicYearController,
                            isEnabled: isEnabled,
                          )),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                              child: DefaultTextField(
                            title: 'Semester',
                            fieldName: 'semester',
                            controller: semesterController,
                            isEnabled: isEnabled,
                          )),
                        ],
                      ),
                      DefaultTextField(
                        title: 'Student ID',
                        fieldName: 'studentID',
                        controller: studentIdController,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
