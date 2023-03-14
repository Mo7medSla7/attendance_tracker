import 'package:attendance_tracker/layout/cubit/cubit.dart';
import 'package:attendance_tracker/shared/component.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../layout/cubit/states.dart';
import '../../models/lecture_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          nextLecturesView(lectures[0]),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Subtitle(title: 'Your Progress In Courses'),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 2,
              childAspectRatio: 0.81,
              children: List.generate(lectures.length,
                  (index) => buildLectureItem(lectures[index], context)),
            ),
          ),
        ],
      ),
    );
  }

  Widget nextLecturesView(LectureModel lecture) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Container(
          padding: const EdgeInsets.all(8),
          height: 270,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Subtitle(title: 'Your Next Lectures'),
              ),
              Expanded(
                child: CarouselSlider(
                  items: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            MiniTitle(
                              title: lecture.subject,
                            ),
                            MainBody(
                              text: lecture.drName,
                              color: Colors.grey[700],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Spacer(),
                            SubBody(
                              text:
                                  'You have attended ${lecture.attendancePercent.toInt()} % lectures of this course',
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
                            )
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: SizedBox(
                          width: double.infinity, child: Text('page 2')),
                    ),
                    Card(
                      child: SizedBox(
                          width: double.infinity, child: Text('page 3')),
                    ),
                  ],
                  options: CarouselOptions(
                    autoPlay: false,
                    initialPage: 0,
                    viewportFraction: 1,
                    enableInfiniteScroll: false,
                    height: double.infinity,
                    scrollPhysics: const BouncingScrollPhysics(),
                    onPageChanged: (index, reason) {
                      cubit.changeNextLecture(index);
                    },
                  ),
                ),
              ),
              Center(
                child: DotsIndicator(
                  dotsCount: 3,
                  position: cubit.lecturePosition,
                  decorator: DotsDecorator(
                    size: const Size.square(9.0),
                    activeSize: const Size(18.0, 9.0),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
            MainBody(text: lecture.subject),
            MiniBody(
              text: 'Dr.${lecture.drName}',
              color: Colors.grey[700],
            ),
            const Spacer(),
            Center(
              child: CircularPercentIndicator(
                radius: 50.0,
                lineWidth: 13.0,
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
