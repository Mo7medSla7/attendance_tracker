// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SubjectModel {
  String id;
  String name;
  String faculty;
  String semester;
  String year;
  String instructor;
  num numberOfStudents;
  bool? isAccepted;

  SubjectModel({
    required this.id,
    required this.name,
    required this.faculty,
    required this.semester,
    required this.year,
    required this.instructor,
    required this.numberOfStudents,
    this.isAccepted,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'name': name,
      'faculty': faculty,
      'semester': semester,
      'year': year,
      'subjectInstructor': instructor,
      'numberOfStudents': numberOfStudents,
      'isAccepted': isAccepted ?? false,
    };
  }

  factory SubjectModel.fromMap(Map<String, dynamic> map) {
    return SubjectModel(
      id: map['_id'] as String,
      name: map['name'] as String,
      faculty: map['faculty'] as String,
      semester: map['semester'] as String,
      year: map['year'] as String,
      instructor: map['subjectInstructor'][0] ?? '',
      numberOfStudents: map['numberOfStudents'] ?? 0,
      isAccepted: map['isAccepted'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubjectModel.fromJson(String source) =>
      SubjectModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
