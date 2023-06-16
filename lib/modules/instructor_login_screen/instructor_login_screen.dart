import 'package:attendance_tracker/helpers/cache_helper.dart';
import 'package:attendance_tracker/helpers/dio_helper.dart';
import 'package:attendance_tracker/modules/instructor_home_screen/instructor_home_screen.dart';
import 'package:attendance_tracker/shared/end_points.dart';
import 'package:flutter/material.dart';

import '../../shared/component.dart';
import '../../shared/user_data.dart';
import '../instructor_home_screen/instructor_cubit/instructor_cubit.dart';

class InstructorLoginScreen extends StatefulWidget {
  const InstructorLoginScreen({Key? key}) : super(key: key);

  @override
  State<InstructorLoginScreen> createState() => _InstructorLoginScreenState();
}

class _InstructorLoginScreenState extends State<InstructorLoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  bool isLoading = false;

  String errorMessage = '';

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
        padding: const EdgeInsets.only(top: 100),
        child: Container(
          margin: const EdgeInsets.all(20),
          width: double.infinity,
          child: Form(
            key: formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: HeaderTitle(title: 'Login'),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Subtitle(title: 'As Instructor', color: Colors.grey[600]),
                  const SizedBox(height: 15),
                  DefaultFormField(
                    hintText: 'Instructor Email',
                    controller: emailController,
                    errorMessage: 'Student Email',
                    icon: Icons.email,
                  ),
                  const SizedBox(height: 15),
                  DefaultFormField(
                    hintText: 'Password',
                    controller: passwordController,
                    errorMessage: 'Password',
                    isPassword: true,
                    icon: Icons.lock,
                  ),
                  const SizedBox(height: 15),
                  isLoading
                      ? const CircularProgressIndicator()
                      : FullWidthElevatedButton(
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login(context) {
    FocusScope.of(context).unfocus();

    setState(() {
      isLoading = true;
    });
    DioHelper.postData(
      url: INSTRUCTOR_LOGIN,
      data: {
        'email': emailController.text,
        'password': passwordController.text
      },
    ).then((value) {
      CacheHelper.putData(key: 'INSTRUCTOR_TOKEN', value: value.data['token']);
      CacheHelper.putData(key: 'isLoggedIn', value: true);
      CacheHelper.putData(key: 'isInstructor', value: true);
      setInstructorData();
      InstructorCubit.get(context).getSubjects();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const InstructorHomeScreen(),
          ),
          (route) => false);
    }).catchError((error) {
      setState(() {
        isLoading = false;
        errorMessage = error.response.data['message'].toString();
      });
    });
  }
}
