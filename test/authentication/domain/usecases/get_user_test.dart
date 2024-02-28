import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:school_course_app_1/authentication/domain/entities/user.dart';
import 'package:school_course_app_1/authentication/domain/repositries/auth_repo.dart';
import 'package:school_course_app_1/authentication/domain/usecases/get_users.dart';

import 'authentication_repo.mock.dart';

void main() {
  late AuthRepo repository;
  late GetUsers usecase;

  setUp(() {
    repository = MockAuthRepo();
    usecase = GetUsers(repository);
  });

  const tResponse = [User.empty()];

  test(
    'this test should call [AuthRepo.getusers] and returns List<Users>',
    () async {
      //arrange
      when(
        () => repository.getUsers(),
      ).thenAnswer((_) async => const Right(tResponse));

      // act

      final result = await usecase();

      //assert

      expect(result, equals(const Right<dynamic, List<User>>(tResponse)));
      verify(() => repository.getUsers()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
