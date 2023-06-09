import 'package:attendance_tracker/layout/cubit/cubit.dart';
import 'package:attendance_tracker/layout/cubit/states.dart';
import 'package:attendance_tracker/models/subject_model.dart';
import 'package:attendance_tracker/modules/lecture_details_screen/lecture_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/component.dart';
import '../scanner_screen/scanner_screen.dart';

class SubjectDetailsScreen extends StatelessWidget {
  const SubjectDetailsScreen(this.subject, {Key? key}) : super(key: key);
  final SubjectModel subject;

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    cubit.getLecturesOfSubjects(subject.id);

    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'Subject Details',
              ),
            ),
            body: cubit.isGettingLecturesOfSubject
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Subtitle(title: subject.name),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (subject.instructor != '')
                                  Wrap(
                                    children: [
                                      const MiniTitle(
                                        title: 'Instructor : ',
                                        bold: true,
                                      ),
                                      MiniTitle(title: subject.instructor),
                                    ],
                                  ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    MiniTitle(title: 'Level ${subject.year}'),
                                    const Spacer(),
                                    MiniTitle(
                                        title: '${subject.semester} Semester'),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    const MiniTitle(title: 'Active student : '),
                                    Row(
                                      children: [
                                        Text(
                                          subject.numberOfStudents.toString(),
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.indigo,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Icon(
                                          Icons.person,
                                          color: Colors.indigo,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    const MiniTitle(
                                        title: 'Attendance progress : '),
                                    Row(
                                      children: [
                                        Text(
                                          cubit.attendanceProgress == 'NaN'
                                              ? 'N/A'
                                              : cubit.attendanceProgress ==
                                                      'Infinity'
                                                  ? '0'
                                                  : cubit.attendanceProgress,
                                          style: const TextStyle(
                                            color: Colors.green,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        cubit.attendanceProgress == 'NaN'
                                            ? const SizedBox()
                                            : const Icon(
                                                Icons.percent_rounded,
                                                color: Colors.green,
                                                size: 20,
                                              ),
                                      ],
                                    ),
                                  ],
                                ),
                                MainBody(
                                    text:
                                        'You Attended ${cubit.attendedLecture} lectures from ${cubit.allLectures} lectures'),
                              ],
                            ),
                          ),
                          const Subtitle(title: 'Lectures'),
                          const SizedBox(
                            height: 8,
                          ),
                          cubit.lecturesOfSubject.isEmpty
                              ? const Padding(
                                  padding: EdgeInsets.only(top: 24.0),
                                  child: Center(
                                    child: Card(
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'No lectures for this course yet',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      buildLectureItem(context,
                                          cubit.lecturesOfSubject[index]),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 4,
                                  ),
                                  itemCount: cubit.lecturesOfSubject.length,
                                ),
                        ],
                      ),
                    ),
                  ),
          );
        });
  }
}

Widget buildLectureItem(context, lecture) => Card(
      child: GestureDetector(
        onTap: () {
          if (lecture.fullDate.isAfter(DateTime.now())) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LectureDetailsScreen(lecture),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: MiniTitle(
                      title: lecture.name,
                    ),
                  ),
                  const Text('Status : '),
                  lecture.fullDate.isBefore(DateTime.now())
                      ? Row(
                          children: const [
                            Text(
                              'Finished ',
                              style: TextStyle(color: Colors.green),
                            ),
                            Icon(
                              Icons.check_circle_rounded,
                              color: Colors.green,
                              size: 16,
                            )
                          ],
                        )
                      : Row(
                          children: const [
                            Text(
                              'In future',
                              style: TextStyle(color: Colors.orange),
                            ),
                            Icon(
                              Icons.watch_later_rounded,
                              color: Colors.orange,
                              size: 16,
                            )
                          ],
                        ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  const Text('Date : '),
                  Row(
                    children: [
                      Text(
                        lecture.date,
                        style: const TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(
                        Icons.calendar_today,
                        color: Colors.indigo,
                        size: 16,
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Text('Time : '),
                  Row(
                    children: [
                      Text(
                        lecture.time,
                        style: const TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(
                        Icons.access_time_rounded,
                        color: Colors.indigo,
                        size: 16,
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              if (lecture.fullDate.isBefore(DateTime.now()))
                Row(
                  children: [
                    const Spacer(),
                    lecture.hasAttended
                        ? Row(
                            children: const [
                              Text(
                                'Attended ',
                                style: TextStyle(color: Colors.indigo),
                              ),
                              Icon(
                                Icons.check_circle_rounded,
                                color: Colors.indigo,
                                size: 16,
                              )
                            ],
                          )
                        : Row(
                            children: const [
                              Text(
                                'Not attended ',
                                style: TextStyle(color: Colors.red),
                              ),
                              Icon(
                                Icons.watch_later_rounded,
                                color: Colors.red,
                                size: 16,
                              )
                            ],
                          ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
