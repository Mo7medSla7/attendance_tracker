import 'package:attendance_tracker/layout/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helpers/cache_helper.dart';
import '../../layout/cubit/cubit.dart';
import '../../shared/component.dart';
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
                      Row(
                        children: [
                          const MiniTitle(title: 'My All Courses'),
                          const Spacer(),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AllCoursesScreen(),
                                ));
                              },
                              child: const MiniTitle(
                                title: 'Show All',
                              )),
                        ],
                      ),
                      const Divider(),
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

class AllCoursesScreen extends StatelessWidget {
  const AllCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    cubit.getMySubjects();

    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('All Courses'),
              centerTitle: true,
            ),
            body: cubit.isGettingMySubjects
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      var subject = cubit.mySubjects[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SubjectDetailsScreen(
                                subject,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: MiniTitle(
                                        title: subject.name,
                                      ),
                                    ),
                                    const Text('Status : '),
                                    subject.isAccepted!
                                        ? Row(
                                      children: const [
                                        Text(
                                          'Accepted ',
                                          style: TextStyle(
                                              color:
                                              Colors.green),
                                        ),
                                        Icon(
                                          Icons
                                              .check_circle_rounded,
                                          color: Colors.green,
                                          size: 16,
                                        )
                                      ],
                                    )
                                        : Row(
                                      children: const [
                                        Text(
                                          'In Progress ',
                                          style: TextStyle(
                                              color:
                                              Colors.orange),
                                        ),
                                        Icon(
                                          Icons
                                              .watch_later_rounded,
                                          color: Colors.orange,
                                          size: 16,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                MainBody(
                                  text: subject.faculty,
                                  color: Colors.grey[700],
                                ),
                                MiniBody(
                                  text:
                                      'Level ${subject.year} ${subject.semester} semester',
                                  color: Colors.grey[700],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: cubit.mySubjects.length,
                  ),
          );
        });
  }
}
