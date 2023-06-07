import 'package:actividad1/features/games/presentation/pages/signF.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../main.dart';
import '../../../../usecase_config.dart';
import '../notifications/notification_api.dart';

class ViewReview extends StatelessWidget {
  const ViewReview(
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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 35, 35, 35),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: const <Widget>[],
        iconTheme: const IconThemeData(color: Colors.white),
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
        backgroundColor: const Color.fromARGB(208, 0, 0, 0),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 43.0),
        child: Column(children: [
          SizedBox(
            width: 300, // Ancho deseado
            height: 250, // Alto deseado
            child: Image.network(imagen!),
          ),
          Container(
            height: 280,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            child: Column(children: [
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text("Nombre del juego:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: Text(titulo!),
              ),
              const Text("Reseña:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, bottom: 20, left: 10, right: 10),
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(10)),
                    width: 300,
                    height: 100,
                    child: Scrollbar(
                      isAlwaysShown: true,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            descrip!,
                          ),
                        ),
                      ),
                    )),
              ),
              const Text("Calificacion",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              RatingBar.builder(
                initialRating: estrellas!.toDouble(),
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 20,
                // ignore: prefer_const_constructors
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) async {
                  // print(rating.toInt());
                  // print(titulo);

                  // print(id);
                  showNotification(
                      title: 'Haz cambiado la calificacion a $titulo',
                      body: 'Gracias por tu opinion');

                  if (usecaseConfig != null) {
                    String sxd = await usecaseConfig.updateGameUsecase!
                        .execute(id, rating.toInt(), descrip, titulo, imagen);
                  }
                },
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 300.0, top: 10),
            child: FloatingActionButton(
              splashColor: Colors.green,
              elevation: 10.0,
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  // MaterialPageRoute(builder: (context) => Sign(user: user)),
                  MaterialPageRoute(builder: (context) => const SignF()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
