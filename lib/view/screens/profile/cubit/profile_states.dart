abstract class ProfileStates {}

class ProfileInitialState extends ProfileStates {}

class ProfileLoadingUserState extends ProfileStates {}

class ProfileSuccessUserState extends ProfileStates {}

class ProfileErrorUserState extends ProfileStates {
  final String error;

  ProfileErrorUserState(this.error);
}

class GetPolicyLoadingState extends ProfileStates {}

class GetPolicySuccessState extends ProfileStates {}

class GetPolicyErrorState extends ProfileStates {
  final String error;

  GetPolicyErrorState(this.error);
}

class GetAboutUsLoadingState extends ProfileStates {}

class GetAboutUsSuccessState extends ProfileStates {}

class GetAboutUsErrorState extends ProfileStates {
  final String error;

  GetAboutUsErrorState(this.error);
}

class SelectedImageState extends ProfileStates {}

/// delete account
class DeleteAccountLoadingState extends ProfileStates {}

class DeleteAccountSuccessState extends ProfileStates {}

class DeleteAccountErrorState extends ProfileStates {
  final String error;

  DeleteAccountErrorState(this.error);
}

/// logout
class LogoutLoadingState extends ProfileStates {}

class LogoutSuccessState extends ProfileStates {}

class LogoutErrorState extends ProfileStates {
  final String error;

  LogoutErrorState(this.error);
}

/// edit profile

class EditProfileLoadingState extends ProfileStates {}

class EditProfileSuccessState extends ProfileStates {}

class EditProfileErrorState extends ProfileStates {
  final String error;

  EditProfileErrorState(this.error);
}
