// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:intl/intl.dart';

class InstructorLectureModel {
  String id;
  String location;
  String name;
  String type;
  String date;
  String time;
  bool finished;
  num presencePercentage;
  num numOfAttendees;

  InstructorLectureModel({
    required this.id,
    required this.location,
    required this.name,
    required this.type,
    required this.date,
    required this.time,
    required this.finished,
    required this.presencePercentage,
    required this.numOfAttendees,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'location': location,
      'name': name,
      'type': type,
      'date': date,
      'time': time,
      'finished': finished,
      'presencePercentage': presencePercentage,
      'numOfAttendees': numOfAttendees,
    };
  }

  factory InstructorLectureModel.fromMap(Map<String, dynamic> map) {
    return InstructorLectureModel(
      id: map['_id'] as String,
      location: map['location'] as String,
      name: map['name'] as String,
      type: map['type'] as String,
      date: DateFormat('EEE d/MM/yyyy ').format(DateTime.parse(map['date'])),
      time: DateFormat('h:mm a ').format(DateTime.parse(map['date'])),
      finished: map['finished'] as bool,
      presencePercentage: map['presencePercentage'] as num,
      numOfAttendees: map['numOfAttendees'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory InstructorLectureModel.fromJson(String source) =>
      InstructorLectureModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}