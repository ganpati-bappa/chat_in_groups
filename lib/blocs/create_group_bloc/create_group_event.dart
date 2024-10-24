part of 'create_group_bloc.dart';

sealed class CreateGroupEvent extends Equatable {
  const CreateGroupEvent();

  @override
  List<Object> get props => [];
}

final class CreateNewGroup extends CreateGroupEvent {
  final String groupName;
  final List<MyUser> users;
  const CreateNewGroup({required this.groupName, required this.users});
}

final class AddUsersToGroup extends CreateGroupEvent {}

final class AddAdminsToGroup extends CreateGroupEvent {}