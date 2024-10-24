import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';
import 'dart:developer';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatsBloc extends Bloc<ChatEvent, ChatState>{
  final ChatGroupsRepository _chatRepository;
  final DocumentReference groupRef;
  final DocumentReference senderRef;
  StreamSubscription? _subscription;

  ChatsBloc({
    required ChatGroupsRepository myChatRepository,
    required this.groupRef,
    required this.senderRef,
  }) : _chatRepository = myChatRepository , super(const ChatInitial()) {

    
    on<ChatLoadingRequired>((event, emit) async {
      try {
        if (_subscription != null) return;
        emit(ChatLoading());
        final CollectionReference messagesCollection = _chatRepository.getMessages(event.groupId);
        _subscription = messagesCollection.where('groupId', isEqualTo: groupRef).orderBy('time', descending: true).snapshots().listen((snapshot)  {
        List<Messages> messages = snapshot.docs.map((doc) => Messages.fromEntity(MessagesEntity.fromDocument(doc.data() as Map<String, dynamic>))).toList();
        if (!isClosed) {
          add(ChatUpdate(message: messages));
        }
      });
        
      } catch (ex) {
        log(ex.toString());
      }
    });

    on<ChatUpdate>((event, emit) {
      emit(ChatLoaded(messages: event.message));
    });

    on<SendMessage>((event, emit)  {
       _chatRepository.sendMessage(event.message, senderRef, groupRef);
    });
    
    on<SendImage>((event, emit) async {
      try {
        await _chatRepository.uploadChatImage(event.imagePath, senderRef, groupRef);
      } catch (ex) {
        log(ex.toString());
        rethrow;
      }
    });

    @override
    Future<void> close() {
      _subscription?.cancel();
      return super.close();
    }
  }
}
