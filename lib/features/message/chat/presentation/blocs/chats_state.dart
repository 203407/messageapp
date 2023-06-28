part of 'chats_bloc.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class Loading extends ChatState {}

class Loaded extends ChatState {
  final String docid;

  Loaded({required this.docid});
}

class Error extends ChatState {
  final String error;

  Error({required this.error});
}
