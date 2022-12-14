import 'package:attendance_tracker/layout/cubit/cubit.dart';
import 'package:attendance_tracker/shared/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/states.dart';

class Subject_Screen extends StatelessWidget {
  const Subject_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return cubit.subjectsForRegister.isEmpty &&
                cubit.registeredSubjects.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (cubit.registeredSubjects.isNotEmpty)
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                          child: Subtitle(title: 'Registered Subjects'),
                        ),
                      if (cubit.registeredSubjects.isNotEmpty)
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var subject = cubit.registeredSubjects[index];
                            return Card(
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
                                          overflow: true,
                                        )),
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
                            );
                          },
                          itemCount: cubit.registeredSubjects.length,
                        ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                        child: Subtitle(title: 'Subjects For Registered'),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          bool checkState = false;
                          cubit.checkStates.add(checkState);
                          var subject = cubit.subjectsForRegister[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: CheckboxListTile(
                              onChanged: (value) {
                                if (value!) {
                                  cubit.addSubject(subject.id, index);
                                } else {
                                  checkState = value;
                                  cubit.removeSubject(subject.id, index);
                                }
                              },
                              value: cubit.checkStates[index],
                              title: MiniTitle(title: subject.name),
                              subtitle: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MiniBody(text: subject.faculty),
                                    MiniBody(text: 'Level ${subject.year}'),
                                  ],
                                ),
                              ),
                              tileColor: Colors.white,
                            ),
                          );
                        },
                        itemCount: cubit.subjectsForRegister.length,
                      ),
                      FullWidthElevatedButton(
                        text: 'Register',
                        onTap: () => cubit.sendSubjectsToRegister(),
                      ),
                      if (state is RegisterSubjectLoadingState)
                        const LinearProgressIndicator(),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
