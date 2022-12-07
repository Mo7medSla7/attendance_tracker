import 'package:attendance_tracker/helpers/dio_helper.dart';
import 'package:attendance_tracker/layout/cubit/states.dart';
import 'package:attendance_tracker/models/subject_model.dart';
import 'package:attendance_tracker/shared/end_points.dart';
import 'package:attendance_tracker/shared/user_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/home_screen/home_screen.dart';
import '../../modules/subjects_screen/subject_screen.dart';
import '../../modules/test_screen/test_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 1;

  List<Text> titles = const [
    Text('Subjects'),
    Text('Home'),
    Text('Test'),
  ];
  List<Widget> screens = [
    Subject_Screen(),
    Home_Screen(),
    Test_Screen(),
  ];

  void changeNavBar(int index) {
    currentIndex = index;
    emit(ChangeNavBarState());
    if (index == 0 && subjectsForRegister.isEmpty) {
      getSubjectsForRegister();
    }
  }

  List<SubjectModel> subjectsForRegister = [];

  getSubjectsForRegister() {
    emit(GetSubjectsForRegisterLoadingState());
    DioHelper.getData(url: SUBJECTS, token: 'Bearer $STUDENT_TOKEN')
        .then((Response response) {
      response.data['subjects'].forEach(
          (subject) => subjectsForRegister.add(SubjectModel.fromMap(subject)));
      emit(GetSubjectsForRegisterSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(GetSubjectsForRegisterErrorState());
    });
  }
}
