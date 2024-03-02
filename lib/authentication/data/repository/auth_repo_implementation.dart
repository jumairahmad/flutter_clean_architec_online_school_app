import 'package:dartz/dartz.dart';
import 'package:school_course_app_1/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:school_course_app_1/authentication/domain/entities/user.dart';
import 'package:school_course_app_1/authentication/domain/repositries/auth_repo.dart';
import 'package:school_course_app_1/core/errors/exceptions.dart';
import 'package:school_course_app_1/core/errors/failure.dart';
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
    try {
      await _remoteDataSource.createUser(
          name: name, avatar: avatar, createdAt: createdAt);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ApiFailure(message: e.message, code: e.statusCode));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    // TODO: implement getUsers
    throw UnimplementedError();
  }
}
