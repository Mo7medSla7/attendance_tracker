import 'package:attendance_tracker/helpers/dio_helper.dart';
import 'package:attendance_tracker/models/student_model.dart';
import 'package:attendance_tracker/modules/sign_up_screen/sign_up_screen.dart';
import 'package:attendance_tracker/shared/component.dart';
import 'package:attendance_tracker/shared/end_points.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  var emailController = TextEditingController();
  var idController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          width: double.infinity,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                    height: 130,
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPHRvtFUvNT9Rrpz2HE4gu05hPPg8m7DweCg&usqp=CAU'),
                const SizedBox(height: 30),
                const HeaderTitle(title: 'LOGIN'),
                const SizedBox(height: 40),
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
                const SizedBox(height: 20),
                FullWidthElevatedButton(
                  text: 'Login',
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      login();
                    }
                  },
                ),
                const SizedBox(height: 20),
                buildLoginDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Create new account',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ),
                        );
                      },
                      child: const Text('Sign Up'),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoginDivider() => Row(
        children: [
          Expanded(
            child: Container(
              height: 2,
              color: Colors.grey,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'or',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Container(
              height: 2,
              color: Colors.grey,
            ),
          )
        ],
      );

  void login() {
    //mosalah@mail.com
    //1369878469
    DioHelper.postData(
      url: LOGIN,
      data: {'email': emailController.text, 'password': idController.text},
    ).then((value) {
      var model = StudentModel.fromMap(value.data);
      print(model.name);
      print(model.password);
      print(model.academicYear);
      print(model.email);
      print(model.faculty);
      print(model.semester);
      print(model.studentId);
    }).catchError((error) {
      print(error.toString());
    });
  }
}
