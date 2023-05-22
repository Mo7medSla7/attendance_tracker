import 'package:attendance_tracker/models/instructor_lecture_model.dart';
import 'package:attendance_tracker/modules/instructor_home_screen/instructor_cubit/instructor_states.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../helpers/dio_helper.dart';
import '../../../models/instructor_subject_model.dart';
import '../../../shared/end_points.dart';
import '../../../shared/user_data.dart';

class InstructorCubit extends Cubit<InstructorStates> {
  InstructorCubit() : super(InstructorInitState());

  static InstructorCubit get(context) => BlocProvider.of(context);

  double lecturePosition = 0.0;
  void changeNextLecture(int index) {
    lecturePosition = index.toDouble();
    emit(ChangeNextLectureState());
  }

  void getSubjects() {
    // getNextLectures();
    getInstructorSubjects();
  }

  // bool isGettingLectures = false;
  // List<LectureModel> nextLectures = [];

  // Future<void> getNextLectures() async {
  //   isGettingLectures = true;
  //   emit(GetNextLecturesLoadingState());
  //   DioHelper.getData(url: NEXT_LECTURES, token: 'Bearer $STUDENT_TOKEN')
  //       .then((Response response) {
  //     response.data.forEach((lecture) {
  //       nextLectures.add(LectureModel.fromMap(lecture));
  //     });
  //     isGettingLectures = false;
  //     emit(GetNextLecturesSuccessState());
  //   }).catchError((e) {
  //     isGettingLectures = false;
  //     print(e.toString());
  //     emit(GetNextLecturesErrorState());
  //   });
  // }

  List<InstructorSubjectModel> instructorSubjects = [];
  bool isGettingSubjects = false;

  Future<void> getInstructorSubjects() async {
    emit(GetInstructorSubjectsLoadingState());
    isGettingSubjects = true;

    DioHelper.getData(
            url: INSTRUCTOR_SUBJECT, token: 'Bearer $INSTRUCTOR_TOKEN')
        .then((Response response) {
      instructorSubjects.clear();
      response.data['subjects'].forEach((subject) {
        instructorSubjects.add(InstructorSubjectModel.fromMap(subject));
      });
      isGettingSubjects = false;
      emit(GetInstructorSubjectsSuccessState());
    }).catchError((e) {
      isGettingSubjects = false;
      print(e.toString());
      emit(GetInstructorSubjectsErrorState());
    });
  }

  List<InstructorLectureModel> lecturesOfSubject = [];
  bool isGettingLecturesOfSubject = false;

  Future<void> getLecturesOfSubject(id) async {
    emit(GetLecturesOfSubjectLoadingState());
    isGettingLecturesOfSubject = true;
    final url = '$INSTRUCTOR_SUBJECT_QUERIES/$id/lectures';

    DioHelper.getData(url: url, token: 'Bearer $INSTRUCTOR_TOKEN')
        .then((Response response) {
      lecturesOfSubject.clear();
      response.data.forEach((lecture) {
        lecturesOfSubject.add(InstructorLectureModel.fromMap(lecture));
      });
      isGettingLecturesOfSubject = false;
      emit(GetLecturesOfSubjectSuccessState());
    }).catchError((e) {
      isGettingLecturesOfSubject = false;
      print(e.toString());
      emit(GetLecturesOfSubjectErrorState());
    });
  }

  List<InstructorLectureModel> lectureAttendees = [];
  bool isGettingAttendees = false;

  Future<void> getLectureAttendees(id) async {
    emit(GetLecturesAttendeesLoadingState());
    isGettingAttendees = true;
    final url = '$INSTRUCTOR_SUBJECT_QUERIES/$id/lectures';

    DioHelper.getData(url: url, token: 'Bearer $INSTRUCTOR_TOKEN')
        .then((Response response) {
      lectureAttendees.clear();
      response.data.forEach((lecture) {
        lectureAttendees.add(InstructorLectureModel.fromMap(lecture));
      });
      isGettingAttendees = false;
      emit(GetLecturesAttendeesSuccessState());
    }).catchError((e) {
      isGettingAttendees = false;
      print(e.toString());
      emit(GetLecturesAttendeesErrorState());
    });
  }

  void logout() {}
}
