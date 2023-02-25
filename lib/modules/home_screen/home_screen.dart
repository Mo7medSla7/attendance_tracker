import 'package:attendance_tracker/shared/component.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../models/lecture_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.count(
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        crossAxisCount: 2,
        childAspectRatio: 0.83,
        children: List.generate(lectures.length,
            (index) => buildLectureItem(lectures[index], context)),
      ),
    );
  }
}

Widget buildLectureItem(LectureModel lecture, context) => Card(
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainBody(text: 'Dr.${lecture.drName}'),
            Text(
              lecture.subject,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: CircularPercentIndicator(
                radius: 50.0,
                lineWidth: 12.0,
                animation: true,
                percent: (lecture.attendancePercent / 100),
                center: Text(
                  '${lecture.attendancePercent.round()} %',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                footer: const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Text(
                    "Lectures attended",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
                  ),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
