class LectureModel{
  String drName;
  String subject;
  double attendancePercent;
  LectureModel({
    required this.drName,
    required this.subject,
    required this.attendancePercent,
  });
}
List<LectureModel> lectures =
  [
    LectureModel(drName: 'ahmed elsheiwey', subject: 'Data science', attendancePercent: 15.0),
    LectureModel(drName: 'fayzah', subject: 'computer communication', attendancePercent: 11.9),
    LectureModel(drName: 'fayzah', subject: 'web developing ', attendancePercent: 20.0),
    LectureModel(drName: 'rania', subject: 'wireless network', attendancePercent: 50.0),
    LectureModel(drName: 'ahmed elshiwey', subject: 'Data science', attendancePercent: 9.0),
    LectureModel(drName: 'ahmed elshiwey', subject: 'Data science', attendancePercent: 16.0),
    LectureModel(drName: 'ahmed elshiwey', subject: 'Data science', attendancePercent: 60.9),
  ];