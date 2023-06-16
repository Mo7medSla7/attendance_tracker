import 'package:attendance_tracker/helpers/cache_helper.dart';
import 'package:attendance_tracker/helpers/dio_helper.dart';
import 'package:attendance_tracker/layout/cubit/cubit.dart';
import 'package:attendance_tracker/layout/layout_screen.dart';
import 'package:attendance_tracker/modules/instructor_home_screen/instructor_cubit/instructor_cubit.dart';
import 'package:attendance_tracker/modules/instructor_home_screen/instructor_home_screen.dart';
import 'package:attendance_tracker/modules/login_screen/login_screen.dart';
import 'package:attendance_tracker/modules/on_boarding_screen/on_boarding_screen.dart';
import 'package:attendance_tracker/shared/bloc_observer.dart';
import 'package:attendance_tracker/shared/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'modules/no_internet_screen/no_internet_screen.dart';

void main() async {
  bool connectionResult = await InternetConnectionChecker().hasConnection;
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  setStudentData();
  setInstructorData();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AppCubit()..getSubjects(),
      ),
      BlocProvider(
        create: (context) => InstructorCubit()..getSubjects(),
      ),
    ],
    child: MyApp(connectionResult),
  ));
}

class MyApp extends StatelessWidget {
  MyApp(this.connectionResult, {super.key});

  final bool connectionResult;

  final bool isOnboardingFinished =
      CacheHelper.getData('isOnboardingFinished') ?? false;
  final bool isLoggedIn = CacheHelper.getData('isLoggedIn') ?? false;
  final bool isInstructor = CacheHelper.getData('isInstructor') ?? false;
  late final Widget startWidget = !connectionResult
      ? const NoInternetScreen()
      : !isOnboardingFinished
          ? OnBoardingScreen()
          : !isLoggedIn
              ? const LoginScreen()
              : isInstructor
                  ? const InstructorHomeScreen()
                  : const LayoutScreen();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Attendance tracker',
      theme: ThemeData(
        fontFamily: 'OpenSans',
        primarySwatch: Colors.indigo,
      ),
      home: startWidget,
    );
  }
}
