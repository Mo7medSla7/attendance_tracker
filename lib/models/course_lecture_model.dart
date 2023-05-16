import 'dart:convert';

class InstructorHomeModel {
  String subjectId;
  String lectureName;
  num attendedStudentNum;
  String studentLevelAndSemester;
  String department;
  String subjectCode;
  DateTime date;
  DateTime time;

  InstructorHomeModel({
    required this.subjectId,
    required this.lectureName,
    required this.attendedStudentNum,
    required this.department,
    required this.studentLevelAndSemester,
    required this.subjectCode,
    required this.date,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'subjectId': subjectId,
      'subjectName': lectureName,
      'activeStudentNum': attendedStudentNum,
      'department': department,
      'studentLevelAndSemester': studentLevelAndSemester,
      'subjectCode': subjectCode,
      'date': date,
      'time': time,
    };
  }

  factory InstructorHomeModel.formMap(Map<String, dynamic> map) {
    return InstructorHomeModel(
      subjectId: map['subjectId'] as String,
      lectureName: map['subjectName'] as String,
      attendedStudentNum: map['activeStudentNum'] as num,
      department: map['department'] as String,
      studentLevelAndSemester: map['studentLevelAndSemester'] as String,
      subjectCode: map['subjectCode'] as String,
      date: map['date'] as DateTime,
      time: map['time'] as DateTime,
    );
  }

  String toJson() => json.encode(toMap());

  factory InstructorHomeModel.formJson(String source) =>
      InstructorHomeModel.formMap(json.decode(source) as Map<String, dynamic>);
}
