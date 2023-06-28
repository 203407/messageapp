import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:messageapp/features/message/users/presentation/blocs/users_bloc.dart';
import 'package:messageapp/features/message/users/presentation/pages/loginJesus.dart';
import 'package:messageapp/features/message/users/presentation/pages/showcontactos.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key, required this.username, required this.correouser})
      : super(key: key);

  final String? username;
  final String? correouser;

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  void initState() {
    super.initState();
    context.read<UsersBloc>().add(GetUsers(username: widget.username!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            color: Color.fromARGB(255, 235, 235, 235),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      widget.username!,
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 120),
                      child: Text(
                        widget.correouser!,
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.logout),
                      color: Color.fromARGB(255, 0, 0, 0),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPages()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 1.0,
            color: Colors.black,
          ),
          Container(
            child: BlocBuilder<UsersBloc, UsersState>(
              builder: (context, state) {
                if (state is Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is Loaded) {
                  return SingleChildScrollView(
                    child: Column(
                        children: state.users.map((users) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: ShowContactos(
                          username: users.username,
                          currentUser: widget.username,
                          correother: users.correo,
                          correousuario: widget.correouser,
                        ),
                      );
                    }).toList()),
                  );
                } else if (state is Error) {
                  return Center(
                    child: Text(state.error,
                        style: const TextStyle(color: Colors.red)),
                  );
                } else {
                  return const Text('s');
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
