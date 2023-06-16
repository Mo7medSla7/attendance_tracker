import 'dart:async';

import 'package:attendance_tracker/helpers/cache_helper.dart';
import 'package:attendance_tracker/helpers/dio_helper.dart';
import 'package:attendance_tracker/layout/cubit/cubit.dart';
import 'package:attendance_tracker/layout/layout_screen.dart';
import 'package:attendance_tracker/models/student_model.dart';
import 'package:attendance_tracker/modules/instructor_login_screen/instructor_login_screen.dart';
import 'package:attendance_tracker/modules/sign_up_screen/sign_up_screen.dart';
import 'package:attendance_tracker/shared/component.dart';
import 'package:attendance_tracker/shared/end_points.dart';
import 'package:attendance_tracker/shared/user_data.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../no_internet_screen/no_internet_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  bool isLoading = false;

  String errorMessage = '';

  var formKey = GlobalKey<FormState>();

  late Connectivity _connectivity;
  late StreamSubscription<ConnectivityResult> _subscription;

  @override
  void initState() {
    super.initState();

    _connectivity = Connectivity();
    _subscription = _connectivity.onConnectivityChanged.listen((event) {
      setState(() {
        if (event == ConnectivityResult.none) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const NoInternetScreen()),
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.all(20),
            width: double.infinity,
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child:
                        Image.asset(height: 200, 'assets/images/app_logo.png'),
                  ),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: HeaderTitle(title: 'Welcome'),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: SubBody(
                          text: 'Login to your account',
                          color: Colors.grey[600]),
                    ),
                  ),
                  const SizedBox(height: 40),
                  DefaultFormField(
                    hintText: 'Student Email',
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
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                          )
                              .then((value) {
                            if (value != null) {
                              emailController.text = value['email'];
                              passwordController.text = value['password'];
                            }
                          });
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  /*const SizedBox(height: 8,),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Are you instructor ?  ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(40, 20),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const InstructorLoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Login as instructor',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ],
              ),
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
    FocusScope.of(context).unfocus();
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
      AppCubit.get(context).getSubjects();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const LayoutScreen(),
      ));
    }).catchError((error) {
      setState(() {
        isLoading = false;
        errorMessage = error.response.data['message'];
      });
    });
  }
}
