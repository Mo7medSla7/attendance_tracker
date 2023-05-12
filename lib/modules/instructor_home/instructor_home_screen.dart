import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../../shared/component.dart';

class InstructorHomeScreen extends StatelessWidget {
  InstructorHomeScreen({Key? key}) : super(key: key);

  int index = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const CircleAvatar(
              radius: 30,
              child: Icon(
                Icons.search,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: 270,
            width: double.infinity,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Subtitle(title: 'Next Lectures'),
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
                            const MiniTitle(
                              title: "lecture name",
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
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const Card(
                      child:
                          SizedBox(width: double.infinity, child: Text('page 2')),
                    ),
                    const Card(
                      child:
                          SizedBox(width: double.infinity, child: Text('page 3')),
                    ),
                  ],
                  options: CarouselOptions(
                    autoPlay: false,
                    initialPage: 0,
                    viewportFraction: 1,
                    enableInfiniteScroll: false,
                    height: double.infinity,
                    scrollPhysics: const BouncingScrollPhysics(),
                    onPageChanged: (index, reason) {},
                  ),
                ),
              ),
              Center(
                child: DotsIndicator(
                  dotsCount: 3,
                  position: 0.0,
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
                child: Subtitle(title: 'Your courses'),
              ),
            ]),
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) => buildCourseItem(),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: 15),
          ),
        ],
      ),

    );
  }
}

Widget buildCourseItem() => Expanded(
      child: Card(
       // margin: const EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  MiniTitle(
                    title: "Course name",
                  ),
                  Spacer(),
                  MiniTitle(title: 'code : cs341'),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const MiniTitle(title: 'Computer science'),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: const [
                  MiniTitle(
                    title: "Level 1",
                  ),
                  Spacer(),
                  MiniTitle(title: 'Semester two'),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: const [
                  MiniTitle(title: 'Active students: 60'),
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
            ],
          ),
        ),
      ),
    );
