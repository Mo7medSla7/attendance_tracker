import 'dart:convert';


class StudentStatisticsModel {
  String name;
  String id;
  String location;
  String year;
  String semester;
  num totalLectures;
  num totalSections;


  StudentStatisticsModel({
    required this.name,
    required this.id,
    required this.location,
    required this.year,
    required this.semester,
    required this.totalLectures,
    required this.totalSections,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'studentId': id,
    };
  }

  factory StudentStatisticsModel.formMap(Map<String, dynamic> map){
    return StudentStatisticsModel(
        name: map['email'] as String,
        id: map['studentId'] as String,
        location: map['location'] as String,
        year: map['year'] as String,
        semester: map['semester'] as String,
        totalLectures: map['totalLectures'] as num,
        totalSections: map['totalSections'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentStatisticsModel.formJson(String source) =>
      StudentStatisticsModel.formMap(json.decode(source) as Map<String, dynamic>);

}