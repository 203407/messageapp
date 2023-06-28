import 'package:messageapp/features/message/chat/domain/entities/messages.dart';
import 'package:messageapp/features/message/chat/domain/repositories/chat_repositories.dart';

class GetMessagessUsecase {
  final ChatRepository chatRepository;

  GetMessagessUsecase(this.chatRepository);

  Future<List<Message>> execute(username) async {
    return await chatRepository.getChats(username);
  }
}
