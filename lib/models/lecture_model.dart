class LectureModel {
  String drName;
  String subject;
  double attendancePercent;
  LectureModel({
    required this.drName,
    required this.subject,
    required this.attendancePercent,
  });
}

List<LectureModel> lectures = [
  LectureModel(
      drName: 'ahmed elsheiwey ahmed',
      subject: 'Data science and data base',
      attendancePercent: 100),
  LectureModel(
      drName: 'fayzah',
      subject: 'computer communication',
      attendancePercent: 80),
  LectureModel(
      drName: 'fayzah', subject: 'web developing ', attendancePercent: 20.0),
  LectureModel(
      drName: 'rania', subject: 'wireless network', attendancePercent: 50.0),
  LectureModel(
      drName: 'ahmed elshiwey',
      subject: 'Data science',
      attendancePercent: 9.0),
  LectureModel(
      drName: 'ahmed elshiwey',
      subject: 'Data science',
      attendancePercent: 16.0),
  LectureModel(
      drName: 'ahmed elshiwey',
      subject: 'Data science',
      attendancePercent: 60.9),
];
