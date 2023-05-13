import 'package:attendance_tracker/shared/component.dart';
import 'package:flutter/material.dart';

class AllStudentsScreen extends StatelessWidget {
  const AllStudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Students'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: IconButton(
              onPressed: () {},
              icon: const CircleAvatar(
                radius: 30,
                child: Icon(
                  Icons.search,
                ),
              ),
            ),
          )
        ],
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => buildStudentItem(),
        separatorBuilder: (context, index) => const SizedBox(
          height: 4,
        ),
        itemCount: 15,
      ),
    );
  }
}

Widget buildStudentItem() => Card(
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
