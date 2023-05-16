abstract class AppStates {}

class AppInitState extends AppStates {}

class ChangeNavBarState extends AppStates {}

class EnableEditState extends AppStates {}

class ChangeNextLectureState extends AppStates {}

class RefreshSubjectsState extends AppStates {}

class AddOrRemoveSubjectToRegisterState extends AppStates {}

class QrScanSuccessState extends AppStates {}

class QrScanErrorState extends AppStates {}

class GetRegisteredSubjectsLoadingState extends AppStates {}

class GetRegisteredSubjectsSuccessState extends AppStates {}

class GetRegisteredSubjectsErrorState extends AppStates {}

class GetNextLecturesLoadingState extends AppStates {}

class GetNextLecturesSuccessState extends AppStates {}

class GetNextLecturesErrorState extends AppStates {}

class RegisterSubjectLoadingState extends AppStates {}

class RegisterSubjectSuccessState extends AppStates {}

class RegisterSubjectErrorState extends AppStates {}

class RegisterAllSubjectState extends AppStates {}

class LogoutState extends AppStates {}
