import 'package:attendance_tracker/models/instructor_subject_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/component.dart';
import '../instructor_home_screen/instructor_cubit/instructor_cubit.dart';
import '../instructor_home_screen/instructor_cubit/instructor_states.dart';
import '../instructor_subjects_screen/instructor_subjects_screen.dart';

class InstructorSearchScreen extends StatelessWidget {
  InstructorSearchScreen(
      {required this.isSubject, required this.isAttendance, Key? key})
      : super(key: key);

  bool isSubject;
  bool isAttendance;
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InstructorCubit, InstructorStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = InstructorCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: const Text('Search'),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Stack(alignment: Alignment.center, children: [
                        TextField(
                          onSubmitted: (value) {
                            searchController.text = '';
                            cubit.toggleSearch(false);
                          },
                          controller: searchController,
                          onChanged: (value) {
                            if (isSubject) {
                              cubit.searchSubjects(value);
                            } else {
                              cubit.searchStudent(value, isAttendance);
                            }
                          },
                          onTap: () {
                            cubit.toggleSearch(true);
                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 8),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        if (!cubit.isFocused)
                          const Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              'Search',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        const Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Icon(
                            Icons.search,
                            color: Colors.indigo,
                          ),
                        ),
                      ]),
                    ),
                  ),
                  if (isSubject)
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => buildCourseItem(
                          cubit.filteredSubjects[index], context),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 8,
                      ),
                      itemCount: cubit.filteredSubjects.length,
                    )
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>
                          buildStudentItem(cubit.filteredStudents[index]),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 4,
                      ),
                      itemCount: cubit.filteredStudents.length,
                    )
                ],
              ),
            ),
          );
        });
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
}
