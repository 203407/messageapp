import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messageapp/features/message/users/presentation/blocs/users_bloc.dart';
import 'package:messageapp/features/message/users/presentation/pages/registerJesus.dart';
import 'package:messageapp/features/message/users/presentation/pages/menu.dart';

class LoginPages extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
              Text(
                'WELCOME',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4.0,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.0),
              FractionallySizedBox(
                widthFactor: 0.8,
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              FractionallySizedBox(
                widthFactor: 0.8,
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.key),
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 24.0),
              FractionallySizedBox(
                widthFactor: 0.8,
                child: ElevatedButton(
                  onPressed: () {
                    String username = _emailController.text;
                    String password = _passwordController.text;

                    context.read<UsersBloc>().add(PressLoginUserButton(
                        username: username, passw: password));
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
                    'Iniciar sesión',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
              BlocBuilder<UsersBloc, UsersState>(
                builder: (context, state) {
                  if (state is UserVerificando) {
                    return const CircularProgressIndicator();
                  } else if (state is UserVerificado) {
                    if (state.estado['estado'] == "correcto") {
                      print("nombre del estado");
                      print(state.estado['username']);
                      String usernames = _emailController.text;
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MenuPage(
                              username: usernames,
                              correouser: state.estado['correo'],
                            ),
                          ),
                        );
                      });
                      return const SizedBox();
                    } else {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Error de inicio de sesión'),
                              content: const Text(
                                  'Credenciales inválidas. Por favor, inténtalo de nuevo.'),
                              actions: [
                                TextButton(
                                  child: const Text('Cerrar'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      });
                    }
                    return Container();
                  } else if (state is ErrorLoginUser) {
                    return Text(state.message,
                        style: const TextStyle(color: Colors.red));
                  } else {
                    return Container();
                  }
                },
              ),
              SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegistrationFormJesus(),
                    ),
                  );
                },
                child: Text(
                  '¿No tienes cuenta? CREE UNA AHORA',
                  style: TextStyle(
                    color: Colors.lightBlue.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
