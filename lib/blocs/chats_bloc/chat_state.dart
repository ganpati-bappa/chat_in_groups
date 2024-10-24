part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState();
  
  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChatState {
  const ChatInitial();
}

final class ChatLoading extends ChatState {
}
final class ChatLoaded extends ChatState {
  final List<Messages> messages;
  const ChatLoaded({required this.messages});

   @override
  List<Object> get props => [messages];
}
final class ChatLoadFailure extends ChatState {}

final class ChatImageLoaded extends ChatState {
  final String imagePath;
  const ChatImageLoaded({required this.imagePath});
}