import 'package:messageapp/features/message/chat/data/datasources/chat_remote_data_source.dart';
import 'package:messageapp/features/message/chat/domain/entities/messages.dart';
import 'package:messageapp/features/message/chat/domain/repositories/chat_repositories.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatsRemoteDataSource chatsRemoteDataSource;

  ChatRepositoryImpl({required this.chatsRemoteDataSource});

  @override
  Future<List<Message>> getChats(username) async {
    return await chatsRemoteDataSource.getChats(username);
  }

  @override
  Future<String> checkDocId(friendUid, currentUserUid) async {
    return await chatsRemoteDataSource.checkDocId(friendUid, currentUserUid);
  }

  @override
  Future<void> sendMessage(msg, tipo, currentUser, docId) async {
    return await chatsRemoteDataSource.sendMessage(
        msg, tipo, currentUser, docId);
  }
}
