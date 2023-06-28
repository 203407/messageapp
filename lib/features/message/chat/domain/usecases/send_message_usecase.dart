import 'package:messageapp/features/message/chat/domain/repositories/chat_repositories.dart';

class SendMessageUsecase {
  final ChatRepository chatRepository;

  SendMessageUsecase(this.chatRepository);

  Future<void> execute(msg, tipo, currentUser, docId) async {
    return await chatRepository.sendMessage(msg, tipo, currentUser, docId);
  }
}
