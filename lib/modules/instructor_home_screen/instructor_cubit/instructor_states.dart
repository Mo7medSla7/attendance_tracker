abstract class InstructorStates {}

class InstructorInitState extends InstructorStates {}

class ChangeNextLectureState extends InstructorStates {}

class GetInstructorSubjectsLoadingState extends InstructorStates {}

class GetInstructorSubjectsSuccessState extends InstructorStates {}

class GetInstructorSubjectsErrorState extends InstructorStates {}

class GetLecturesOfSubjectLoadingState extends InstructorStates {}

class GetLecturesOfSubjectSuccessState extends InstructorStates {}

class GetLecturesOfSubjectErrorState extends InstructorStates {}

class GetLecturesAttendeesLoadingState extends InstructorStates {}

class GetLecturesAttendeesSuccessState extends InstructorStates {}

class GetLecturesAttendeesErrorState extends InstructorStates {}
