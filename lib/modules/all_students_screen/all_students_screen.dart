import 'package:attendance_tracker/shared/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../instructor_home_screen/instructor_cubit/instructor_cubit.dart';
import '../instructor_home_screen/instructor_cubit/instructor_states.dart';
import '../instructor_search_screen/instructor_search_screen.dart';

class AllStudentsScreen extends StatelessWidget {
  const AllStudentsScreen(this.subjectId, {super.key});

  final String subjectId;

  @override
  Widget build(BuildContext context) {
    var cubit = InstructorCubit.get(context);
    cubit.getSubjectActiveStudents(subjectId);
    return BlocConsumer<InstructorCubit, InstructorStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            floatingActionButton: cubit.activeStudents.isNotEmpty
                ? FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => InstructorSearchScreen(
                                isSubject: false,
                                isAttendance: false,
                              )));
                    },
                    child: const Icon(
                      Icons.search,
                    ),
                  )
                : null,
            appBar: AppBar(
              title: const Text('All Students'),
            ),
            body: cubit.isGettingActiveStudents
                ? const Center(child: CircularProgressIndicator())
                : cubit.activeStudents.isEmpty
                    ? const Center(
                        child: Text(
                          'There is no active students for this course yet',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ListView.separated(
                        itemBuilder: (context, index) =>
                            buildStudentItem(cubit.activeStudents[index]),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 4,
                        ),
                        itemCount: cubit.activeStudents.length,
                      ));
      },
    );
  }
}

Widget buildStudentItem(student) => Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const MiniTitle(
                      title: "Name : ",
                    ),
                    MainBody(
                      text: student['name'],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    const MiniTitle(
                      title: "ID : ",
                    ),
                    MainBody(
                      text: student['studentId'].toString(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
