import 'package:messageapp/features/message/users/domain/entities/user.dart';

abstract class UsersRepository {
  Future<List<User>> getUsers();
  Future<String> createUser(username, correo, passw);
  Future<String> validateUser(username, passw);
  // Future<String> updateGames(id, stars, descri, titulo, img);

  // Future<String> deleteGames(id);
}
