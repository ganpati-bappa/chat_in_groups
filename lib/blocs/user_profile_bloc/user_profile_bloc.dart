import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  MyUser user;
  final UserRepository userRepository;

  UserProfileBloc({required this.userRepository}) : user = MyUser.empty ,super(UserProfileInitial()) {

    on<UserProfileLoadingRequired>((event, emit) async {
      emit(UserProfileLoading());
      try {
        if (user.id == "") {
          user = await userRepository.getUserData();
        }
        emit(UserProfileLoaded(user: user));
      } catch (ex) {
        log(ex.toString());
        rethrow;
      }
    });
  }
}
