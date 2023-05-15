import 'dart:convert';


class LectureStudentsModel {
  String studentName;
  num studentId;

  LectureStudentsModel({
    required this.studentName,
    required this.studentId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': studentName,
      'studentId': studentId,
    };
  }

  factory LectureStudentsModel.formMap(Map<String, dynamic> map){
    return LectureStudentsModel(
        studentName: map['email'] as String,
        studentId: map['studentId'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory LectureStudentsModel.formJson(String source) =>
      LectureStudentsModel.formMap(json.decode(source) as Map<String, dynamic>);

}