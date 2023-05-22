// ignore_for_file: non_constant_identifier_names

import 'package:attendance_tracker/helpers/cache_helper.dart';

String? STUDENT_SEMESTER;
String? STUDENT_TOKEN;
String? STUDENT_EMAIL;
String? STUDENT_NAME;
String? STUDENT_ACADEMIC_YEAR;
String? STUDENT_FACULTY;
String? STUDENT_ID;
String? INSTRUCTOR_TOKEN;

void setStudentData() {
  STUDENT_TOKEN = CacheHelper.getData('STUDENT_TOKEN');
  STUDENT_EMAIL = CacheHelper.getData('STUDENT_EMAIL');
  STUDENT_NAME = CacheHelper.getData('STUDENT_NAME');
  STUDENT_ACADEMIC_YEAR = CacheHelper.getData('STUDENT_ACADEMIC_YEAR');
  STUDENT_FACULTY = CacheHelper.getData('STUDENT_FACULTY');
  STUDENT_SEMESTER = CacheHelper.getData('STUDENT_SEMESTER');
  STUDENT_ID = CacheHelper.getData('STUDENT_ID').toString();
}

void setInstructorData() {
  INSTRUCTOR_TOKEN = CacheHelper.getData('INSTRUCTOR_TOKEN');
}
