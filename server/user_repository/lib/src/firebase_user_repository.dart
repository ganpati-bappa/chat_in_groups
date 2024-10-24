import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/user_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'entities/entities.dart';
import 'models/my_user.dart';
import 'user_repo.dart';
import 'dart:developer';

class FirebaseUserRepository implements UserRepository{
  final FirebaseAuth _fireBaseAuth;
  final userCollection = FirebaseFirestore.instance.collection('users');
  final Reference firebaseStorage = FirebaseStorage.instance.ref();
  
  FirebaseUserRepository({FirebaseAuth? fireBaseAuth}) : _fireBaseAuth = fireBaseAuth ?? FirebaseAuth.instance;

  @override
  Future<void> logout() async {
    try {
      await _fireBaseAuth.signOut();
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _fireBaseAuth.sendPasswordResetEmail(email: email);
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _fireBaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } catch(ex) {
      log(ex.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> userSnapshot = await userCollection.where('phoneNo',isEqualTo:  myUser.phoneNo).limit(1).get();
      if (userSnapshot.docs.isNotEmpty) {
        throw Exception("Phono No is already registered");
      }
      UserCredential user =  await _fireBaseAuth.createUserWithEmailAndPassword(email: myUser.email, password: password);
      myUser = myUser.copyWith(id : user.user!.uid);
      return myUser;
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }
  
  @override
  Future<MyUser> getUserData([String? myUserId]) async {
    try {
      myUserId = myUserId ?? loggedInUser;
      return await userCollection.doc(myUserId).get().then((value) => 
        MyUser.fromEntity(MyUserEntity.fromDocument(value.data()!))
      );
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }
  
  @override
  Future<void> setUserData(MyUser user) async {
    try {
      await userCollection.doc(user.id).set(user.toEntity().toDocument());
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }
  
  @override
  Stream<User?> get user => _fireBaseAuth.authStateChanges().map((firebaseUser) {
    final user = firebaseUser;
    return user;
  });

  DocumentReference get userRef  => userCollection.doc(loggedInUser);

  String? get loggedInUser => _fireBaseAuth.currentUser!.uid;

  Future<List<DocumentReference>> userGroups() async {
    try {
      DocumentSnapshot snapshot =  await userCollection.doc(loggedInUser).get();
      List<dynamic> dynamicGroups = snapshot.get('groups');
      return dynamicGroups.map((group) => group as DocumentReference).toList();
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }

  Future<void> addGroupToUser(DocumentReference groupRef, Groups group) async {
    try {
      for (DocumentReference userRef in group.users) {
        await userRef.update({'groups': FieldValue.arrayUnion([groupRef])});
      }
      await group.admin.update({'groups': FieldValue.arrayUnion([groupRef])});
    } catch(ex) {
      log(ex.toString());
      rethrow;
    }
  }
  
  @override
  Future<String> uploadImage(String path) async {
    try {
      File imageFile = File(path);
      Reference imageFolderRef = firebaseStorage.child("images");
      await imageFolderRef.putFile(imageFile);
      String url = await imageFolderRef.getDownloadURL();
      await userRef.update({'picture': url});
      return url;
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  } 

  Future<String> uploadImageChat(String path) async {
    try {
      File imageFile = File(path);
      Reference messageFolderRef = firebaseStorage.child("messages/${DateTime.now()}");
      await messageFolderRef.putFile(imageFile);
      String url = await messageFolderRef.getDownloadURL();
      return url;
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }
}