import 'package:attendance_tracker/modules/login_screen/login_screen.dart';
import 'package:flutter/material.dart';

import '../../shared/component.dart';

class InstructorLoginScreen extends StatefulWidget {
  const InstructorLoginScreen({Key? key}) : super(key: key);

  @override
  State<InstructorLoginScreen> createState() => _InstructorLoginScreenState();
}

class _InstructorLoginScreenState extends State<InstructorLoginScreen> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black, size: 30),
      ),
      backgroundColor: Colors.white,
      body:Container(
        margin: const EdgeInsets.all(20),
        width: double.infinity,
        child: Form(
          key: formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HeaderTitle(title: 'Login'),
                ),
                SizedBox(height: 8,),
                Subtitle(
                    title: 'As Instructor', color: Colors.grey[600]),
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
                FullWidthElevatedButton(
                    text: 'Login',
                    onTap: () {
                      if (formKey.currentState!.validate()) {

                      }
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
