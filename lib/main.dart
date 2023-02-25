import 'package:attendance_tracker/helpers/cache_helper.dart';
import 'package:attendance_tracker/helpers/dio_helper.dart';
import 'package:attendance_tracker/layout/cubit/cubit.dart';
import 'package:attendance_tracker/layout/layout_screen.dart';
import 'package:attendance_tracker/modules/home_screen/home_screen.dart';
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
  runApp(BlocProvider(
    create: (context) => AppCubit()..getSubjects(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  bool isOnboardingFinished =
      CacheHelper.getData('isOnboardingFinished') ?? false;
  bool isLoggedIn = CacheHelper.getData('isLoggedIn') ?? false;

  late Widget startWidget = !isOnboardingFinished
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
      home: startWidget,
    );
  }
}
