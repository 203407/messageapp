import 'package:messageapp/features/message/users/data/datasources/user_remote_data_source.dart';
import 'package:messageapp/features/message/users/data/repositories/users_repository_impl.dart';
import 'package:messageapp/features/message/users/domain/usecases/create_games_usecase.dart';
import 'package:messageapp/features/message/users/domain/usecases/get_users_usecase.dart';
import 'package:messageapp/features/message/users/domain/usecases/validate_user_usecase.dart';

class UsecaseConfig {
  GetUsersUsecase? getUsersUsecase;
  CreateUserUsecase? createUserUsecase;
  ValidateUsersUsecase? validateUsersUsecase;

  UsersRepositoryImpl? usersRepositoryImpl;
  UsersRemoteDataSourceImp? usersRemoteDataSourceImp;

  UsecaseConfig() {
    usersRemoteDataSourceImp = UsersRemoteDataSourceImp();
    usersRepositoryImpl =
        UsersRepositoryImpl(usersRemoteDataSource: usersRemoteDataSourceImp!);
    getUsersUsecase = GetUsersUsecase(usersRepositoryImpl!);
    createUserUsecase = CreateUserUsecase(usersRepositoryImpl!);
    validateUsersUsecase = ValidateUsersUsecase(usersRepositoryImpl!);
  }
}
