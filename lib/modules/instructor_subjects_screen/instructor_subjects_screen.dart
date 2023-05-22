import 'package:attendance_tracker/models/instructor_lecture_model.dart';
import 'package:attendance_tracker/models/instructor_subject_model.dart';
import 'package:attendance_tracker/modules/all_students_screen/all_students_screen.dart';
import 'package:attendance_tracker/modules/instructor_home_screen/instructor_cubit/instructor_cubit.dart';
import 'package:attendance_tracker/modules/instructor_home_screen/instructor_cubit/instructor_states.dart';
import 'package:attendance_tracker/modules/instructor_lecture_screen/instructor_lecture_screen.dart';
import 'package:attendance_tracker/shared/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InstructorSubjectScreen extends StatelessWidget {
  const InstructorSubjectScreen(this.subject, {Key? key}) : super(key: key);
  final InstructorSubjectModel subject;

  @override
  Widget build(BuildContext context) {
    var cubit = InstructorCubit.get(context);
    cubit.getLecturesOfSubject(subject.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          subject.name,
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Add Lecture',
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
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const MiniTitle(title: 'Subject ID'),
                        MiniTitle(title: subject.faculty),
                        MiniTitle(title: 'Level ${subject.year}'),
                        MiniTitle(title: '${subject.semester} semester'),
                        Row(
                          children: [
                            MiniTitle(
                                title:
                                    '${subject.activeStudents} Active student'),
                            const Spacer(),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AllStudentsScreen(),
                                  ));
                                },
                                child: const MiniTitle(
                                  title: 'Show All',
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Subtitle(title: 'Course lectures'),
                  const SizedBox(
                    height: 8,
                  ),
                  cubit.isGettingLecturesOfSubject
                      ? const Padding(
                          padding: EdgeInsets.only(top: 160.0),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => buildCourseLectures(
                              cubit.lecturesOfSubject[index], context),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 4,
                          ),
                          itemCount: cubit.lecturesOfSubject.length,
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildCourseLectures(InstructorLectureModel lecture, context) =>
    GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => InstructorLectureScreen(lecture),
        ));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
              if (lecture.finished)
                Row(
                  children: [
                    const Text('Attendance : '),
                    Row(
                      children: [
                        Text(
                          lecture.numOfAttendees.toString(),
                          style: const TextStyle(
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Icon(
                          Icons.person,
                          color: Colors.indigo,
                          size: 16,
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
