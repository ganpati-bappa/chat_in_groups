part of 'groups_bloc.dart';

sealed class GroupsState extends Equatable {
  const GroupsState();
  
  @override
  List<Object> get props => [];
}

final class GroupsInitial extends GroupsState {
}

final class GroupsLoading extends GroupsState {}
final class GroupsLoaded extends GroupsState {
  final List<Groups> groups;
  const GroupsLoaded({required this.groups});

  @override
  List<Object> get props => [groups];
}

final class GroupsLoadError extends GroupsState {}

