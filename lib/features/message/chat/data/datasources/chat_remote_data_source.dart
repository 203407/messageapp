import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:convert' as convert;

// import 'package:messageapp/features/message/users/data/models/users_models.dart';

import 'package:messageapp/features/message/chat/domain/entities/messages.dart';

abstract class ChatsRemoteDataSource {
  Future<List<Message>> getChats(username);
  Future<String> checkDocId(friendUid, currentUserUid);
  Future<void> sendMessage(msg, tipo, currentUser, docId);
}

class ChatsRemoteDataSourceImp implements ChatsRemoteDataSource {
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');

  @override
  Future<List<Message>> getChats(username) async {
    List<Message> chats = [];
    var friendUid = username;

    var querySnapshot = await FirebaseFirestore.instance
        .collection("chats")
        .doc(username)
        .collection("messages")
        .orderBy('createdOn', descending: true)
        .get();

    for (var doc in querySnapshot.docs) {
      var data = doc.data();
      var creadoEn;
      if (data['createdOn'] != null) {
        creadoEn = data['createdOn'] as Timestamp;
      } else {
        var fecha = FieldValue.serverTimestamp();
        creadoEn = fecha as Timestamp;
      }

      var msg = data['msg'] as String;
      var tipo = data['tipo'] as String;
      var username = data['username'] as String;

      var message =
          Message(creadoen: creadoEn, msg: msg, tipo: tipo, username: username);
      chats.add(message);
    }

    return chats;
  }

  @override
  Future<String> checkDocId(friendUid, currentUserUid) async {
    String id = 'xd';

    await chats
        .where('users', isEqualTo: {friendUid: null, currentUserUid: null})
        .limit(1)
        .get()
        .then(((QuerySnapshot querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            id = querySnapshot.docs.single.id;
          } else {
            chats.add({
              'users': {friendUid: null, currentUserUid: null}
            }).then((value) {
              id = value as String;
            });
          }
        }))
        .catchError((error) {});

    return id;
  }

  @override
  Future<void> sendMessage(msg, tipo, currentUser, docId) async {
    await chats.doc(docId).collection('messages').add({
      'createdOn': FieldValue.serverTimestamp(),
      'username': currentUser,
      'msg': msg,
      'tipo': tipo
    }).then((value) {});
  }
}
