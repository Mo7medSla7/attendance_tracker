import 'package:attendance_tracker/models/lecture_model.dart';
import 'package:attendance_tracker/models/subject_model.dart';
import 'package:flutter/material.dart';

import '../../shared/component.dart';
import '../scanner_screen/scanner_screen.dart';

class LectureDetailsScreen extends StatelessWidget {
  const LectureDetailsScreen(this.lecture, {Key? key}) : super(key: key);
  final LectureModel lecture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ScannerScreen(lecture.id),
          ));
        },
        child: const Icon(Icons.qr_code_scanner, size: 26),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Lecture Details',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Subtitle(title: lecture.subjectName),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      children: [
                        const MiniTitle(
                          title: 'Lecture Name : ',
                          bold: true,
                        ),
                        MiniTitle(title: lecture.name),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Wrap(
                      children: [
                        const MiniTitle(
                          title: 'Instructor : ',
                          bold: true,
                        ),
                        MiniTitle(title: lecture.instructorName),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    MiniTitle(title: lecture.faculty),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        MiniTitle(title: 'Level ${lecture.year}'),
                        const Spacer(),
                        MiniTitle(title: '${lecture.semester} Semester'),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
