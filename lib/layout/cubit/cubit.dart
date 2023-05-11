import 'dart:async';

import 'package:attendance_tracker/helpers/dio_helper.dart';
import 'package:attendance_tracker/layout/cubit/states.dart';
import 'package:attendance_tracker/models/subject_model.dart';
import 'package:attendance_tracker/shared/end_points.dart';
import 'package:attendance_tracker/shared/user_data.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/home_screen/home_screen.dart';
import '../../modules/scanner_screen/scanner_screen.dart';
import '../../modules/subjects_screen/subject_screen.dart';
import '../../modules/profile_screen/profile_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitState());

  static AppCubit get(context) => BlocProvider.of(context);

  late BuildContext context;

  getContext(ctx) => context = ctx;

  static AppCubit create() => AppCubit();

  List<Text> titles = const [
    Text('Home'),
    Text('Subjects'),
    Text('Profile'),
  ];
  List<Widget> screens = [
    const HomeScreen(),
    const Subject_Screen(),
    ProfileScreen(),
  ];

  late List<Widget> floatingButtons = [
    FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ScannerScreen(),
        ));
      },
      child: const Icon(Icons.qr_code_scanner, size: 26),
    ),
    FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.manage_search, size: 26),
    ),
    FloatingActionButton(
      onPressed: () {
        enableEdit();
      },
      child: const Icon(Icons.edit, size: 26),
    ),
  ];

  void getDeviceId() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.androidInfo;
    final deviceId = deviceInfo.id;
    print(deviceId);
  }

  bool isEnabled = false;

  void enableEdit() {
    isEnabled = !isEnabled;
    emit(EnableEditState());
  }

  int currentIndex = 0;
  void changeNavBar(int index) {
    currentIndex = index;
    if (index == 1 &&
        subjectsToRegister.isEmpty &&
        registeredSubjects.isEmpty) {
      getSubjects();
    }
    emit(ChangeNavBarState());
  }

  double lecturePosition = 0.0;
  void changeNextLecture(int index) {
    lecturePosition = index.toDouble();
    emit(ChangeNextLectureState());
  }

  getSubjects() async {
    subjectsToRegister = [];
    registeredSubjects = [];
    getRegisteredSubjects().then((_) => getSubjectsToRegister());
  }

  refreshSubjects() async {
    await getSubjects();
    emit(RefreshSubjectsState());
  }

  List<SubjectModel> subjectsToRegister = [];

  getSubjectsToRegister() {
    emit(GetSubjectsToRegisterLoadingState());
    DioHelper.getData(url: SUBJECTS, token: 'Bearer $STUDENT_TOKEN')
        .then((Response response) {
      response.data['subjects'].forEach((subject) {
        var selectedSubject = SubjectModel.fromMap(subject);
        bool isExist = registeredSubjects
            .any((subject) => subject.id == selectedSubject.id);
        if (!isExist) {
          subjectsToRegister.add(selectedSubject);
        }
      });
      emit(GetSubjectsToRegisterSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(GetSubjectsToRegisterErrorState());
    });
  }

  List<SubjectModel> registeredSubjects = [];

  Future<void> getRegisteredSubjects() async {
    registeredSubjects = [];

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
      subjectsToRegister.removeWhere((subject) => subject.id == subjectId);
      registeredSubjects = [];
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

  void logout() {
    currentIndex = 0;
    lecturePosition = 0.0;
    subjectsToRegister = [];
    registeredSubjects = [];
    subjectsIdToRegister = [];
    checkStates = [];
    emit(LogoutState());
  }
}
