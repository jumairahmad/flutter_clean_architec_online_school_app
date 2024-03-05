import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:school_course_app_1/authentication/data/datasources/auth_remote_data_source.dart';

import 'package:school_course_app_1/authentication/data/repository/auth_repo_implementation.dart';
import 'package:school_course_app_1/authentication/domain/entities/user.dart';
import 'package:school_course_app_1/core/errors/exceptions.dart';
import 'package:school_course_app_1/core/errors/failure.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late AuthRemoteDataSource remoteDataSource;
  late AuthRepoImplementation authRepoImplementation;
  setUp(() {
    remoteDataSource = MockAuthRemoteDataSource();
    authRepoImplementation = AuthRepoImplementation(remoteDataSource);
  });

  const tException =
      APIException(message: 'Unknown error occured', statusCode: 500);

  group('CreateUser', () {
    const createdAt = 'whatever';
    const name = 'whatever';
    const avatar = 'whare';
    test('should call [remotedatasoure.createuser] and success', () async {
      when(
        () => remoteDataSource.createUser(
            name: any(named: 'name'),
            avatar: any(named: 'avatar'),
            createdAt: any(named: 'createdAt')),
      ).thenAnswer((_) => Future.value());

      final result = await authRepoImplementation.createUser(
          name: name, avatar: avatar, createdAt: createdAt);

      expect(result, equals(const Right(null)));
      verify(
        () => remoteDataSource.createUser(
            name: name, avatar: avatar, createdAt: createdAt),
      ).called(1);

      verifyNoMoreInteractions(remoteDataSource);
    });

    test('should return a [ServerFailure] if remote source is unsuccessfukk',
        () async {
      when(
        () => remoteDataSource.createUser(
            name: any(named: 'name'),
            avatar: any(named: 'avatar'),
            createdAt: any(named: 'createdAt')),
      ).thenThrow(tException);

      // act

      final result = await authRepoImplementation.createUser(
          name: name, avatar: avatar, createdAt: createdAt);

      // assert

      expect(
          result,
          equals(Left(ApiFailure(
              message: tException.message, code: tException.statusCode))));

      verify(() => remoteDataSource.createUser(
          name: name, avatar: avatar, createdAt: createdAt)).called(1);

      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  group('GetUsers', () {
    test('should call [remoteDataSource.getUsers]', () async {
      when(
        () => remoteDataSource.getUsers(),
      ).thenAnswer(
        (_) async => [],
      );

      final result = await authRepoImplementation.getUsers();

      expect(result, equals(isA<Right<dynamic, List<User>>>()));

      verify(() => remoteDataSource.getUsers()).called(1);

      verifyNoMoreInteractions(remoteDataSource);
    });

    test('should call [Serverfailure] if unsuccessfull', () async {
      when(
        () => remoteDataSource.getUsers(),
      ).thenThrow(tException);

      final result = await authRepoImplementation.getUsers();

      expect(
          result,
          equals(Left(ApiFailure(
              message: tException.message, code: tException.statusCode))));

      verify(
        () => remoteDataSource.getUsers(),
      ).called(1);

      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
