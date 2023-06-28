part of 'message_bloc.dart';

@immutable
abstract class MessageState {}

class MessageInitial extends MessageState {}

class Sending extends MessageState {}

class Send extends MessageState {}

class ErrorM extends MessageState {
  final String error;

  ErrorM({required this.error});
}

class Loadings extends MessageState {}

class Loadeds extends MessageState {
  final List<Message> messages;
  final String docid;

  Loadeds({required this.messages, required this.docid});
}
