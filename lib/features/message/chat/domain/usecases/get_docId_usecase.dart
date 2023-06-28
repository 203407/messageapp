import 'package:messageapp/features/message/chat/domain/repositories/chat_repositories.dart';

class GetDocIdUsecase {
  final ChatRepository chatRepository;

  GetDocIdUsecase(this.chatRepository);

  Future<String> execute(friendUid, currentUserUid) async {
    return await chatRepository.checkDocId(friendUid, currentUserUid);
  }
}
