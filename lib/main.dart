import 'package:attendance_tracker/helpers/cache_helper.dart';
import 'package:attendance_tracker/helpers/dio_helper.dart';
import 'package:attendance_tracker/layout/cubit/cubit.dart';
import 'package:attendance_tracker/layout/layout_screen.dart';
import 'package:attendance_tracker/modules/home_screen/home_screen.dart';
import 'package:attendance_tracker/modules/instructor_home/instructor_cubit/instructor_cubit.dart';
import 'package:attendance_tracker/modules/instructor_home/instructor_home_screen.dart';
import 'package:attendance_tracker/modules/instructor_lecture/instructor_lecture_screen.dart';
import 'package:attendance_tracker/modules/instructor_subjects/instructor_subjects_screen.dart';
import 'package:attendance_tracker/modules/login_screen/login_screen.dart';
import 'package:attendance_tracker/modules/on_boarding_screen/on_boarding_screen.dart';
import 'package:attendance_tracker/shared/bloc_observer.dart';
import 'package:attendance_tracker/shared/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  setStudentData();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AppCubit()..getRegisteredSubjects(),
      ),
      BlocProvider(
        create: (context) => InstructorCubit(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final bool isOnboardingFinished =
      CacheHelper.getData('isOnboardingFinished') ?? false;
  final bool isLoggedIn = CacheHelper.getData('isLoggedIn') ?? false;

  late final Widget startWidget = !isOnboardingFinished
      ? OnBoardingScreen()
      : !isLoggedIn
          ? LoginScreen()
          : LayoutScreen();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Attendance tracker',
      theme: ThemeData(
        fontFamily: 'OpenSans',
        primarySwatch: Colors.indigo,
      ),
      home: InstructorSubjectScreen(),
    );
  }
}
