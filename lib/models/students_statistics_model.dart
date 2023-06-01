// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StudentStatisticsModel {
  String id;
  String subjectName;
  String level;
  String semester;
  String instructorName;
  String lectureAttendancePercentage;
  String sectionAttendancePercentage;
  num totalLectures;
  num totalSections;

  StudentStatisticsModel({
    required this.id,
    required this.subjectName,
    required this.level,
    required this.semester,
    required this.instructorName,
    required this.totalLectures,
    required this.totalSections,
    required this.lectureAttendancePercentage,
    required this.sectionAttendancePercentage,
  });

  factory StudentStatisticsModel.formMap(Map<String, dynamic> map) {
    return StudentStatisticsModel(
      id: map['_id'] as String,
      subjectName: map['name'] as String,
      level: map['year'] as String,
      semester: map['semester'] as String,
      totalLectures: map['totalLectures'] as num,
      totalSections: map['totalSections'] as num,
      instructorName: map['instructors'][0] as String,
      lectureAttendancePercentage: map['lectureAttendancePercentage'] == "N/A"
          ? "N/A"
          : map['lectureAttendancePercentage'].toStringAsFixed(1),
      sectionAttendancePercentage: map['sectionAttendancePercentage'] == "N/A"
          ? "N/A"
          : map['sectionAttendancePercentage'].toStringAsFixed(1),
    );
  }

  factory StudentStatisticsModel.formJson(String source) =>
      StudentStatisticsModel.formMap(
          json.decode(source) as Map<String, dynamic>);
}
