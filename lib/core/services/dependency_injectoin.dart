import 'package:get_it/get_it.dart';
import 'package:school_course_app_1/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:school_course_app_1/authentication/data/repository/auth_repo_implementation.dart';
import 'package:school_course_app_1/authentication/domain/repositries/auth_repo.dart';
import 'package:school_course_app_1/authentication/domain/usecases/createUser.dart';
import 'package:school_course_app_1/authentication/domain/usecases/get_users.dart';
import 'package:school_course_app_1/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  // app logic

  sl.registerFactory(
      () => AuthenticationCubit(createUser: sl(), getUsers: sl()));

  // usecase
  sl.registerLazySingleton(() => CreateUser(sl()));
  sl.registerLazySingleton(() => GetUsers(sl()));

// REpositories

  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImplementation(sl()));

  // Data sources

  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl()));

  //external dependencies

  sl.registerLazySingleton(http.Client.new);
}
