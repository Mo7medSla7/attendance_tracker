import 'package:attendance_tracker/layout/cubit/cubit.dart';
import 'package:attendance_tracker/modules/subject_details_screen/subject_details_screen.dart';
import 'package:attendance_tracker/shared/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/states.dart';

class SubjectScreen extends StatelessWidget {
  const SubjectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return cubit.subjectsToRegister.isEmpty &&
                cubit.registeredSubjects.isEmpty &&
                cubit.isGettingSubjects
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () => cubit.refreshSubjects(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (cubit.registeredSubjects.isNotEmpty)
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 8),
                            child: Subtitle(title: 'Registered Subjects'),
                          ),
                        if (cubit.registeredSubjects.isNotEmpty)
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var subject = cubit.registeredSubjects[index];
                              return GestureDetector(
                                onTap: () {
                                  if (subject.isAccepted!) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SubjectDetailsScreen(
                                          subject,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                                child: MiniTitle(
                                              title: subject.name,
                                            )),
                                            const Text('Status : '),
                                            subject.isAccepted!
                                                ? Row(
                                                    children: const [
                                                      Text(
                                                        'Accepted ',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.green),
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .check_circle_rounded,
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
                                                            color:
                                                                Colors.orange),
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .watch_later_rounded,
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
                            itemCount: cubit.registeredSubjects.length,
                          ),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                          child: Subtitle(title: 'Subjects To Register'),
                        ),
                        cubit.subjectsToRegister.isEmpty
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 24),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Image.asset(
                                      'assets/images/Subject_Empty.png',
                                      height: 240,
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Text(
                                      'It seems you do not have subjects to register\n Try to search on your wanted subject',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  bool checkState = false;
                                  cubit.checkStates.add(checkState);
                                  var subject = cubit.subjectsToRegister[index];
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 16.0),
                                    child: CheckboxListTile(
                                      onChanged: (value) {
                                        if (value!) {
                                          cubit.addSubject(subject.id, index);
                                        } else {
                                          checkState = value;
                                          cubit.removeSubject(
                                              subject.id, index);
                                        }
                                      },
                                      value: cubit.checkStates[index],
                                      title: MiniTitle(title: subject.name),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            MiniBody(text: subject.faculty),
                                            MiniBody(
                                                text: 'Level ${subject.year}'),
                                          ],
                                        ),
                                      ),
                                      tileColor: Colors.white,
                                    ),
                                  );
                                },
                                itemCount: cubit.subjectsToRegister.length,
                              ),
                        if (cubit.subjectsToRegister.isNotEmpty)
                          FullWidthElevatedButton(
                            text: 'Register',
                            onTap: () => cubit.sendSubjectsToRegister(),
                          ),
                        if (state is RegisterSubjectLoadingState)
                          const LinearProgressIndicator(),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
