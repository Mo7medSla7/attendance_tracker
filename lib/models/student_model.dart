import 'dart:convert';

class StudentModel {
  String email;
  String password;
  String name;
  String faculty;
  String academicYear;
  String semester;
  num studentId;

  StudentModel({
    required this.email,
    required this.password,
    required this.name,
    required this.faculty,
    required this.academicYear,
    required this.semester,
    required this.studentId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'name': name,
      'faculty': faculty,
      'academicYear': academicYear,
      'semester': semester,
      'studentId': studentId,
    };
  }

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      email: map['email'] as String,
      password: map['password'] as String,
      name: map['name'] as String,
      faculty: map['faculty'] as String,
      academicYear: map['academicYear'] as String,
      semester: map['semester'] as String,
      studentId: map['studentId'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentModel.fromJson(String source) =>
      StudentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
