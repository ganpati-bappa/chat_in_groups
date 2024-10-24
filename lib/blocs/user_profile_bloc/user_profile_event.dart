part of 'user_profile_bloc.dart';

sealed class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class UserProfileLoadingRequired extends UserProfileEvent {
  String? userId;
  UserProfileLoadingRequired({this.userId});
}
