import 'dart:io';

import 'package:attendance_tracker/models/instructor_lecture_model.dart';
import 'package:attendance_tracker/modules/instructor_home_screen/instructor_cubit/instructor_states.dart';
import 'package:attendance_tracker/shared/component.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:excel/excel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

import '../../../helpers/dio_helper.dart';
import '../../../models/instructor_subject_model.dart';
import '../../../shared/end_points.dart';
import '../../../shared/user_data.dart';

class InstructorCubit extends Cubit<InstructorStates> {
  InstructorCubit() : super(InstructorInitState());

  static InstructorCubit get(context) => BlocProvider.of(context);

  double lecturePosition = 0.0;

  void changeNextLecture(int index) {
    lecturePosition = index.toDouble();
    emit(ChangeNextLectureState());
  }

  void getSubjects() {
    getNextLectures();
    getInstructorSubjects();
  }

  bool isGettingLectures = false;
  List<InstructorNextLectureModel> nextLectures = [];

  Future<void> getNextLectures() async {
    isGettingLectures = true;
    emit(GetNextLecturesLoadingState());
    DioHelper.getData(
            url: INSTRUCTOR_NEXT_LECTURES, token: 'Bearer $INSTRUCTOR_TOKEN')
        .then((Response response) {
      nextLectures = [];
      response.data.forEach((lecture) {
        nextLectures.add(InstructorNextLectureModel.fromMap(lecture));
      });
      isGettingLectures = false;
      emit(GetNextLecturesSuccessState());
    }).catchError((e) {
      isGettingLectures = false;
      emit(GetNextLecturesErrorState());
    });
  }

  List<InstructorSubjectModel> instructorSubjects = [];
  bool isGettingSubjects = false;

  Future<void> getInstructorSubjects() async {
    emit(GetInstructorSubjectsLoadingState());
    isGettingSubjects = true;

    DioHelper.getData(
            url: INSTRUCTOR_SUBJECT, token: 'Bearer $INSTRUCTOR_TOKEN')
        .then((Response response) {
      instructorSubjects = [];
      response.data['subjects'].forEach((subject) {
        instructorSubjects.add(InstructorSubjectModel.fromMap(subject));
      });
      isGettingSubjects = false;
      emit(GetInstructorSubjectsSuccessState());
    }).catchError((e) {
      isGettingSubjects = false;
      emit(GetInstructorSubjectsErrorState());
    });
  }

  List<InstructorLectureModel> lecturesOfSubject = [];
  bool isGettingLecturesOfSubject = false;

  Future<void> getLecturesOfSubject(id) async {
    emit(GetLecturesOfSubjectLoadingState());
    isGettingLecturesOfSubject = true;
    final url = '$INSTRUCTOR_SUBJECT_QUERIES/$id/lectures';

    DioHelper.getData(url: url, token: 'Bearer $INSTRUCTOR_TOKEN')
        .then((Response response) {
      lecturesOfSubject = [];
      response.data.forEach((lecture) {
        lecturesOfSubject.add(InstructorLectureModel.fromMap(lecture));
      });
      isGettingLecturesOfSubject = false;
      emit(GetLecturesOfSubjectSuccessState());
    }).catchError((e) {
      isGettingLecturesOfSubject = false;
      emit(GetLecturesOfSubjectErrorState());
    });
  }

  List<Map> activeStudents = [];
  bool isGettingActiveStudents = false;

  Future<void> getSubjectActiveStudents(id) async {
    emit(GetSubjectActiveStudentsLoadingState());
    activeStudents = [];
    isGettingActiveStudents = true;
    final url = '$INSTRUCTOR_SUBJECT_QUERIES/$id/students';

    DioHelper.getData(url: url, token: 'Bearer $INSTRUCTOR_TOKEN')
        .then((Response response) {
      activeStudents.clear();
      response.data.forEach((student) {
        activeStudents.add({
          'name': student['student']['name'],
          'studentId': student['student']['studentId'].toString(),
        });
      });
      isGettingActiveStudents = false;
      emit(GetSubjectActiveStudentsSuccessState());
    }).catchError((e) {
      isGettingActiveStudents = false;
      emit(GetSubjectActiveStudentsErrorState());
    });
  }

  List<Map> lectureAttendees = [];
  bool isGettingAttendees = false;

