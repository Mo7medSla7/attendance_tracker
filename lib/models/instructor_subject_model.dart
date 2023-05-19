// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class InstructorSubjectModel {
  String id;
  num activeStudents;
  String name;
  String subjectCode;
  String faculty;
  String semester;
  String year;

  InstructorSubjectModel({
    required this.id,
    required this.activeStudents,
    required this.name,
    required this.subjectCode,
    required this.faculty,
    required this.semester,
    required this.year,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'activeStudents': activeStudents,
      'name': name,
      'subjectCode': subjectCode,
      'faculty': faculty,
      'semester': semester,
      'year': year,
    };
  }

  factory InstructorSubjectModel.fromMap(Map<String, dynamic> map) {
    return InstructorSubjectModel(
      id: map['_id'] as String,
      activeStudents: map['activeStudents'] as num,
      name: map['name'] as String,
      subjectCode: map['subjectCode'] as String,
      faculty: map['faculty'] as String,
      semester: map['semester'] as String,
      year: map['year'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory InstructorSubjectModel.fromJson(String source) =>
      InstructorSubjectModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
