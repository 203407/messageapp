import 'package:messageapp/features/message/users/data/datasources/user_remote_data_source.dart';
import 'package:messageapp/features/message/users/domain/entities/user.dart';
import 'package:messageapp/features/message/users/domain/repositories/users_repositories.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UsersRemoteDataSource usersRemoteDataSource;

  UsersRepositoryImpl({required this.usersRemoteDataSource});

  @override
  Future<List<User>> getUsers() async {
    return await usersRemoteDataSource.getUsers();
  }

  @override
  Future<String> createUser(username, correo, passw) async {
    return await usersRemoteDataSource.createUser(username, correo, passw);
  }

  @override
  Future<String> validateUser(username, passw) async {
    return await usersRemoteDataSource.validateUser(username, passw);
  }
}
