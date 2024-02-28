import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:school_course_app_1/authentication/domain/repositries/auth_repo.dart';
import 'package:school_course_app_1/authentication/domain/usecases/createUser.dart';

class MockAuthRepo extends Mock implements AuthRepo {}

void main() {
  late CreateUser usecase;
  late AuthRepo repository;

  setUp(() {
    repository = MockAuthRepo();
    usecase = CreateUser(repository);
  });

  const params = CreateUserParams.empty();
  test(
    'should call the [AuthRepo.createuser]',
    () async {
      //arrange

      when(
        () => repository.createUser(
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
          createdAt: any(named: 'createdAt'),
        ),
      ).thenAnswer((_) async => const Right(null));

      //act

      final result = await usecase(params);

      // assert

      expect(result, equals(const Right<dynamic, void>(null)));

      verify(() => repository.createUser(
          name: params.name,
          avatar: params.avatar,
          createdAt: params.createdAt)).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
