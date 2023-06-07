import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getUsuarios() async {
  List games = [];

  CollectionReference collectionReferenceGames = db.collection('users');

  QuerySnapshot queryGames = await collectionReferenceGames.get();

  queryGames.docs.forEach((element) {
    games.add(element.data());

    print(games);
  });

  // for (var doc in queryGames.docs) {
  //   final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

  //   final game = {
  //     'Estrellas': data['Estrellas'],
  //     'Descripcion': data['Descripcion'],
  //     'Imagen': data['Imagen'],
  //     'id': doc.id,
  //     'Titulo': data['Titulo']
  //   };

  //   games.add(game);
  // }
  return games;
}
