import 'package:attendance_tracker/modules/all_students_screen/all_students_screen.dart';
import 'package:attendance_tracker/modules/instructor_lecture_screen/instructor_lecture_screen.dart';
import 'package:attendance_tracker/shared/component.dart';
import 'package:flutter/material.dart';

class InstructorSubjectScreen extends StatelessWidget {
  const InstructorSubjectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Subject name',
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
      body: Padding(
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
                    const MiniTitle(title: 'Faculty name'),
                    const MiniTitle(title: 'Level one'),
                    const MiniTitle(title: 'first semester'),
                    Row(
                      children: [
                        const MiniTitle(title: '60 Active student'),
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
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => buildCourseLectures(context),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 4,
                ),
                itemCount: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildCourseLectures(context) => GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => InstructorLectureScreen(),
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
                      title: "Lecture name",
                    ),
                  ),
                  const Text('Status : '),
                  5 == 5
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
                    children: const [
                      Text(
                        'Wed 25/3/2023 ',
                        style: TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.calendar_today,
                        color: Colors.indigo,
                        size: 16,
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Text('Time : '),
                  Row(
                    children: const [
                      Text(
                        '12:30 PM ',
                        style: TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.access_time_rounded,
                        color: Colors.indigo,
                        size: 16,
                      ),
                    ],
                  )
                ],
              ),
              if (5 == 5)
                Row(
                  children: [
                    const Text('Attendance : '),
                    Row(
                      children: const [
                        Text(
                          '60',
                          style: TextStyle(
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
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
