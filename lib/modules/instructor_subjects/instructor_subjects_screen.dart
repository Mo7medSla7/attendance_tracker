import 'package:attendance_tracker/shared/component.dart';
import 'package:flutter/material.dart';

class InstructorSubjectScreen extends StatelessWidget {
  const InstructorSubjectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Subjects',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            height: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Subtitle(title: 'Subject name'),
                    const Spacer(),
                    TextButton(
                        onPressed:(){},
                        child: const MiniTitle(title: 'Extract All',)
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const MiniTitle(title: 'Faculty name'),
                      const SizedBox(height: 10,),
                      const MiniTitle(title: 'level 1'),
                      const SizedBox(height: 10,),
                      const MiniTitle(title: 'semester two'),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          const MiniTitle(title: 'Active student: 56'),
                          const Spacer(),
                          TextButton(
                              onPressed:(){},
                              child: const MiniTitle(title: 'Show more..',)
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                const Subtitle(title: 'Course lectures'),
                Expanded(
                  child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => buildCourseLectures(),
                      separatorBuilder: (context, index) => const SizedBox(height: 10,),
                      itemCount: 15,
                  ),
                ),
                FloatingActionButton(
                  onPressed: (){},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
Widget buildCourseLectures() => Card(
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            MiniTitle(
              title: "Lecture name",
            ),
            Spacer(),
            MiniTitle(title: 'status: Attended'),
          ],
        ),
        const SizedBox(
          height: 10,
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
        const SizedBox(
          height: 10,
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
        )
      ],
    ),
  ),
);
