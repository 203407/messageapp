import 'package:actividad1/features/games/domain/entities/game.dart';

abstract class GamesRepository {
  Future<List<Game>> getGames(a);
  Future<String> updateGames(id, stars, descri, titulo, img);
  Future<String> createGames(nombre, descrip, img);
  Future<String> deleteGames(id);
}
