part of 'groups_bloc.dart';

sealed class GroupsEvent extends Equatable {
  const GroupsEvent();

  @override
  List<Object> get props => [];
}

final class ChatGroupsLoadingRequired extends GroupsEvent {}


