import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messageapp/features/message/users/presentation/blocs/users_bloc.dart';
import 'package:messageapp/features/message/users/presentation/pages/loginJesus.dart';

class RegistrationFormJesus extends StatefulWidget {
  const RegistrationFormJesus({Key? key}) : super(key: key);

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationFormJesus> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 40, bottom: 40),
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/login.png',
                  height: 150.0,
                  width: 150.0,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 40.0),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FractionallySizedBox(
                      widthFactor: 0.8,
                      child: TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: 'Username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa un nombre de usuario.';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 16.0),
                    FractionallySizedBox(
                      widthFactor: 0.8,
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa un correo electrónico.';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 16.0),
                    FractionallySizedBox(
                      widthFactor: 0.8,
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.key),
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa una contraseña.';
                          }
                          return null;
                        },
                      ),
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
                    SizedBox(height: 24.0),
                    FractionallySizedBox(
                      widthFactor: 0.8,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            String correo = _emailController.text;
                            String passw = _passwordController.text;
                            String username = _usernameController.text;

                            print(correo);
                            print(passw);
                            print(username);

                            context.read<UsersBloc>().add(PressCreateUserButton(
                                username: username,
                                correo: correo,
                                passw: passw));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.lightBlue.withOpacity(0.7),
                          onPrimary: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: Text(
                          'Registrarse',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPages(),
                          ),
                        );
                      },
                      child: Text(
                        '¿Ya tienes cuenta? Inicia sesión',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.lightBlue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
