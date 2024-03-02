import 'package:school_course_app_1/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:school_course_app_1/authentication/domain/entities/user.dart';
import 'package:school_course_app_1/authentication/domain/repositries/auth_repo.dart';
import 'package:school_course_app_1/core/utils/typedef.dart';

class AuthRepoImplementation implements AuthRepo {
  //dependency inversion comes in because now this class is dependents on remotedata source we pass it to constructot for test cases

  AuthRepoImplementation(this._remoteDataSource);
  final AuthRemoteDataSource _remoteDataSource;
  @override
  ResultVoid createUser(
      {required String name,
      required String avatar,
      required String createdAt}) async {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    // TODO: implement getUsers
    throw UnimplementedError();
  }
}
