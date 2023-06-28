part of 'message_bloc.dart';

@immutable
abstract class MessageEvent {}

class SendMessage extends MessageEvent {
  final String msg;
  final String tipo;
  final String currentUser;
  final String docId;
  SendMessage(
      {required this.msg,
      required this.tipo,
      required this.currentUser,
      required this.docId});
}

class GetMessages extends MessageEvent {
  final String username;
  final String docid;
  GetMessages({required this.username, required this.docid});
}
