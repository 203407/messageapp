import 'package:actividad1/features/games/data/models/games_models.dart';
import 'package:actividad1/features/games/domain/entities/game.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert' as convert;

abstract class GamesRemoteDataSource {
  // https://jsonplaceholder.typicode.com/posts
  Future<List<GamesModel>> getGames(d);
  Future<String> createGames(nombre, descrip, img);
  Future<String> updateGames(id, stars, descri, titulo, img);
  Future<String> deleteGames(id);
}

class GamesRemoteDataSourceImp implements GamesRemoteDataSource {
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Future<List<GamesModel>> getGames(d) async {
    List games = [];
    CollectionReference collectionReferenceGames = db.collection('games');

    QuerySnapshot queryGames = await collectionReferenceGames.get();

    for (var doc in queryGames.docs) {
      final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      final game = {
        'Estrellas': data['Estrellas'],
        'Descripcion': data['Descripcion'],
        'Imagen': data['Imagen'],
        'id': doc.id,
        'Titulo': data['Titulo']
      };

      games.add(game);
    }
    // queryGames.docs.forEach((element) {
    //   games.add(element.data());
    // });

    return games.map<GamesModel>((data) => GamesModel.fromJson(data)).toList();
  }

  @override
  Future<String> createGames(nombre, descrip, img) async {
    int a = 0;

    final data = {
      "Titulo": nombre.toString(),
      "Imagen": img.toString(),
      "Descripcion": descrip.toString(),
      "Estrellas": a
    };

    await db.collection("games").add(data);

    return "si";
  }

  @override
  Future<String> updateGames(id, stars, descri, titulo, img) async {
    final data = {
      "Titulo": titulo.toString(),
      "Imagen": img.toString(),
      "Descripcion": descri.toString(),
      "Estrellas": stars
    };

    await db.collection("games").doc(id).set(data);

    return "si2";
  }

  @override
  Future<String> deleteGames(id) async {
    await db.collection("games").doc(id).delete();
    return "si3";
  }
}
