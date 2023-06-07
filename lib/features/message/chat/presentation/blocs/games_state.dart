part of 'games_bloc.dart';

@immutable
abstract class GamesState {}

class GamesInitial extends GamesState {}

class Loading extends GamesState {}

class Loaded extends GamesState {
  final List<Game> games;

  Loaded({required this.games});
}

class Error extends GamesState {
  final String error;

  Error({required this.error});
}
