import 'dart:async';

import 'package:attendance_tracker/helpers/dio_helper.dart';
import 'package:attendance_tracker/layout/cubit/states.dart';
import 'package:attendance_tracker/models/lecture_model.dart';
import 'package:attendance_tracker/models/subject_model.dart';
import 'package:attendance_tracker/shared/component.dart';
import 'package:attendance_tracker/shared/end_points.dart';
import 'package:attendance_tracker/shared/user_data.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helpers/cache_helper.dart';
import '../../models/students_statistics_model.dart';
import '../../modules/home_screen/home_screen.dart';
import '../../modules/my_subjects_screen/my_subject_screen.dart';
import '../../modules/subject_search_screen/subject_search_screen.dart';
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
    Text('Level Subjects'),
    Text('My Subjects'),
    Text('Profile'),
  ];
  List<Widget> screens = [
    const HomeScreen(),
    const SubjectScreen(),
    const MySubjectsScreen(),
    const ProfileScreen(),
  ];

  late List<Widget?> floatingButtons = [
    null,
    FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SubjectSearchScreen(),
        ));
      },
      child: const Icon(Icons.manage_search, size: 26),
    ),
    null,
    FloatingActionButton(
      onPressed: () {
        enableEdit();
      },
      child: const Icon(Icons.edit, size: 26),
    ),
  ];

  void getSubjects() {
    getSubjectsStats();
    getNextLectures();
    getMySubjects();
    getRegisteredSubjects();
  }

  bool isGettingLectures = false;
  List<LectureModel> nextLectures = [];

  Future<void> getNextLectures() async {
    isGettingLectures = true;
    emit(GetNextLecturesLoadingState());
    DioHelper.getData(url: NEXT_LECTURES, token: 'Bearer $STUDENT_TOKEN')
        .then((Response response) {
      nextLectures = [];
      response.data.forEach((lecture) {
        nextLectures.add(LectureModel.fromMap(lecture));
      });
      isGettingLectures = false;
      emit(GetNextLecturesSuccessState());
    }).catchError((e) {
      isGettingLectures = false;
      emit(GetNextLecturesErrorState());
    });
  }

  bool isGettingLecturesOfSubject = false;
  List<LectureModel> lecturesOfSubject = [];

  String attendedLecture = '0';
  String allLectures = '0';
  String attendanceProgress = 'NaN';

  Future<void> getLecturesOfSubjects(id) async {
    lecturesOfSubject = [];
    isGettingLecturesOfSubject = true;
    emit(GetLecturesOfSubjectLoadingState());
    DioHelper.getData(url: '$LECTURES$id', token: 'Bearer $STUDENT_TOKEN')
        .then((Response response) {
      response.data.forEach((lecture) {
        lecturesOfSubject.add(LectureModel.fromMap(lecture));
      });
      isGettingLecturesOfSubject = false;
      attendedLecture = lecturesOfSubject
          .where((lecture) => lecture.hasAttended == true)
          .length
          .toString();
      allLectures = lecturesOfSubject.length.toString();
      attendanceProgress =
          (int.parse(attendedLecture) / int.parse(allLectures) * 100)
              .toStringAsFixed(0);

      emit(GetLecturesOfSubjectSuccessState());
    }).catchError((e) {
      isGettingLecturesOfSubject = false;
      emit(GetLecturesOfSubjectErrorState());
    });
  }

  bool isGettingSubjectsStats = false;
  List<StudentStatisticsModel> subjectsStats = [];

  Future<void> getSubjectsStats() async {
    subjectsStats = [];
    isGettingSubjectsStats = true;
    emit(GetSubjectsStatsLoadingState());
    DioHelper.getData(url: STATS, token: 'Bearer $STUDENT_TOKEN')
        .then((Response response) {
      response.data.forEach((stats) {
        subjectsStats.add(StudentStatisticsModel.formMap(stats));
      });
      isGettingSubjectsStats = false;
      emit(GetSubjectsStatsSuccessState());
    }).catchError((e) {
      isGettingSubjectsStats = false;
      emit(GetSubjectsStatsErrorState());
    });
  }

  bool isGettingMySubjects = false;
  List<SubjectModel> mySubjects = [];

  Future<void> getMySubjects() async {
    isGettingMySubjects = true;
    emit(GetMySubjectsLoadingState());
    DioHelper.getData(url: REGISTERED_SUBJECTS, token: 'Bearer $STUDENT_TOKEN')
        .then((Response response) {
      mySubjects = [];
      response.data.forEach((subject) {
        mySubjects.add(SubjectModel.fromMap(subject));
      });
      isGettingMySubjects = false;
      emit(GetMySubjectsSuccessState());
    }).catchError((e) {
      isGettingMySubjects = false;
      emit(GetMySubjectsErrorState());
    });
  }

  Future<String> getDeviceId() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.androidInfo;
    final deviceId = deviceInfo.id;
    return deviceId;
  }

  bool isEnabled = false;

  void enableEdit() {
    isEnabled = !isEnabled;
    emit(EnableEditState());
  }

  bool isEdited = false;
  Future<void> editProfile(String fieldToEdit, String newValue) async {
    await DioHelper.putData(
        url: EDIT,
        token: 'Bearer $STUDENT_TOKEN',
        data: {fieldToEdit: newValue}).then((value) {
      isEdited = true;
      switch (fieldToEdit) {
        case 'name':
          STUDENT_NAME = newValue;
          CacheHelper.putData(key: 'STUDENT_NAME', value: newValue);
          break;

        case 'email':
          STUDENT_EMAIL = newValue;
          CacheHelper.putData(key: 'STUDENT_EMAIL', value: newValue);
          break;

        case 'year':
          STUDENT_ACADEMIC_YEAR = newValue;
          CacheHelper.putData(key: 'STUDENT_ACADEMIC_YEAR', value: newValue);
          break;

        case 'semester':
          STUDENT_SEMESTER = newValue;
          CacheHelper.putData(key: 'STUDENT_SEMESTER', value: newValue);
      }
      enableEdit();
      getRegisteredSubjects();
      emit(EditProfileSuccessState());
    }).catchError((e) {
      isEdited = false;
      emit(EditProfileErrorState());
    });
  }

  int currentIndex = 0;
  void changeNavBar(int index) {
    currentIndex = index;
    lecturePosition = 0.0;
    isEnabled = false;

    if (index == 0 && nextLectures.isEmpty && subjectsStats.isEmpty) {
      getSubjectsStats();
      getNextLectures();
    }
    if (index == 1 &&
        subjectsToRegister.isEmpty &&
        registeredSubjects.isEmpty) {
      getRegisteredSubjects();
    }
    if (index == 2 && mySubjects.isEmpty) {
      getMySubjects();
    }
    emit(ChangeNavBarState());
  }

  double lecturePosition = 0.0;
  void changeNextLecture(int index) {
    lecturePosition = index.toDouble();
    emit(ChangeNextLectureState());
  }

  bool isLecture = true;
  void changeStatsMode(bool newVal) {
    isLecture = newVal;
    emit(ChangeStatsModeState());
  }

  refreshSubjects() async {
    await getRegisteredSubjects();
    await getMySubjects();
    emit(RefreshSubjectsState());
  }

  List<SubjectModel> subjectsToRegister = [];
  List<SubjectModel> registeredSubjects = [];
  bool isGettingSubjects = false;

  Future<void> getRegisteredSubjects() async {
    emit(GetRegisteredSubjectsLoadingState());
    isGettingSubjects = true;
    DioHelper.getData(url: SUBJECTS, token: 'Bearer $STUDENT_TOKEN')
        .then((Response response) {
      registeredSubjects.clear();
      subjectsToRegister.clear();
      response.data.forEach((subject) {
        if (subject['isRegistered']) {
          registeredSubjects.add(SubjectModel.fromMap(subject));
        } else {
          subjectsToRegister.add(SubjectModel.fromMap(subject));
        }
      });
      isGettingSubjects = false;
      emit(GetRegisteredSubjectsSuccessState());
    }).catchError((e) {
      isGettingSubjects = false;
      emit(GetRegisteredSubjectsErrorState());
    });
  }

  late bool qrSuccessScan;

  Future<void> qrScan(String decodedQr, String lectureId) async {
    final deviceId = await getDeviceId();

    await DioHelper.postData(
      url: SCAN,
      token: 'Bearer $STUDENT_TOKEN',
      data: {
        'qr': decodedQr,
        'deviceId': deviceId,
        'lectureId': lectureId,
      },
    ).then((Response response) {
      qrSuccessScan = true;
      emit(QrScanSuccessState());
    }).catchError((e) {
      qrSuccessScan = false;
      emit(QrScanErrorState());
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

  registerSubject(String subjectId, bool fromSearch) {
    emit(RegisterSubjectLoadingState());
    DioHelper.postData(
      url: REGISTER_SUBJECT,
      data: {'subjectId': subjectId},
      token: 'Bearer $STUDENT_TOKEN',
    ).then((value) {
      if (!fromSearch) {
        registeredSubjects.add(subjectsToRegister
            .firstWhere((subject) => subject.id == subjectId));
        subjectsToRegister.removeWhere((subject) => subject.id == subjectId);
      }
      emit(RegisterSubjectSuccessState());
    }).catchError((e) {
      emit(RegisterSubjectErrorState());
    });
  }

  sendSubjectsToRegister(bool fromSearch) async {
    for (String subjectId in subjectsIdToRegister) {
      try {
        registerSubject(subjectId, fromSearch);
      } catch (err) {
        err.toString();
      }
    }
    subjectsIdToRegister = [];
    checkStates = [];
    await getRegisteredSubjects();
    await getMySubjects();

    emit(RegisterAllSubjectState());
  }

  bool isFocused = false;

  void toggleSearch(bool toggle) {
    isFocused = toggle;
    emit(ToggleSearchState());
  }

  bool isSearching = false;
  List<SubjectModel> searchedSubjects = [];

  Future<void> subjectSearch(String query) async {
    isSearching = true;
    searchedSubjects = [];
    emit(SubjectsSearchLoadingState());
    var url = '$SEARCH?searchQuery=$query';
    DioHelper.getData(url: url, token: 'Bearer $STUDENT_TOKEN')
        .then((Response response) {
      if (response.data.isEmpty) {
        showDefaultToast('No subjects found');
        emit(SubjectsSearchSuccessState());
        isSearching = false;
        return;
      }
      response.data.forEach((subject) {
        searchedSubjects.add(SubjectModel.fromMap(subject));
      });
      isSearching = false;
      emit(SubjectsSearchSuccessState());
    }).catchError((e) {
      isSearching = false;
      emit(SubjectsSearchErrorState());
    });
  }

  void logout() {
    currentIndex = 0;
    lecturePosition = 0.0;
    subjectsToRegister = [];
    registeredSubjects = [];
    nextLectures = [];
    subjectsStats = [];
    subjectsIdToRegister = [];
    checkStates = [];
    emit(LogoutState());
  }
}
