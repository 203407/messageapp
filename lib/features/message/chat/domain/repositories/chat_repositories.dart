import 'package:messageapp/features/message/chat/domain/entities/messages.dart';

abstract class ChatRepository {
  Future<List<Message>> getChats(username);
  Future<String> checkDocId(friendUid, currentUserUid);
  Future<void> sendMessage(msg, tipo, currentUser, docId);
}