  Future<void> getLectureAttendees(id) async {
    emit(GetLecturesAttendeesLoadingState());
    lectureAttendees = [];
    isGettingAttendees = true;
    final url = '$INSTRUCTOR_SUBJECT_QUERIES/lectures/$id/attendance';

    DioHelper.getData(url: url, token: 'Bearer $INSTRUCTOR_TOKEN')
        .then((Response response) {
      lectureAttendees.clear();
      response.data.forEach((student) {
        lectureAttendees.add({
          'name': student['name'],
          'studentId': student['studentId'].toString(),
        });
      });
      isGettingAttendees = false;
      emit(GetLecturesAttendeesSuccessState());
    }).catchError((e) {
      isGettingAttendees = false;
      emit(GetLecturesAttendeesErrorState());
    });
  }

  late bool isLectureCreated;

  Future<void> createLecture({
    required String subjectId,
    required String name,
    required String location,
    required String date,
    required String type,
  }) async {
    await DioHelper.postData(
      url: INSTRUCTOR_ADD_LECTURE,
      token: 'Bearer $INSTRUCTOR_TOKEN',
      data: {
        'subjectId': subjectId,
        'name': name,
        'location': location,
        'date': date,
        'type': type,
      },
    ).then((Response response) {
      isLectureCreated = true;
      getLecturesOfSubject(subjectId);
      getNextLectures();
      emit(CreateLectureSuccessState());
    }).catchError((e) {
      isLectureCreated = false;
      emit(CreateLectureErrorState());
    });
  }

  bool isFocused = false;

  void toggleSearch(bool toggle) {
    isFocused = toggle;
    emit(ToggleSearchState());
  }

  late List<InstructorSubjectModel> filteredSubjects = instructorSubjects;

  List<Map> filteredStudents = [];

  void searchSubjects(String query) {
    filteredSubjects = [];
    for (var subject in instructorSubjects) {
      if (subject.name.toLowerCase().contains(query.toLowerCase())) {
        filteredSubjects.add(subject);
      }
    }
    emit(SearchSubjectState());
  }

  void searchStudent(String query, bool isAttendance) {
    filteredStudents = [];
    if (isAttendance) {
      for (var student in lectureAttendees) {
        if (student['name'].toLowerCase().contains(query.toLowerCase()) ||
            student['studentId'].contains(query)) {
          filteredStudents.add(student);
        }
      }
    } else {
      for (var student in activeStudents) {
        if (student['name'].toLowerCase().contains(query.toLowerCase()) ||
            student['studentId'].contains(query)) {
          filteredStudents.add(student);
        }
      }
    }
    emit(SearchStudentState());
  }

  Future<void> createAttendanceExcel(
      List<Map<dynamic, dynamic>> students, lectureName, lectureDate) async {
    try {
      final Excel excel = Excel.createExcel();

      excel.rename('Sheet1', 'Attendance');
      final Sheet sheet = excel['Attendance'];

      final List<String> headers = ['Student Name', 'Student ID'];
      sheet.appendRow(headers);

      for (final student in students) {
        final List<String> rowData = [
          student['name'],
          student['studentId'],
        ];
        sheet.appendRow(rowData);
      }

      final Directory root = Directory('/storage/emulated/0/');

      const String customDirectoryName = 'SU Attendance';
      final Directory customDirectory =
          Directory(path.join(root.path, customDirectoryName));

      if (await _hasAcceptedPermissions()) {
        if (!await customDirectory.exists()) {
          await customDirectory.create();
        }

        final String fileName = '$lectureName - $lectureDate- attendance.xlsx';

        final String filePath = path.join(customDirectory.path, fileName);

        final File file = File(filePath);

        await file.writeAsBytes(excel.encode()!);
        showDefaultToast('Excel file created: $filePath');
        emit(ExtractStudentsSuccessState());
      }
    } catch (e) {
      showDefaultToast('Error happened while creating excel file');
      emit(ExtractStudentsErrorState());
    }
  }

  Future<bool> _hasAcceptedPermissions() async {
    if (Platform.isAndroid) {
      if (await _requestPermission(Permission.storage) &&
          await _requestPermission(Permission.accessMediaLocation)) {
        var androidInfo = await DeviceInfoPlugin().androidInfo;
        if (androidInfo.version.sdkInt >= 30) {
          return await _requestPermission(Permission.manageExternalStorage);
        }
        return true;
      } else {
        return false;
      }
    }
    if (Platform.isIOS) {
      if (await _requestPermission(Permission.photos)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  _requestPermission(Permission permission) async {
    return await permission.request().isGranted;
  }

  void logout() {
    lecturePosition = 0.0;
    nextLectures = [];
    instructorSubjects = [];
    emit(LogoutState());
  }
}
