// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:attendance_tracker/models/subject_model.dart';

class LectureModel {
  String id;
  String subjectName;
  String faculty;
  String year;
  String semester;
  String name;
  String type;
  String instructorName;
  String instructorId;
  String date;
  String time;

  LectureModel({
    required this.id,
    required this.subjectName,
    required this.faculty,
    required this.year,
    required this.semester,
    required this.name,
    required this.type,
    required this.instructorName,
    required this.instructorId,
    required this.date,
    required this.time,
  });

  factory LectureModel.fromMap(Map<String, dynamic> map) {
    return LectureModel(
      id: map['_id'] as String,
      subjectName: map['subject']['name'] as String,
      faculty: map['subject']['faculty'] as String,
      year: map['subject']['year'] as String,
      semester: map['subject']['semester'] as String,
      name: map['name'] as String,
      type: map['type'] as String,
      instructorName: map['instructor']['name'] as String,
      instructorId: map['instructor']['_id'] as String,
      date: DateFormat('EEE d/MM/yyyy ').format(DateTime.parse(map['date'])),
      time: DateFormat('h:mm a ').format(DateTime.parse(map['date'])),
    );
  }

  factory LectureModel.fromJson(String source) =>
      LectureModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
