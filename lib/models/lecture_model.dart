// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:intl/intl.dart';

class LectureModel {
  String id;
  String subjectName;
  String location;
  String faculty;
  String year;
  String semester;
  String name;
  String type;
  String instructorName;
  String date;
  String time;
  DateTime fullDate;
  bool hasAttended;

  LectureModel({
    required this.id,
    required this.subjectName,
    required this.location,
    required this.faculty,
    required this.year,
    required this.semester,
    required this.name,
    required this.type,
    required this.instructorName,
    required this.date,
    required this.time,
    required this.fullDate,
    required this.hasAttended,
  });

  factory LectureModel.fromMap(Map<String, dynamic> map) {
    return LectureModel(
      id: map['_id'] as String,
      subjectName: map['subject']['name'] as String,
      location: map['location'] as String,
      faculty: map['subject']['faculty'] as String,
      year: map['subject']['year'] as String,
      semester: map['subject']['semester'] as String,
      name: map['name'] as String,
      type: map['type'] as String,
      instructorName: map['instructor'] as String,
      fullDate: DateTime.parse(map['date']),
      date: DateFormat('EEE d-MM-yyyy ').format(DateTime.parse(map['date'])),
      time: DateFormat('h:mm a ').format(DateTime.parse(map['date'])),
      hasAttended: map['hasAttended'] ?? false,
    );
  }

  factory LectureModel.fromJson(String source) =>
      LectureModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
