import 'package:flutter/material.dart';

import '../../shared/component.dart';
import '../scanner_screen/scanner_screen.dart';

class SubjectDetailsScreen extends StatelessWidget {
  const SubjectDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ScannerScreen(),
          ));
        },
        child:  const Icon(Icons.qr_code_scanner, size: 26),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Subject Details',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Subtitle(title: 'Subject name'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        MiniTitle(title: 'Level two'),
                        Spacer(),
                        MiniTitle(title: 'First Semester'),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        const MiniTitle(title: 'Active student: '),
                        Row(
                          children: const [
                            Text(
                              '60',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
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
                        const MiniTitle(title: 'Attendence progress : '),
                        Row(
                          children: const [
                            Text(
                              '70',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              Icons.percent_rounded,
                              color: Colors.green,
                              size: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Subtitle(title: 'Lectures'),
              const SizedBox(
                height: 8,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => buildLectureItem(context),
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

Widget buildLectureItem(context) => Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
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
                  const Spacer(),
                  5 == 5
                      ? Row(
                    children: const [
                      Text(
                        'Attended',
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
                        'Not attended',
                        style: TextStyle(color: Colors.orange),
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
    );
