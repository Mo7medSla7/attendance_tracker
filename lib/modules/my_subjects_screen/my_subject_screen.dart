import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/component.dart';
import '../subject_details_screen/subject_details_screen.dart';

class MySubjectsScreen extends StatelessWidget {
  const MySubjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);

    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return cubit.isGettingMySubjects
              ? const Center(child: CircularProgressIndicator())
              : cubit.mySubjects.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.only(top: 24.0),
                      child: Center(
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'You didn\'t register any subjects yet',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        var subject = cubit.mySubjects[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SubjectDetailsScreen(
                                  subject,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: MiniTitle(
                                          title: subject.name,
                                        ),
                                      ),
                                      const Text('Status : '),
                                      subject.isAccepted!
                                          ? Row(
                                              children: const [
                                                Text(
                                                  'Accepted ',
                                                  style: TextStyle(
                                                      color: Colors.green),
                                                ),
                                                Icon(
                                                  Icons.check_circle_rounded,
                                                  color: Colors.green,
                                                  size: 16,
                                                )
                                              ],
                                            )
                                          : Row(
                                              children: const [
                                                Text(
                                                  'In Progress ',
                                                  style: TextStyle(
                                                      color: Colors.orange),
                                                ),
                                                Icon(
                                                  Icons.watch_later_rounded,
                                                  color: Colors.orange,
                                                  size: 16,
                                                )
                                              ],
                                            ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  MainBody(
                                    text: subject.faculty,
                                    color: Colors.grey[700],
                                  ),
                                  MiniBody(
                                    text:
                                        'Level ${subject.year} ${subject.semester} semester',
                                    color: Colors.grey[700],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: cubit.mySubjects.length,
                    );
        });
  }
}
