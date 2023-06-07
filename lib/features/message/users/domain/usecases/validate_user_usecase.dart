import '../repositories/users_repositories.dart';

class ValidateUsersUsecase {
  final UsersRepository usersRepository;

  ValidateUsersUsecase(this.usersRepository);

  Future<String> execute(username, passw) async {
    return await usersRepository.validateUser(username, passw);
  }
}
