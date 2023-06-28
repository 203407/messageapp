import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messageapp/features/message/chat/domain/entities/messages.dart';

class ChatModel extends Message {
  ChatModel({
    required Timestamp creadoen,
    required String msg,
    required String tipo,
    required String username,
  }) : super(creadoen: creadoen, msg: msg, tipo: tipo, username: username);

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      creadoen: json['creadoOn'],
      msg: json['msg'],
      tipo: json['tipo'],
      username: json['username'],
    );
  }

  factory ChatModel.fromEntity(Message message) {
    return ChatModel(
        creadoen: message.creadoen,
        msg: message.msg,
        tipo: message.tipo,
        username: message.username);
  }
}
