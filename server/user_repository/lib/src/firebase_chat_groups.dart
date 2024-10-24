import 'dart:io';

import 'package:user_repository/src/chat_groups_repo.dart';
import 'package:user_repository/src/entities/entities.dart';
import 'package:user_repository/src/models/groups.dart';
import 'package:user_repository/src/models/messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:developer';

import 'package:user_repository/user_repository.dart';

class FirebaseChatGroupRepository extends FirebaseUserRepository implements ChatGroupsRepository {
  final groupsCollection = FirebaseFirestore.instance.collection('groups');
  final messagesCollection = FirebaseFirestore.instance.collection('messages');
  final Reference firebaseStorage = FirebaseStorage.instance.ref();

  FirebaseChatGroupRepository();

  @override
  Future<void> addGroups(Groups group) async {
    try {
      final DocumentReference<Map<String,dynamic>> groupsReference = await groupsCollection.add(group.toEntity().toDocument());
      groupsReference.update({'id': groupsReference.id});
      await addGroupToUser(groupsReference, group);
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }

  @override
  Future<void> deleteGroups(String groupId) async {
   try {
    await groupsCollection.doc(groupId).delete();
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }


  @override
  Future<void> editGroup({required String groupId, String? groupName, List<String>? users, List<String>? admins, String? groupPhoto}) {
    
    throw UnimplementedError();
  }

  @override
  Future<List<Future<Groups>>> getGroups(String userId)  async {
    try {
      List<DocumentReference> userGroups = await this.userGroups();
      return userGroups.map((groupsRef) async {
       return await groupsRef.get().then((doc) => Groups.fromEntity(GroupsEntity.fromDocument(doc.data() as Map<String,dynamic>)));
      }).toList();
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }

  @override
  CollectionReference getMessages(DocumentReference groupRef) {
    try {
      return messagesCollection;
    } catch (ex) { 
      log(ex.toString());
      rethrow;
    }
  }

  @override
  void sendMessage(String message, DocumentReference senderRef, DocumentReference groupRef) async {
    try {
      Messages messages = Messages(
      message: message, time: Timestamp.now(), messageType: "text", id: '', sender: senderRef, groupId: groupRef, senderName: await senderRef.get().then((doc) => doc.get('name')));
      await messagesCollection.add(messages.toEntity().toDocument());
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }
  
  @override
  Future<List<MyUser>> getAllUsers() async {
    try {
      return await userCollection.get().then((users) {
        return users.docs.map((doc) => MyUser.fromEntity(MyUserEntity.fromDocument(doc.data()))).toList();
      });
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }

  @override
  Future<List<DocumentReference>> getDocumentReferenceOfUsers(List<MyUser> users) async {
    try {
      return users.map((user) => userCollection.doc(user.id)).toList();
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }

  @override
  String? getCurrentUserId() {
    try {
      return loggedInUser;
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }

  @override
  DocumentReference getCurrentUserReference()  {
    try {
      return userCollection.doc(loggedInUser);
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }
  
  @override
  DocumentReference getGroupsReference(String id) {
    return groupsCollection.doc(id);
  } 

  @override
  Future<void> uploadChatImage(String path,  DocumentReference userRef, DocumentReference groupRef) async {
    try {
     String url = await uploadImageChat(path);
     Messages messages = Messages(groupId: groupRef, message: url, time: Timestamp.now(), sender: userRef, messageType: "image", id: "", senderName: await userRef.get().then((doc) => doc.get('name')));
     await messagesCollection.add(messages.toEntity().toDocument());
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  } 
  
} 