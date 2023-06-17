import 'dart:async';

import 'package:attendance_tracker/helpers/cache_helper.dart';
import 'package:attendance_tracker/models/instructor_lecture_model.dart';
import 'package:attendance_tracker/models/instructor_subject_model.dart';
import 'package:attendance_tracker/modules/instructor_home_screen/instructor_cubit/instructor_cubit.dart';
import 'package:attendance_tracker/modules/instructor_home_screen/instructor_cubit/instructor_states.dart';
import 'package:attendance_tracker/modules/instructor_lecture_screen/instructor_lecture_screen.dart';
import 'package:attendance_tracker/modules/instructor_subjects_screen/instructor_subjects_screen.dart';
import 'package:attendance_tracker/modules/login_screen/login_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/component.dart';
import '../instructor_search_screen/instructor_search_screen.dart';
import '../no_internet_screen/no_internet_screen.dart';

class InstructorHomeScreen extends StatefulWidget {
  const InstructorHomeScreen({Key? key}) : super(key: key);

  @override
  State<InstructorHomeScreen> createState() => _InstructorHomeScreenState();
}

class _InstructorHomeScreenState extends State<InstructorHomeScreen> {
  late Connectivity _connectivity;
  late StreamSubscription<ConnectivityResult> _subscription;

  @override
  void initState() {
    super.initState();

    _connectivity = Connectivity();
    _subscription = _connectivity.onConnectivityChanged.listen((event) {
      setState(() {
        if (event == ConnectivityResult.none) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const NoInternetScreen()),
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InstructorCubit, InstructorStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = InstructorCubit.get(context);

        return Scaffold(
          floatingActionButton: cubit.instructorSubjects.isNotEmpty
              ? FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => InstructorSearchScreen(
                              isSubject: true,
                              isAttendance: false,
                            )));
                  },
                  child: const Icon(
                    Icons.search,
                  ),
                )
              : null,
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
                              builder: (context) => const LoginScreen(),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Subtitle(title: 'Your Next Lectures'),
              ),
              nextLectureView(cubit, context),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Subtitle(title: 'Your Courses'),
              ),
              Expanded(
                child: cubit.isGettingSubjects
                    ? const Center(child: CircularProgressIndicator())
                    : cubit.instructorSubjects.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.only(top: 48.0),
                            child: Center(
                              child: Card(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'You have no subjects yet',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : ListView.separated(
                            itemBuilder: (context, index) => buildCourseItem(
                                cubit.instructorSubjects[index], context),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
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

  Widget nextLectureView(InstructorCubit cubit, context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 180,
      width: double.infinity,
      child: cubit.nextLectures.isEmpty
          ? const Card(
              child: Center(
                child: MainBody(text: 'There is not scheduled lectures yet'),
              ),
            )
          : Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Expanded(
                child: CarouselSlider(
                  items: [
                    ...cubit.nextLectures
                        .map(
                          (InstructorNextLectureModel lecture) =>
                              GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    InstructorNextLectureScreen(lecture),
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
                                      overflow: true,
                                    ),
                                    MainBody(
                                      text: lecture.faculty,
                                    ),
                                    MainBody(
                                      text: lecture.name,
                                    ),
                                    const Spacer(),
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
                                        ),
                                      ],
                                    ),
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
                  child: Center(
                    child: DotsIndicator(
                      dotsCount: cubit.nextLectures.length,
                      position: cubit.lecturePosition,
                      decorator: DotsDecorator(
                        size: const Size.square(9.0),
                        activeSize: const Size(18.0, 9.0),
                        activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                ),
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
                    // const Padding(
                    //   padding: EdgeInsets.all(4.0),
                    //   child: MainBody(
                    //     text: 'ID : CS341',
                    //   ),
                    // ),
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
