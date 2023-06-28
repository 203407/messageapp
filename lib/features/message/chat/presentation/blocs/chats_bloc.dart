import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:messageapp/features/message/chat/domain/usecases/get_docId_usecase.dart';

part 'chats_event.dart';
part 'chats_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetDocIdUsecase getDocIdUsecase;

  ChatBloc({
    required this.getDocIdUsecase,
  }) : super(Loading()) {
    on<ChatEvent>((event, emit) async {
      if (event is GetDocIdtUsers) {
        try {
          String response = await getDocIdUsecase.execute(
              event.friendUid, event.currentUserUid);
          emit(Loaded(docid: response));
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      }
    });
  }
}
