import 'package:actividad1/features/games/domain/entities/game.dart';
import 'package:actividad1/features/games/domain/usecases/get_games_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'games_event.dart';
part 'games_state.dart';

class GamesBloc extends Bloc<GamesEvent, GamesState> {
  final GetGameUsecase getGameUsecase;

  GamesBloc({required this.getGameUsecase}) : super(Loading()) {
    on<GamesEvent>((event, emit) async {
      if (event is GetGames) {
        try {
          List<Game> response = await getGameUsecase.execute(123);
          emit(Loaded(games: response));
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      }
    });
  }
}
