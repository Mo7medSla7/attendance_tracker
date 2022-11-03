import 'package:attendance_tracker/helpers/dio_helper.dart';
import 'package:attendance_tracker/models/student_model.dart';
import 'package:attendance_tracker/shared/component.dart';
import 'package:attendance_tracker/shared/end_points.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  List<String> faculties = [
    'Faculty of medicine',
    'Faculty of Computing and Information',
    'Faculty of Engineering',
  ];
  String? selectedFaculty;

  List<String> levels = [
    'Preparatory',
    'One',
    'Two',
    'Three',
    'Four',
    'Five',
    'Six',
    'Seven',
  ];
  String? selectedLevel;

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var idController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isFacultyAndLevelSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black, size: 30),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const HeaderTitle(title: 'Sign up'),
                const SizedBox(height: 40),
                DefaultFormField(
                  hintText: 'Student Name',
                  controller: nameController,
                  errorMessage: 'Student Name',
                ),
                const SizedBox(height: 15),
                DefaultFormField(
                  hintText: 'Student Email',
                  controller: emailController,
                  errorMessage: 'Student Email',
                ),
                const SizedBox(height: 15),
                DefaultFormField(
                  hintText: 'Student ID',
                  controller: idController,
                  errorMessage: 'Student ID',
                ),
                const SizedBox(height: 15),
                buildDropDownMenus(),
                if (isFacultyAndLevelSelected) const SizedBox(height: 20),
                if (!isFacultyAndLevelSelected)
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 14,
                        bottom: 15,
                        top: 8,
                      ),
                      child: Text(
                        'Faculty and Level must be chosen',
                        style: TextStyle(color: Colors.red[800], fontSize: 12),
                      ),
                    ),
                  ),
                FullWidthElevatedButton(
                  text: 'Sign up',
                  onTap: () {
                    if (selectedFaculty != null && selectedLevel != null) {
                      setState(() {
                        isFacultyAndLevelSelected = true;
                      });
                      if (formKey.currentState!.validate()) {
                        signUp();
                      }
                    } else {
                      setState(() {
                        formKey.currentState!.validate();
                        isFacultyAndLevelSelected = false;
                      });
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDropDownMenus() => Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black54,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[100],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  hint: const Text('Faculty'),
                  isExpanded: true,
                  items: faculties
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
                      selectedFaculty = item!;
                    });
                  },
                  value: selectedFaculty,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black54,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[100],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  hint: const Text('Level'),
                  isExpanded: true,
                  items: levels
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
                      selectedLevel = item!;
                    });
                  },
                  value: selectedLevel,
                ),
              ),
            ),
          ),
        ],
      );

  void signUp() {
    var student = StudentModel(
      name: nameController.text,
      email: emailController.text,
      studentId: num.parse(idController.text),
      faculty: selectedFaculty!,
      academicYear: selectedLevel!,
      password: idController.text,
      semester: 'one',
    ).toMap();
    DioHelper.postData(url: SIGN_UP, data: student)
        .then((value) => print(value.data))
        .catchError((error) {
      print(error.toString());
    });
  }
}
