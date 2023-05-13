import 'package:flutter/material.dart';

import '../../shared/component.dart';

class InstructorLectureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.search,
        ),
      ),
      appBar: AppBar(
        title: const Text('Lecture name'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Extract as File',
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
              Row(
                children: [
                  const Subtitle(title: 'Lecture name'),
                  const Spacer(),
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
                height: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Text('Scheduled Date : '),
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
                  Row(
                    children: const [
                      Text('Scheduled Time : '),
                      Text(
                        '12:30 PM ',
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
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: const [
                      Text('Created Date : '),
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
                  Row(
                    children: const [
                      Text('Created Time : '),
                      Text(
                        '12:30 PM ',
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
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const MainBody(text: 'Attendance : '),
                      Row(
                        children: const [
                          MainBody(
                            text: '30',
                            color: Colors.green,
                          ),
                          Icon(
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
              const Subtitle(title: 'Attended Students'),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => buildStudentAttendItem(),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 4,
                ),
                itemCount: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildStudentAttendItem() => Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    MiniTitle(
                      title: "Name : ",
                    ),
                    const MainBody(
                      text: "Mohamed Salah Mohamed Ahmed",
                    ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: const [
                    MiniTitle(
                      title: "ID : ",
                    ),
                    const MainBody(
                      text: "190900013",
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
