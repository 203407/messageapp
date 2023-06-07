import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messageapp/features/message/users/presentation/blocs/users_bloc.dart';

class SignF extends StatefulWidget {
  const SignF({super.key});

  @override
  State<SignF> createState() => _SignFState();
}

class _SignFState extends State<SignF> {
  @override
  void initState() {
    super.initState();
    context.read<UsersBloc>().add(GetUsers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: const Color.fromARGB(255, 35, 35, 35),
        body: BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        if (state is Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is Loaded) {
          return SingleChildScrollView(
            child: Column(
                children: state.users.map((users) {
              return Text(users.username);
            }).toList()),
          );
        } else if (state is Error) {
          return Center(
            child: Text(state.error, style: const TextStyle(color: Colors.red)),
          );
        } else {
          return const Text('s');
        }
      },
    ));
  }
}
