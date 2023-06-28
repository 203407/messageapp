import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final Timestamp creadoen;
  final String msg;
  final String tipo;
  final String username;

  Message({
    required this.creadoen,
    required this.msg,
    required this.tipo,
    required this.username,
  });
}
