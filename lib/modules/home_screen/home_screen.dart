import 'package:attendance_tracker/layout/cubit/cubit.dart';
import 'package:attendance_tracker/modules/lecture_details_screen/lecture_details_screen.dart';
import 'package:attendance_tracker/shared/component.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../layout/cubit/states.dart';
import '../../models/lecture_model.dart';
import '../../models/students_statistics_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return cubit.nextLectures.isEmpty &&
                  cubit.isGettingLectures &&
                  cubit.isGettingSubjectsStats
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: () {
                    cubit.lecturePosition = 0.0;
                    cubit.getSubjectsStats();
                    return cubit.getNextLectures();
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: Subtitle(title: 'Your Next Lectures'),
                        ),
                        nextLecturesView(cubit, context),
                        if (cubit.subjectsStats.isNotEmpty)
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: Subtitle(title: 'Your Progress In Courses'),
                          ),
                        if (cubit.subjectsStats.isNotEmpty)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                MainBody(
                                    text:
                                        'You now see your progress in ${cubit.isLecture ? 'Lectures' : 'Sections'}'),
                                Switch(
                                    value: cubit.isLecture,
                                    onChanged: (value) =>
                                        cubit.changeStatsMode(value)),
                              ],
                            ),
                          ),
                        if (cubit.subjectsStats.isNotEmpty)
                          cubit.isGettingSubjectsStats
                              ? const CircularProgressIndicator()
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GridView.count(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.78,
                                    children: List.generate(
                                        cubit.subjectsStats.length,
                                        (index) => buildLectureItem(
                                            cubit.subjectsStats[index],
                                            context,
                                            cubit)),
                                  ),
                                ),
                      ],
                    ),
                  ),
                );
        });
  }

  Widget nextLecturesView(AppCubit cubit, context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 260,
      width: double.infinity,
      child: cubit.nextLectures.isEmpty
          ? const Card(
              child: Center(
                child: MainBody(text: 'There is not scheduled lectures yet'),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CarouselSlider(
                    items: [
                      ...cubit.nextLectures
                          .map(
                            (LectureModel lecture) => GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LectureDetailsScreen(
                                    lecture,
                                  ),
                                ));
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      MiniTitle(
                                        title: lecture.subjectName,
                                      ),
                                      MainBody(
                                        text: 'Dr. ${lecture.instructorName}',
                                        color: Colors.grey[700],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      MainBody(
                                        text: (lecture.type == 'Lecture'
                                                ? 'Lecture name : '
                                                : 'Section name : ') +
                                            lecture.name,
                                      ),
                                      Row(
                                        children: [
                                          MainBody(
                                            text: 'Type : ${lecture.type}',
                                          ),
                                          const Spacer(),
                                          MainBody(
                                            text:
                                                'Location : ${lecture.location}',
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Builder(builder: (context) {
                                        final subjectState =
                                            cubit.subjectsStats.firstWhere(
                                          (element) =>
                                              element.subjectName ==
                                              lecture.subjectName,
                                          orElse: () => StudentStatisticsModel(
                                            id: '0',
                                            instructorName: 'N/A',
                                            level: 'N/A',
                                            semester: 'N/A',
                                            subjectName: 'N/A',
                                            totalLectures: 0,
                                            totalSections: 0,
                                            lectureAttendancePercentage: '0',
                                            sectionAttendancePercentage: '0',
                                          ),
                                        );
                                        return SubBody(
                                          text:
                                              'You have attended ${subjectState.lectureAttendancePercentage} % lectures of this course',
                                        );
                                      }),
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
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList()
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.8),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DotsIndicator(
                      mainAxisAlignment: MainAxisAlignment.center,
                      dotsCount: cubit.nextLectures.length,
                      position: cubit.lecturePosition,
                      decorator: DotsDecorator(
                        size: const Size.square(9.0),
                        activeSize: const Size(18.0, 9.0),
                        activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

Widget buildLectureItem(StudentStatisticsModel stat, context, cubit) => Card(
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainBody(text: stat.subjectName),
            MiniBody(
              text: 'Dr. ${stat.instructorName}',
              color: Colors.grey[700],
            ),
            const Spacer(),
            Center(
              child: CircularPercentIndicator(
                radius: 50.0,
                lineWidth: 13.0,
                animation: true,
                percent: ((double.tryParse(cubit.isLecture
                            ? stat.lectureAttendancePercentage
                            : stat.sectionAttendancePercentage) ??
                        0) /
                    100),
                center: Text(
                  '${cubit.isLecture ? stat.lectureAttendancePercentage : stat.sectionAttendancePercentage} %',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                footer: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    "${cubit.isLecture ? 'Lectures' : 'Sections'} attended",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16.0),
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
