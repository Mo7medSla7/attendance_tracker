import 'package:flutter/material.dart';

import '../../shared/component.dart';

class InstructorLectureScreen extends StatefulWidget {
  const InstructorLectureScreen({Key? key}) : super(key: key);

  @override
  State<InstructorLectureScreen> createState() => _InstructorLectureScreenState();
}

class _InstructorLectureScreenState extends State<InstructorLectureScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('lecture'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: SizedBox(
            height: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Subtitle(title: 'Lecture name'),
                    Spacer(),
                    MiniTitle(title:'Code: cs223',),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const MiniTitle(title: 'status: Attended'),
                      const SizedBox(height: 10,),
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
                      Row(
                        children: const [
                          MiniTitle(title: 'Active students: 33'),
                          SizedBox(
                            width: 5,
                          ),
                          CircleAvatar(
                            child: Icon(
                              Icons.person,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10,),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                const Subtitle(title: 'Students'),
                Expanded(
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => buildStudentAttendItem(),
                    separatorBuilder: (context, index) => const SizedBox(height: 10,),
                    itemCount: 15,
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
Widget buildStudentAttendItem() => Card(
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            MiniTitle(
              title: "Student name",
            ),
            Spacer(),
            MiniTitle(title: 'ID: 190900013'),
          ],
        ),
      ],
    ),
  ),
);
