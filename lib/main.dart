import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messageapp/features/message/users/presentation/blocs/users_bloc.dart';
import 'package:messageapp/features/message/users/presentation/pages/login.dart';
import 'package:messageapp/features/message/users/presentation/pages/register.dart';
import 'package:messageapp/testfirebase.dart';
import 'package:messageapp/usecase_config.dart';

import 'features/message/users/presentation/pages/signF.dart';
import 'firebase_options.dart';

UsecaseConfig usecaseConfig = UsecaseConfig();

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
              validateUsersUsecase: usecaseConfig.validateUsersUsecase!),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // is not restarted.
          primarySwatch: Colors.grey,
        ),
        home: RegistrationForm(),
      ),
    );
  }
}

// class test extends StatefulWidget {
//   const test({super.key});

//   @override
//   State<test> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<test> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: FutureBuilder(
//             future: getUsuarios(),
//             builder: ((context, snapshot) {
//               if (snapshot.hasData) {
//                 return ListView.builder(
//                     itemCount: snapshot.data?.length,
//                     itemBuilder: ((context, index) {
//                       return Text(snapshot.data![index]['nombre']);
//                     }));
//               }
//               return Text('2');
//             })));
//   }
// }
