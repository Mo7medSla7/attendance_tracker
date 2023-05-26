import 'package:attendance_tracker/models/instructor_lecture_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/component.dart';
import '../instructor_home_screen/instructor_cubit/instructor_cubit.dart';
import '../instructor_home_screen/instructor_cubit/instructor_states.dart';

class InstructorLectureScreen extends StatelessWidget {
  InstructorLectureScreen(this.lecture, {super.key});
  final InstructorLectureModel lecture;

  @override
  Widget build(BuildContext context) {
    var cubit = InstructorCubit.get(context);
    if (lecture.finished) {
      cubit.getLectureAttendees(lecture.id);
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.search,
        ),
      ),
      appBar: AppBar(
        actions: [
          if (lecture.finished)
            TextButton(
              onPressed: () {
                cubit.createAttendanceExcel(
                  cubit.lectureAttendees,
                  lecture.name,
                  lecture.date,
                );
              },
              child: const Text('Extract as File',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
            ),
        ],
      ),
      body: BlocConsumer<InstructorCubit, InstructorStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = InstructorCubit.get(context);

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Subtitle(
                        title: lecture.name,
                      )),
                      const SizedBox(
                        width: 16,
                      ),
                      const Text('Status : '),
                      lecture.finished
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
                                  'In Future ',
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
                    height: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text('Scheduled Date : '),
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
                      Row(
                        children: [
                          const Text('Scheduled Time : '),
                          Text(
                            lecture.time,
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
                      const SizedBox(
                        height: 8,
                      ),
                      MainBody(text: 'Type : ${lecture.type}'),
                      MainBody(text: 'Location : ${lecture.location}'),
                      const SizedBox(
                        height: 8,
                      ),
                      if (lecture.finished)
                        MainBody(
                            text:
                                'Attendance percentage : ${lecture.presencePercentage}'),
                      if (lecture.finished)
                        Row(
                          children: [
                            const MainBody(text: 'Attendance : '),
                            Row(
                              children: [
                                MainBody(
                                  text: lecture.numOfAttendees.toString(),
                                  color: Colors.green,
                                ),
                                const Icon(
                                  Icons.person,
                                  color: Colors.green,
                                  size: 16,
                                ),
                              ],
                            ),
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  if (lecture.finished)
                    const Subtitle(title: 'Attended Students'),
                  if (lecture.finished)
                    cubit.isGettingAttendees
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 200.0),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return buildStudentAttendItem(
                                  cubit.lectureAttendees[index]);
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 4,
                            ),
                            itemCount: cubit.lectureAttendees.length,
                          )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildStudentAttendItem(student) => Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const MiniTitle(
                      title: "Name : ",
                    ),
                    MainBody(
                      text: student['name'],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    const MiniTitle(
                      title: "ID : ",
                    ),
                    MainBody(
                      text: student['studentId'],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
