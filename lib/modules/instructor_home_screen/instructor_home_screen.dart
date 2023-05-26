import 'package:attendance_tracker/helpers/cache_helper.dart';
import 'package:attendance_tracker/models/instructor_subject_model.dart';
import 'package:attendance_tracker/modules/instructor_home_screen/instructor_cubit/instructor_cubit.dart';
import 'package:attendance_tracker/modules/instructor_home_screen/instructor_cubit/instructor_states.dart';
import 'package:attendance_tracker/modules/instructor_lecture_screen/instructor_lecture_screen.dart';
import 'package:attendance_tracker/modules/instructor_subjects_screen/instructor_subjects_screen.dart';
import 'package:attendance_tracker/modules/login_screen/login_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/component.dart';

class InstructorHomeScreen extends StatelessWidget {
  InstructorHomeScreen({Key? key}) : super(key: key);

  int index = 3;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InstructorCubit, InstructorStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = InstructorCubit.get(context);

        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDefaultSnackBar(
                context,
                'Lecture created successfully',
              );
            },
            child: const Icon(
              Icons.search,
            ),
          ),
          appBar: AppBar(
            title: const Text(
              'Home',
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Logout From This Account ?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: const Text(
                              'No',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      ),
                    ).then((logout) {
                      if (logout ?? false) {
                        CacheHelper.putData(key: 'isLoggedIn', value: false);
                        CacheHelper.putData(key: 'isInstructor', value: false);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                            (route) => false);
                        cubit.logout();
                      }
                    });
                  },
                  icon: const Icon(
                    color: Colors.white,
                    Icons.logout,
                  ),
                ),
              )
            ],
          ),
          body: Column(
            children: [
              nextLectureView(cubit, context),
              Expanded(
                child: cubit.isGettingSubjects
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.separated(
                        itemBuilder: (context, index) => buildCourseItem(
                            cubit.instructorSubjects[index], context),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 8,
                        ),
                        itemCount: cubit.instructorSubjects.length,
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget nextLectureView(cubit, context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 290,
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Subtitle(title: 'Your Next Lectures'),
        ),
        Expanded(
          child: CarouselSlider(
            items: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        InstructorLectureScreen(cubit.lecturesOfSubject[0]),
                  ));
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const MiniTitle(
                          title: "The name of the course",
                          overflow: true,
                        ),
                        const MainBody(
                          text: "lecture name",
                        ),
                        const SizedBox(
                          height: 12,
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
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Card(
                child: SizedBox(width: double.infinity, child: Text('page 2')),
              ),
              const Card(
                child: SizedBox(width: double.infinity, child: Text('page 3')),
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
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Subtitle(title: 'Your Courses'),
        ),
      ]),
    );
  }

  Widget buildCourseItem(InstructorSubjectModel subject, context) =>
      GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => InstructorSubjectScreen(subject),
          ));
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: MiniTitle(
                        title: subject.name,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: MainBody(
                        text: 'ID : CS341',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                MiniBody(
                  text: subject.faculty,
                ),
                Row(
                  children: [
                    MiniBody(
                      text:
                          'Level ${subject.year} ${subject.semester} semester',
                    ),
                    const Spacer(),
                    const Text('Active Students : '),
                    Row(
                      children: [
                        Text(
                          subject.activeStudents.toString(),
                          style: const TextStyle(
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Icon(
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
}
