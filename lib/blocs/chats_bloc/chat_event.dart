part of 'chat_bloc.dart';

class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

final class ChatLoadingRequired extends ChatEvent {
  final DocumentReference groupId;
  const ChatLoadingRequired({required this.groupId});
}

final class SendMessage extends ChatEvent {
  final String message;
  const SendMessage({required this.message});
}

final class SendFailure extends ChatEvent {}

final class ChatUpdate extends ChatEvent {
  final List<Messages> message;
  const ChatUpdate({required this.message});
}

final class SendImage extends ChatEvent {
  final String imagePath;
  const SendImage({required this.imagePath});
}