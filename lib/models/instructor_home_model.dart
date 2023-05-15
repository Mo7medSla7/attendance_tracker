import 'dart:convert';


class InstructorHomeModel {
  String subjectName;
  num activeStudentNum;
  String studentLevelAndSemester;
  String department;
  String subjectCode;

  InstructorHomeModel({
    required this.subjectName,
    required this.activeStudentNum,
    required this.department,
    required this.studentLevelAndSemester,
  required this.subjectCode
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'subjectName': subjectName,
      'activeStudentNum': activeStudentNum,
      'department' : department,
      'studentLevelAndSemester' : studentLevelAndSemester,
      'subjectCode' : subjectCode,
    };
  }

  factory InstructorHomeModel.formMap(Map<String, dynamic> map){
    return InstructorHomeModel(
      subjectName: map['subjectName'] as String,
      activeStudentNum: map['activeStudentNum'] as num,
      department: map['department'] as String,
      studentLevelAndSemester: map['studentLevelAndSemester'] as String,
      subjectCode: map['subjectCode'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory InstructorHomeModel.formJson(String source) =>
      InstructorHomeModel.formMap(json.decode(source) as Map<String, dynamic>);

}