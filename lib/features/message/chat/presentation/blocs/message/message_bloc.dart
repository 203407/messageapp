import 'package:bloc/bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:messageapp/features/message/chat/domain/entities/messages.dart';
import 'package:messageapp/features/message/chat/domain/usecases/get_messages_usecase.dart';
import 'package:messageapp/features/message/chat/domain/usecases/send_message_usecase.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final SendMessageUsecase sendMessageUsecase;
  final GetMessagessUsecase getMessagessUsecase;

  MessageBloc(
      {required this.sendMessageUsecase, required this.getMessagessUsecase})
      : super(MessageInitial()) {
    on<MessageEvent>((event, emit) async {
      if (event is SendMessage) {
        try {
          emit(Sending());
          await sendMessageUsecase.execute(
              event.msg, event.tipo, event.currentUser, event.docId);
          emit(Send());
        } catch (e) {
          emit(ErrorM(error: e.toString()));
        }
      } else if (event is GetMessages) {
        try {
          emit(Loadings());
          List<Message> messages =
              await getMessagessUsecase.execute(event.username);
          print(
              "mensajes /////////////////////////////////////////////////////////////////////////////");
          print(messages);
          emit(Loadeds(messages: messages, docid: event.docid));
        } catch (e) {
          emit(ErrorM(error: e.toString()));
        }
      }
    });
  }
}
