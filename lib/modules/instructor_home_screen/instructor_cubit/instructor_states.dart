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

class GetNextLecturesLoadingState extends InstructorStates {}

class GetNextLecturesSuccessState extends InstructorStates {}

class GetNextLecturesErrorState extends InstructorStates {}

class GetSubjectActiveStudentsLoadingState extends InstructorStates {}

class GetSubjectActiveStudentsSuccessState extends InstructorStates {}

class GetSubjectActiveStudentsErrorState extends InstructorStates {}

class ExtractStudentsSuccessState extends InstructorStates {}

class ExtractStudentsErrorState extends InstructorStates {}

class CreateLectureSuccessState extends InstructorStates {}

class CreateLectureErrorState extends InstructorStates {}

class SearchSubjectState extends InstructorStates {}

class SearchStudentState extends InstructorStates {}

class ToggleSearchState extends InstructorStates {}

class LogoutState extends InstructorStates {}
