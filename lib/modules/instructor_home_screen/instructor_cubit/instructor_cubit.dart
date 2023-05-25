import 'dart:io';

import 'package:attendance_tracker/models/instructor_lecture_model.dart';
import 'package:attendance_tracker/modules/instructor_home_screen/instructor_cubit/instructor_states.dart';
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
    // getNextLectures();
    getInstructorSubjects();
  }

  // bool isGettingLectures = false;
  // List<LectureModel> nextLectures = [];

  // Future<void> getNextLectures() async {
  //   isGettingLectures = true;
  //   emit(GetNextLecturesLoadingState());
  //   DioHelper.getData(url: NEXT_LECTURES, token: 'Bearer $STUDENT_TOKEN')
  //       .then((Response response) {
  //     response.data.forEach((lecture) {
  //       nextLectures.add(LectureModel.fromMap(lecture));
  //     });
  //     isGettingLectures = false;
  //     emit(GetNextLecturesSuccessState());
  //   }).catchError((e) {
  //     isGettingLectures = false;
  //     print(e.toString());
  //     emit(GetNextLecturesErrorState());
  //   });
  // }

  List<InstructorSubjectModel> instructorSubjects = [];
  bool isGettingSubjects = false;

  Future<void> getInstructorSubjects() async {
    emit(GetInstructorSubjectsLoadingState());
    isGettingSubjects = true;

    DioHelper.getData(
            url: INSTRUCTOR_SUBJECT, token: 'Bearer $INSTRUCTOR_TOKEN')
        .then((Response response) {
      instructorSubjects.clear();
      response.data['subjects'].forEach((subject) {
        instructorSubjects.add(InstructorSubjectModel.fromMap(subject));
      });
      isGettingSubjects = false;
      emit(GetInstructorSubjectsSuccessState());
    }).catchError((e) {
      isGettingSubjects = false;
      print(e.toString());
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
      lecturesOfSubject.clear();
      response.data.forEach((lecture) {
        lecturesOfSubject.add(InstructorLectureModel.fromMap(lecture));
      });
      isGettingLecturesOfSubject = false;
      emit(GetLecturesOfSubjectSuccessState());
    }).catchError((e) {
      isGettingLecturesOfSubject = false;
      print(e.toString());
      emit(GetLecturesOfSubjectErrorState());
    });
  }

  List<InstructorLectureModel> lectureAttendees = [];
  bool isGettingAttendees = false;

  Future<void> getLectureAttendees(id) async {
    emit(GetLecturesAttendeesLoadingState());
    isGettingAttendees = true;
    final url = '$INSTRUCTOR_SUBJECT_QUERIES/$id/lectures';

    DioHelper.getData(url: url, token: 'Bearer $INSTRUCTOR_TOKEN')
        .then((Response response) {
      lectureAttendees.clear();
      response.data.forEach((lecture) {
        lectureAttendees.add(InstructorLectureModel.fromMap(lecture));
      });
      isGettingAttendees = false;
      emit(GetLecturesAttendeesSuccessState());
    }).catchError((e) {
      isGettingAttendees = false;
      print(e.toString());
      emit(GetLecturesAttendeesErrorState());
    });
  }

  Future<void> createAttendanceExcel(
      List<Map<String, dynamic>> students) async {
    // Create a new Excel workbook
    final Excel excel = Excel.createExcel();
    excel.rename('Sheet1', 'Attendance');
    // Create the "Attendance" sheet
    final Sheet sheet = excel['Attendance'];

    // Set the headers for the Excel sheet
    final List<String> headers = ['Name', 'Roll Number', 'Attendance'];
    sheet.appendRow(headers);

    // Add student attendance details to the sheet
    for (final student in students) {
      final List<String> rowData = [
        student['name'],
        student['rollNumber'],
        student['attendance'],
      ];
      sheet.appendRow(rowData);
    }

    // Get the root directory
    final Directory root = Directory('/storage/emulated/0/');

    // Create the custom directory if it doesn't exist
    final String customDirectoryName = 'SU Attendance';
    final Directory customDirectory =
        Directory(path.join(root.path, customDirectoryName));

    // if (await Permission.speech.isPermanentlyDenied) {
    //  openAppSettings();
    if (await _hasAcceptedPermissions()) {
      if (!await customDirectory.exists()) {
        await customDirectory.create();
      }

      // Save the Excel file to the custom directory
      final String fileName = 'attendance.xlsx';
      final String filePath = path.join(customDirectory.path, fileName);

      final File file = File(filePath);
      await file.writeAsBytes(excel.encode()!);
      print('Excel file created: $filePath');
    }

    // Show a message with the file path
  }

  Future<bool> _hasAcceptedPermissions() async {
    if (Platform.isAndroid) {
      if (await _requestPermission(Permission.storage) &&
              // access media location needed for android 10/Q
              await _requestPermission(Permission.accessMediaLocation)
          // manage external storage needed for android 11/R
          ) {
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
      // not android or ios
      return false;
    }
  }

  void logout() {}

  _requestPermission(Permission permission) async {
    return await permission.request().isGranted;
  }
}
