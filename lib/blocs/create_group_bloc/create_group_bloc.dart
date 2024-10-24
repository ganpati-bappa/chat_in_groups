import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';
import 'dart:developer';
part 'create_group_event.dart';
part 'create_group_state.dart';

class CreateGroupBloc extends Bloc<CreateGroupEvent, CreateGroupState> {
  final ChatGroupsRepository chatGroupsRepository;

  CreateGroupBloc({required this.chatGroupsRepository}) : super(CreateGroupInitial()) {
    
    on<CreateNewGroup>((event, emit) async {
      emit(GroupCreationInProgress());
      try {
        final List<DocumentReference> userDocumentReference = await chatGroupsRepository.getDocumentReferenceOfUsers(event.users);
        final DocumentReference currentUserReference = await chatGroupsRepository.getCurrentUserReference();
        await chatGroupsRepository.addGroups(
          Groups(
            id: "",
            groupName: event.groupName, 
            admin: currentUserReference, 
            users: userDocumentReference, 
            updatedTime: Timestamp.now(),
            adminName: "",
            unreadCount: 0
          ));
        emit(GroupSuccessfulyCreated());
      } catch (ex) {
        emit(GroupCreationFailed(message: ex.toString()));
        log(ex.toString());
      }
    });
  }
}
