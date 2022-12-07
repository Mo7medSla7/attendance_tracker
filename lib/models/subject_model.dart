// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SubjectModel {
  String name;
  String faculty;
  String semester;

  SubjectModel({
    required this.name,
    required this.faculty,
    required this.semester,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'faculty': faculty,
      'semester': semester,
    };
  }

  factory SubjectModel.fromMap(Map<String, dynamic> map) {
    return SubjectModel(
      name: map['name'] as String,
      faculty: map['faculty'] as String,
      semester: map['semester'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubjectModel.fromJson(String source) =>
      SubjectModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
