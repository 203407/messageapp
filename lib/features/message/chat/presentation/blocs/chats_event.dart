part of 'chats_bloc.dart';

@immutable
abstract class ChatEvent {}

class GetDocIdtUsers extends ChatEvent {
  final String friendUid;
  final String currentUserUid;
  GetDocIdtUsers({required this.friendUid, required this.currentUserUid});
}
