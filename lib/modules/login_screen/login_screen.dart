import 'package:attendance_tracker/helpers/cache_helper.dart';
import 'package:attendance_tracker/helpers/dio_helper.dart';
import 'package:attendance_tracker/layout/layout_screen.dart';
import 'package:attendance_tracker/models/student_model.dart';
import 'package:attendance_tracker/modules/sign_up_screen/sign_up_screen.dart';
import 'package:attendance_tracker/shared/component.dart';
import 'package:attendance_tracker/shared/end_points.dart';
import 'package:attendance_tracker/shared/user_data.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  bool isLoading = false;

  String errorMessage = '';

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
                  hintText: 'Password',
                  controller: passwordController,
                  errorMessage: 'Password',
                  isPassword: true,
                ),
                const SizedBox(height: 20),
                if (isLoading)
                  const CircularProgressIndicator()
                else
                  FullWidthElevatedButton(
                    text: 'Login',
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        login(context);
                      }
                    },
                  ),
                const SizedBox(height: 8.0),
                Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red[800], fontSize: 16),
                ),
                const SizedBox(height: 8),
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
                        Navigator.of(context)
                            .push(
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ),
                        )
                            .then((value) {
                          if (value != null) {
                            emailController.text = value['email'];
                            passwordController.text = value['password'];
                          }
                        });
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

  void login(context) {
    //mohamedsalah@mail.com
    //987987987987
    setState(() {
      isLoading = true;
    });
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': emailController.text,
        'password': passwordController.text
      },
    ).then((value) {
      var model = StudentModel.fromMap(value.data);
      CacheHelper.putData(key: 'STUDENT_TOKEN', value: value.data['token']);
      CacheHelper.putData(key: 'STUDENT_EMAIL', value: model.email);
      CacheHelper.putData(key: 'STUDENT_NAME', value: model.name);
      CacheHelper.putData(
          key: 'STUDENT_ACADEMIC_YEAR', value: model.academicYear);
      CacheHelper.putData(key: 'STUDENT_FACULTY', value: model.faculty);
      CacheHelper.putData(key: 'STUDENT_SEMESTER', value: model.semester);
      CacheHelper.putData(key: 'STUDENT_ID', value: model.studentId);
      CacheHelper.putData(key: 'isLoggedIn', value: true);
      setStudentData();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LayoutScreen(),
      ));
    }).catchError((error) {
      setState(() {
        isLoading = false;
        errorMessage = error.response.data['message'];
      });
    });
  }
}
