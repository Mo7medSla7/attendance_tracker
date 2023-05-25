import 'package:attendance_tracker/models/instructor_lecture_model.dart';
import 'package:attendance_tracker/models/instructor_subject_model.dart';
import 'package:attendance_tracker/modules/all_students_screen/all_students_screen.dart';
import 'package:attendance_tracker/modules/instructor_home_screen/instructor_cubit/instructor_cubit.dart';
import 'package:attendance_tracker/modules/instructor_home_screen/instructor_cubit/instructor_states.dart';
import 'package:attendance_tracker/modules/instructor_lecture_screen/instructor_lecture_screen.dart';
import 'package:attendance_tracker/shared/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class InstructorSubjectScreen extends StatelessWidget {
  const InstructorSubjectScreen(this.subject, {Key? key}) : super(key: key);
  final InstructorSubjectModel subject;

  @override
  Widget build(BuildContext context) {
    var cubit = InstructorCubit.get(context);
    cubit.getLecturesOfSubject(subject.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          subject.name,
        ),
        actions: [
          AddNewLectureAlert()
        ],
      ),
      body: BlocConsumer<InstructorCubit, InstructorStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const MiniTitle(title: 'Subject ID'),
                        MiniTitle(title: subject.faculty),
                        MiniTitle(title: 'Level ${subject.year}'),
                        MiniTitle(title: '${subject.semester} semester'),
                        Row(
                          children: [
                            MiniTitle(
                                title:
                                    '${subject.activeStudents} Active student'),
                            const Spacer(),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const AllStudentsScreen(),
                                  ));
                                },
                                child: const MiniTitle(
                                  title: 'Show All',
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Subtitle(title: 'Course lectures'),
                  const SizedBox(
                    height: 8,
                  ),
                  cubit.isGettingLecturesOfSubject
                      ? const Padding(
                          padding: EdgeInsets.only(top: 160.0),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => buildCourseLectures(
                              cubit.lecturesOfSubject[index], context),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 4,
                          ),
                          itemCount: cubit.lecturesOfSubject.length,
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildCourseLectures(InstructorLectureModel lecture, context) =>
    GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => InstructorLectureScreen(lecture),
        ));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: MiniTitle(
                      title: lecture.name,
                    ),
                  ),
                  const Text('Status : '),
                  lecture.finished
                      ? Row(
                          children: const [
                            Text(
                              'Finished ',
                              style: TextStyle(color: Colors.green),
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
                              'In Future ',
                              style: TextStyle(color: Colors.orange),
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
              ),
              if (lecture.finished)
                Row(
                  children: [
                    const Text('Attendance : '),
                    Row(
                      children: [
                        Text(
                          lecture.numOfAttendees.toString(),
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

class AddNewLectureAlert extends StatelessWidget {


  var lectureName = TextEditingController();

  var lectureLocation = TextEditingController();

  var dateController = TextEditingController();

  var timeController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  String? selectedType;

  List <String> types =
  [
    'Lecture',
    'Section'
  ];
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: ()
      {
        showDialog (context: context, builder: (context)=>AlertDialog(
          title:const MiniTitle(title: 'Add New lecture'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children : [
              SizedBox(
                width: 1500,
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DefaultFormField2(
                        controller: lectureName,
                        onSubmit:(){},
                        onChange: (){},
                        label: 'Lecture title',
                        type: TextInputType.text,
                        suffix: Icons.title,
                        isSuffixClicked: false,
                      ),
                      const SizedBox(height: 5,),
                      DefaultFormField2(
                        controller: lectureLocation,
                        onSubmit:(){},
                        onChange: (){},
                        label: 'Lecture location',
                        type: TextInputType.text,
                        suffix: Icons.location_on_outlined, isSuffixClicked: false,
                      ),
                      const SizedBox(height: 5,),
                      Row(
                        children: [
                          Expanded(
                            child: DefaultFormField2(
                              controller: dateController,
                              onSubmit:(){},
                              onChange: (){},
                              isSuffixClicked: true,
                              enableReadOnly: true,
                              label: 'Date',
                              type: TextInputType.text,
                              suffix:Icons.date_range_outlined,
                              onPressedSuffix: ()
                              {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate:DateTime.now(),
                                  lastDate: DateTime.parse('2044-05-23'),
                                ).then((value) {
                                  dateController.text = DateFormat.MMMd().format(value!);
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 4,),
                          Expanded(
                            child: DefaultFormField2(
                              controller: timeController,
                              onSubmit:(){},
                              onChange: (){},
                              isSuffixClicked: true,
                              enableReadOnly: true,
                              label: 'Time',
                              type: TextInputType.text,
                              suffix:Icons.access_time_outlined,
                              onPressedSuffix: ()
                              {
                                showTimePicker(context: context, initialTime: TimeOfDay.now()
                                ).then((value)
                                {
                                  timeController.text=(value!.format(context).toString());
                                }
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5,),
                      StatefulBuilder(
                          builder: (context,setState) {
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: Colors.black54,
                                  width: 1,
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: const Text('Choose Type'),
                                  isExpanded: true,
                                  items: types
                                      .map(
                                        (item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(
                                        item,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  )
                                      .toList(),
                                  onChanged: (item) {
                                    setState(() {
                                      selectedType = item!;
                                    });
                                  },
                                  value: selectedType,
                                ),
                              ),
                            );
                          }
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.grey[400]),
                    ),
                    onPressed: ()
                    {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel',),
                  ),
                  const Spacer(),
                  StatefulBuilder(
                    builder: (context,setState) {
                      return ElevatedButton(
                        onPressed: ()
                        {
                          setState(() {
                            formKey.currentState!.validate();
                          });
                        },
                        child: const Text('Submit',),
                      );
                    }
                  ),
                ],
              ),
            ),
          ],
        ),
        );
      },
      child: const Text('Add Lecture',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          )),
    );
  }
}
