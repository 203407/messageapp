import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messageapp/features/message/chat/presentation/blocs/chats_bloc.dart';
import 'package:messageapp/features/message/chat/presentation/blocs/message/message_bloc.dart';
import 'package:messageapp/features/message/users/presentation/blocs/users_bloc.dart';
import 'package:messageapp/features/message/users/presentation/pages/loginJesus.dart';
import 'package:messageapp/features/message/users/presentation/pages/registerJesus.dart';

import 'package:messageapp/features/message/users/presentation/pages/menu.dart';
import 'package:messageapp/home_page.dart';

import 'package:messageapp/usecase_config.dart';
import 'package:messageapp/usecase_configchat.dart';

import 'firebase_options.dart';

UsecaseConfig usecaseConfig = UsecaseConfig();
UsecaseConfigchat usecaseConfigchat = UsecaseConfigchat();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return MultiBlocProvider(
      providers: [
        BlocProvider<UsersBloc>(
          create: (BuildContext context) => UsersBloc(
            getUsersUsecase: usecaseConfig.getUsersUsecase!,
            createUserUsecase: usecaseConfig.createUserUsecase!,
            validateUsersUsecase: usecaseConfig.validateUsersUsecase!,
          ),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              ChatBloc(getDocIdUsecase: usecaseConfigchat.getDocIdUsecase!),
        ),
        BlocProvider(
          create: (BuildContext context) => MessageBloc(
              sendMessageUsecase: usecaseConfigchat.sendMessageUsecase!,
              getMessagessUsecase: usecaseConfigchat.getMessagessUsecase!),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // is not restarted.
          primarySwatch: Colors.grey,
        ),
        home: LoginPages(),
        // home: MyHomePage(
        //   title: 'new',
        // ),
        routes: <String, WidgetBuilder>{
          '/register': (BuildContext context) => const RegistrationFormJesus(),
        },
      ),
    );
  }
}
