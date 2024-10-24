part of 'user_profile_bloc.dart';

sealed class UserProfileState extends Equatable {
  const UserProfileState();
  
  @override
  List<Object> get props => [];
}

final class UserProfileInitial extends UserProfileState {}
final class UserProfileLoading extends UserProfileState {}
final class UserProfileError extends UserProfileState {}
final class UserProfileLoaded extends UserProfileState {
  final MyUser user;
  const UserProfileLoaded({required this.user});
}
