import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messageapp/features/message/users/presentation/blocs/users_bloc.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  late String _username;
  late String _email;
  late String _password;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Nombre de usuario'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, introduce un nombre de usuario';
                  }
                  return null;
                },
                onSaved: (value) {
                  _username = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Correo electrónico'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, introduce un correo electrónico';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, introduce una contraseña';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              BlocBuilder<UsersBloc, UsersState>(
                builder: (context, state) {
                  if (state is SavingUser) {
                    return const CircularProgressIndicator();
                  } else if (state is UserSaved) {
                    return const Text("Usuario guardado exitosamente",
                        style: TextStyle(color: Colors.green));
                  } else if (state is ErrorSavingUser) {
                    return Text(state.message,
                        style: const TextStyle(color: Colors.red));
                  } else {
                    return Container();
                  }
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Aquí puedes realizar las acciones necesarias para registrar al usuario
                    // como enviar los datos a una API o guardarlos localmente.

                    context.read<UsersBloc>().add(PressCreateUserButton(
                        username: _username, correo: _email, passw: _password));

                    print('Nombre de usuario: $_username');
                    print('Correo electrónico: $_email');
                    print('Contraseña: $_password');
                  }
                },
                child: Text('Registrarse'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
