import 'package:firebase_auth/firebase_auth.dart';

import 'models/my_user.dart';

abstract class UserRepository {
  Stream<User?> get user;
  Future<void> signIn(String email, String password);
  Future<void> logout();
  Future<MyUser> signUp(MyUser myUser, String password);
  Future<void> resetPassword(String email);
  Future<void> setUserData(MyUser myUser);
  Future<MyUser> getUserData([String? myUserId]);
  Future<String> uploadImage(String path);
}