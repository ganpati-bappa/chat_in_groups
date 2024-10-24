import 'package:user_repository/src/models/groups.dart';
import 'package:user_repository/src/models/messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_repository/user_repository.dart';

abstract class ChatGroupsRepository {
  CollectionReference getMessages(DocumentReference groupId);
  void sendMessage(String message, DocumentReference senderRef, DocumentReference groupRef);
  Future<List<Future<Groups>>> getGroups(String userId);
  Future<void> addGroups(Groups group);
  Future<void> editGroup({required String groupId, String? groupName, List<String>? users, List<String>? admins, String? groupPhoto});
  Future<void> deleteGroups(String groupId);
  Future<List<MyUser>> getAllUsers();
  Future<List<DocumentReference>> getDocumentReferenceOfUsers(List<MyUser> users);
  DocumentReference getCurrentUserReference();
  String? getCurrentUserId();
  DocumentReference getGroupsReference(String id);
  Future<void> uploadChatImage(String path,DocumentReference senderRef, DocumentReference groupId);
}