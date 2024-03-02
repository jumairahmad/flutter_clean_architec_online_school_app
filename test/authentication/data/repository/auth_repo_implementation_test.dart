import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:school_course_app_1/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:school_course_app_1/authentication/data/repository/auth_repo_implementation.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late AuthRemoteDataSource remoteDataSource;
  late AuthRepoImplementation authRepoImplementation;
  setUp(() {
    remoteDataSource = MockAuthRemoteDataSource();
    authRepoImplementation = AuthRepoImplementation(remoteDataSource);
  });

  group('CreateUser', () {
    test('should call [remotedatasoure.createuser] and success', () async {
      when(
        () => remoteDataSource.createUser(
            name: any(named: 'name'),
            avatar: any(named: 'avatar'),
            createdAt: any(named: 'createdAt')),
      ).thenAnswer((_) => Future.value());

      const createdAt = 'whatever';
      const name = 'whatever';
      const avatar = 'whare';
      final result = await authRepoImplementation.createUser(
          name: name, avatar: avatar, createdAt: createdAt);

      expect(result, equals(const Right(null)));
      verify(
        () => remoteDataSource.createUser(
            name: name, avatar: avatar, createdAt: createdAt),
      ).called(1);

      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
