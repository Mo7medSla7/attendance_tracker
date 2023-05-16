import 'package:attendance_tracker/shared/constants.dart';
import 'package:attendance_tracker/shared/user_data.dart';
import 'package:flutter/material.dart';

class DefaultFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? errorMessage;
  bool isPassword;
  IconData? icon;

  DefaultFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.errorMessage,
    this.icon,
    this.isPassword = false,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          fillColor: Colors.grey[100],
          filled: true,
          hintText: hintText,
          prefixIcon: Icon(
            icon,
            color: Colors.indigo,
          )),
      controller: controller,
      obscureText: isPassword,
      validator: (value) {
        if (value!.isEmpty) {
          return '${errorMessage ?? 'This field'} can not be empty';
        }
        return null;
      },
    );
  }
}

class HeaderTitle extends StatelessWidget {
  final String title;
  const HeaderTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class Subtitle extends StatelessWidget {
  final String title;
  final Color? color;
  const Subtitle({
    super.key,
    required this.title,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }
}

class MiniTitle extends StatelessWidget {
  final String title;
  final bool overflow;
  final bool bold;
  const MiniTitle(
      {super.key,
      required this.title,
      this.overflow = false,
      this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: bold ? FontWeight.bold : FontWeight.w600,
      ),
      overflow: overflow ? TextOverflow.ellipsis : null,
    );
  }
}

class MainBody extends StatelessWidget {
  final String text;
  final Color? color;
  const MainBody({
    super.key,
    required this.text,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: color,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class SubBody extends StatelessWidget {
  final String text;
  final Color? color;

  const SubBody({
    super.key,
    required this.text,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: color,
      ),
    );
  }
}

class MiniBody extends StatelessWidget {
  final String text;
  final Color? color;

  const MiniBody({
    super.key,
    required this.text,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: color,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class FullWidthElevatedButton extends StatelessWidget {
  final String text;
  final Function() onTap;
  final Color? color;

  const FullWidthElevatedButton(
      {super.key, required this.text, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color ?? Colors.blue[900]),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class DefaultTextField extends StatelessWidget {
  DefaultTextField({
    Key? key,
    required this.controller,
    required this.title,
    this.isEnabled = false,
  }) : super(key: key);
  final String title;
  final TextEditingController controller;
  bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                enabled: false,
                controller: controller,
                decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.only(bottom: 10, top: 8),
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    )),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            if (isEnabled)
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => EditAlert(title: title),
                  ).then((value) => controller.text = value).catchError((e) {});
                },
                icon: const Icon(
                  Icons.edit,
                ),
                color: Colors.indigo,
              )
          ],
        ),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }
}

class EditAlert extends StatelessWidget {
  EditAlert({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;
  final faculty = STUDENT_FACULTY;

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return AlertDialog(
      title: Text(
        'Change The $title : ',
        style: const TextStyle(color: Colors.indigo),
      ),
      content: SizedBox(
        width: 1500,
        child: title == 'Semester'
            ? Builder(
                builder: (
                  context,
                ) {
                  List<bool> selections = [false, false];
                  List<String> semesters = ['first', 'second'];
                  return StatefulBuilder(builder: (ctx, setInnerState) {
                    return Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List.generate(
                        2,
                        (index) => GestureDetector(
                          child: ToggleContainer(
                              title: semesters[index],
                              isSelected: selections[index]),
                          onTap: () {
                            setInnerState(() {
                              selections.setAll(0, [false, false]);
                              selections[index] = true;
                              controller.text = semesters[index];
                            });
                          },
                        ),
                      ),
                    );
                  });
                },
              )
            : title == 'Academic Year'
                ? Builder(
                    builder: (context) {
                      List<bool> selections = List.generate(
                          facultyToLevels[faculty]!.length, (index) => false);
                      List<String> levels = facultyToLevels[faculty]!;
                      return StatefulBuilder(builder: (ctx, setInnerState) {
                        return Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: List.generate(
                              facultyToLevels[faculty]!.length,
                              (index) => GestureDetector(
                                    child: ToggleContainer(
                                        title: levels[index],
                                        isSelected: selections[index]),
                                    onTap: () {
                                      setInnerState(() {
                                        selections.setAll(
                                            0,
                                            List.generate(
                                                facultyToLevels[faculty]!
                                                    .length,
                                                (index) => false));

                                        selections[index] = true;
                                        controller.text = levels[index];
                                      });
                                    },
                                  )),
                        );
                      });
                    },
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          fillColor: Colors.grey[100],
                          filled: true,
                          hintText: 'Your New $title',
                        ),
                      ),
                    ],
                  ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(controller.text);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}

class ToggleContainer extends StatelessWidget {
  ToggleContainer({super.key, required this.title, required this.isSelected});
  final String title;
  bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.indigo[200] : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? Colors.indigo : Colors.grey[300]!,
          width: 2.0,
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}

class DefaultDivider extends StatelessWidget {
  const DefaultDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey[300],
      height: 1.0,
    );
  }
}

Widget buildStudentAttendItem() => Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                MiniTitle(
                  title: "Student name",
                ),
                Spacer(),
                MiniTitle(title: 'ID: 190900013'),
              ],
            ),
          ],
        ),
      ),
    );
