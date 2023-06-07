import 'package:actividad1/features/games/data/datasources/game_remote_data_source.dart';
import 'package:actividad1/features/games/domain/entities/game.dart';
import 'package:actividad1/features/games/domain/repositories/games_repositories.dart';

class GameRepositoryImpl implements GamesRepository {
  final GamesRemoteDataSource gamesRemoteDataSource;

  GameRepositoryImpl({required this.gamesRemoteDataSource});

  @override
  Future<List<Game>> getGames(d) async {
    return await gamesRemoteDataSource.getGames(d);
  }

  @override
  Future<String> createGames(nombre, descrip, img) async {
    return await gamesRemoteDataSource.createGames(nombre, descrip, img);
  }

  @override
  Future<String> deleteGames(id) async {
    return await gamesRemoteDataSource.deleteGames(id);
  }

  @override
  Future<String> updateGames(id, stars, descri, titulo, img) async {
    return await gamesRemoteDataSource.updateGames(
        id, stars, descri, titulo, img);
  }
}
