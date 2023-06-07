import 'package:actividad1/features/games/domain/entities/game.dart';

class GamesModel extends Game {
  GamesModel(
      {required int estrellas,
      required String descripcion,
      required String imagen,
      required String titulo,
      required String id})
      : super(
            estrellas: estrellas,
            descripcion: descripcion,
            imagen: imagen,
            titulo: titulo,
            id: id);

  factory GamesModel.fromJson(Map<String, dynamic> json) {
    // print(json['Estrellas']);
    return GamesModel(
        estrellas: json['Estrellas'],
        descripcion: json['Descripcion'],
        imagen: json['Imagen'],
        titulo: json['Titulo'],
        id: json['id']);
  }

  factory GamesModel.fromEntity(Game game) {
    return GamesModel(
        estrellas: game.estrellas,
        descripcion: game.descripcion,
        imagen: game.imagen,
        titulo: game.titulo,
        id: game.id);
  }
}
