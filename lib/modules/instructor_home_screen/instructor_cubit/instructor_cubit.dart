import 'package:attendance_tracker/modules/instructor_home_screen/instructor_cubit/instructor_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InstructorCubit extends Cubit<InstructorStates> {
  InstructorCubit() : super(InstructorInitState());

  static InstructorCubit get(context) => BlocProvider.of(context);

  double lecturePosition = 0.0;
  void changeNextLecture(int index) {
    lecturePosition = index.toDouble();
    emit(ChangeNextLectureState());
  }

  // void getSubjects() {
  //   getNextLectures();
  //   getRegisteredSubjects();
  // }

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
}
