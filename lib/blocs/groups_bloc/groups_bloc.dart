import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/user_repository.dart';
import 'dart:developer';
part 'groups_event.dart';
part 'groups_state.dart';

class GroupsBloc extends Bloc<GroupsEvent, GroupsState> {
  final ChatGroupsRepository chatGroupsRepository;
  final User? user;
  List<Groups> groups = [];
  Map<String, List<Messages>> messages = {};

  DocumentReference get userRef  => chatGroupsRepository.getCurrentUserReference();

  DocumentReference groupRef(String id) => chatGroupsRepository.getGroupsReference(id);

  GroupsBloc({required this.chatGroupsRepository, this.user}) : super(GroupsInitial()) {

    on<ChatGroupsLoadingRequired>((event, emit) async {
      if (groups.isEmpty) {
        emit(GroupsLoading());
      }
      else {
        emit(GroupsLoaded(groups: groups));
      }
      try {
        final String? loggedInUser = chatGroupsRepository.getCurrentUserId();
        if (loggedInUser == null) return;
        groups = await Future.wait(await chatGroupsRepository.getGroups(loggedInUser));
        emit(GroupsLoaded(groups: groups));
      } catch (ex) {
        log(ex.toString());
        emit(GroupsLoadError());
        rethrow;
      }
    });

   
  }
}
