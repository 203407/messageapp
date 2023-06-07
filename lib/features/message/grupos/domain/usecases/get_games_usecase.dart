import 'package:actividad1/features/games/domain/entities/game.dart';
import 'package:actividad1/features/games/domain/repositories/games_repositories.dart';

class GetGameUsecase {
  final GamesRepository gamesRepository;

  GetGameUsecase(this.gamesRepository);

  Future<List<Game>> execute(d) async {
    return await gamesRepository.getGames(d);
  }
}
