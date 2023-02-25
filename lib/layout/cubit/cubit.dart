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
import '../../modules/profile_screen/profile_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Text> titles = const [
    Text('Home'),
    Text('Subjects'),
    Text('Profile'),
  ];
  List<Widget> screens = const [
    Home_Screen(),
    Subject_Screen(),
    ProfileScreen(),
  ];

  void changeNavBar(int index) {
    currentIndex = index;
    emit(ChangeNavBarState());
    if (index == 1 &&
        (subjectsForRegister.isEmpty) &&
        (registeredSubjects.isEmpty)) {
      getSubjects();
    }
  }

  getSubjects() {
    getRegisteredSubjects();
    getSubjectsToRegister();
  }

  refreshSubjects() async {
    subjectsForRegister = [];
    registeredSubjects = [];
    await getSubjects();
    emit(RefreshSubjectsState());
  }

  List<SubjectModel> subjectsForRegister = [];

  getSubjectsToRegister() {
    emit(GetSubjectsToRegisterLoadingState());
    DioHelper.getData(url: SUBJECTS, token: 'Bearer $STUDENT_TOKEN')
        .then((Response response) {
      response.data['subjects'].forEach((subject) {
        var selectedSubject = SubjectModel.fromMap(subject);
        bool isExist = registeredSubjects
            .any((subject) => subject.id == selectedSubject.id);
        if (!isExist) {
          subjectsForRegister.add(selectedSubject);
        }
      });
      emit(GetSubjectsToRegisterSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(GetSubjectsToRegisterErrorState());
    });
  }

  List<SubjectModel> registeredSubjects = [];

  getRegisteredSubjects() {
    emit(GetRegisteredSubjectsLoadingState());
    DioHelper.getData(
            url: ALL_REGISTERED_SUBJECTS, token: 'Bearer $STUDENT_TOKEN')
        .then((Response response) {
      // registeredSubjects = [];
      response.data.forEach(
          (subject) => registeredSubjects.add(SubjectModel.fromMap(subject)));
      emit(GetRegisteredSubjectsSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(GetRegisteredSubjectsErrorState());
    });
  }

  filterSubjectsForRegister() {}

  List<String> subjectsIdToRegister = [];
  List<bool> checkStates = [];

  addSubject(String id, int index) {
    subjectsIdToRegister.add(id);
    checkStates[index] = true;
    emit(AddOrRemoveSubjectToRegisterState());
  }

  removeSubject(String id, int index) {
    subjectsIdToRegister.remove(id);
    checkStates[index] = false;
    emit(AddOrRemoveSubjectToRegisterState());
  }

  registerSubject(String subjectId) {
    emit(RegisterSubjectLoadingState());
    DioHelper.postData(
      url: REGISTER_SUBJECT,
      data: {'subjectId': subjectId},
      token: 'Bearer $STUDENT_TOKEN',
    ).then((value) {
      getRegisteredSubjects();
      emit(RegisterSubjectSuccessState());
    }).catchError((e) {
      print(e.response.data);
      emit(RegisterSubjectErrorState());
    });
  }

  sendSubjectsToRegister() {
    for (String subjectId in subjectsIdToRegister) {
      try {
        registerSubject(subjectId);
      } catch (err) {
        print(err.toString());
      }
    }
  }
}
