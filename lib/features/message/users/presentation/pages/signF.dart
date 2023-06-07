import 'package:actividad1/features/games/presentation/blocs/games_bloc.dart';
import 'package:actividad1/features/games/presentation/pages/bt.dart';
import 'package:actividad1/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../usecase_config.dart';
import '../../domain/usecases/create_games_usecase.dart';

class SignF extends StatefulWidget {
  const SignF({super.key});

  // here

  @override
  State<SignF> createState() => _SignFState();
}

class _SignFState extends State<SignF> {
  @override
  void initState() {
    super.initState();
    context.read<GamesBloc>().add(GetGames());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 35, 35, 35),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(208, 0, 0, 0),
          actions: const <Widget>[],
          title: Row(
            children: const [
              CircleAvatar(
                  backgroundImage: AssetImage('assets/images/games.jpg')),
              Padding(
                padding: EdgeInsets.only(left: 18.0),
                child: Text(
                  "GameReview",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          splashColor: Colors.green,
          elevation: 10.0,
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
          onPressed: () async {
            await openDialog();
            setState(() {});
          },
        ),
        body: BlocBuilder<GamesBloc, GamesState>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is Loaded) {
              return SingleChildScrollView(
                child: Column(
                    children: state.games.map((games) {
                  return Bt(
                      titulo: games.titulo,
                      imagen: games.imagen,
                      descrip: games.descripcion,
                      estrellas: games.estrellas.toDouble(),
                      id: games.id);
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
        ));
  }

  Future openDialog() async {
    TextEditingController nameController = TextEditingController();
    TextEditingController descripController = TextEditingController();
    TextEditingController imageController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Agregar nuevo juego'),
          content: SingleChildScrollView(
            child: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
                  child: Column(
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(labelText: 'Nombre'),
                      ),
                      TextField(
                        controller: descripController,
                        decoration:
                            const InputDecoration(labelText: 'Descripción'),
                      ),
                      TextField(
                        controller: imageController,
                        decoration:
                            const InputDecoration(labelText: 'Imagen (URL)'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                String name = nameController.text;
                String descrip = descripController.text;
                String image = imageController.text;

                String resultado = await usecaseConfig.createGameUsecase!
                    .execute(name, descrip, image);

                // ignore: use_build_context_synchronously
                Navigator.pushAndRemoveUntil(
                  context,
                  // MaterialPageRoute(builder: (context) => Sign(user: user)),
                  MaterialPageRoute(builder: (context) => const SignF()),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text('Agregar'),
            ),
          ],
        );
      },
    );
  }
}
