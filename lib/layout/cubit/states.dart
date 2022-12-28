abstract class AppStates {}

class AppInitState extends AppStates {}

class ChangeNavBarState extends AppStates {}

class AddOrRemoveSubjectToRegisterState extends AppStates {}

class GetSubjectsForRegisterLoadingState extends AppStates {}

class GetSubjectsForRegisterSuccessState extends AppStates {}

class GetSubjectsForRegisterErrorState extends AppStates {}

class GetRegisteredSubjectsLoadingState extends AppStates {}

class GetRegisteredSubjectsSuccessState extends AppStates {}

class GetRegisteredSubjectsErrorState extends AppStates {}

class RegisterSubjectLoadingState extends AppStates {}

class RegisterSubjectSuccessState extends AppStates {}

class RegisterSubjectErrorState extends AppStates {}
