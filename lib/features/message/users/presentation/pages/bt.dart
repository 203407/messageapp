import 'package:actividad1/features/games/presentation/blocs/games_bloc.dart';
import 'package:actividad1/features/games/presentation/pages/viewReview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../main.dart';

class Bt extends StatelessWidget {
  const Bt(
      {super.key,
      this.titulo,
      this.imagen,
      this.descrip,
      this.estrellas,
      this.id});
  final String? titulo, imagen, descrip, id;
  final double? estrellas;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
          width: 500,
          height: 100,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 207, 205, 205),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.only(right: 9.0, left: 9),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 245, 245),
                  minimumSize: Size(3, 3),
                ),
                onPressed: () {},
                child: Image(
                  image: NetworkImage(imagen!),
                  height: 60,
                  width: 60,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 245, 245),
                      minimumSize: const Size(180, 100),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewReview(
                                  titulo: titulo,
                                  imagen: imagen,
                                  descrip: descrip,
                                  estrellas: estrellas,
                                  id: id)));
                    },
                    child: Column(
                      children: [
                        Padding(
                            padding:
                                const EdgeInsets.only(left: 0.0, bottom: 1),
                            child: Text(titulo!)),
                        Column(
                          children: [
                            const Text("Calificacion"),
                            RatingBar.builder(
                              initialRating: estrellas!,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 15,
                              // ignore: prefer_const_constructors
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                          ],
                        ),
                      ],
                    ))),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: IconButton(
                  onPressed: () async {
                    String resultado =
                        await usecaseConfig.deleteGameUsecase!.execute(id);
                    context.read<GamesBloc>().add(GetGames());
                  },
                  icon: const Icon(
                    Icons.delete_rounded,
                    size: 30,
                    color: Color.fromARGB(255, 218, 31, 31),
                  )),
            )
          ])),
    );
  }
}
