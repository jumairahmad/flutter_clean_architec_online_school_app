import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:school_course_app_1/authentication/domain/entities/user.dart';
import 'package:school_course_app_1/authentication/domain/usecases/createUser.dart';
import 'package:school_course_app_1/authentication/domain/usecases/get_users.dart';
import 'package:school_course_app_1/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:school_course_app_1/core/errors/failure.dart';

class MockGetUsers extends Mock implements GetUsers {}

class MockCreateUsers extends Mock implements CreateUser {}

void main() {
  //lets write tests for the presentation of authentication
  // for cubit only of authentication
  late GetUsers getUsers;
  late CreateUser createUser;
  late AuthenticationCubit cubit;
  const tCreateUserParam = CreateUserParams.empty();
  const tApiFailure = ApiFailure(message: 'message', code: 400);
  const tUsers = [User.empty()];
  registerFallbackValue(tCreateUserParam);
  registerFallbackValue(tApiFailure);
  registerFallbackValue(tUsers);
  setUp(() {
    getUsers = MockGetUsers();
    createUser = MockCreateUsers();
    cubit = AuthenticationCubit(createUser: createUser, getUsers: getUsers);
  });

  //lets tear down our cubit before testing it

  tearDown(() => cubit.close());

  //lets test for initial state of cubit

  test('should test the cubit initial state to [AuthenticationInititals]',
      () async {
    expect(cubit.state, const AuthenticationInitial());
  });

  // for testing cubit of create user
  group(
    'createuser',
    () {
      blocTest<AuthenticationCubit, AuthenticationState>(
        'should emit [CreatingUser, UserCreated] on success',
        build: () {
          when(() => createUser(any())).thenAnswer(
            (_) async => const Right(null),
          );
          return cubit;
        },
        act: (cubit) => cubit.createUser(
            createdAt: tCreateUserParam.createdAt,
            name: tCreateUserParam.name,
            avatar: tCreateUserParam.avatar),
        expect: () => const [
          CreatingUser(),
          UserCreated(),
        ],
        verify: (_) {
          verify(() => createUser(tCreateUserParam)).called(1);
          verifyNoMoreInteractions(createUser);
        },
      );

      blocTest(
        'should return [ApiFailure] on failure',
        build: () {
          when(
            () => createUser(any()),
          ).thenAnswer((_) async => const Left(tApiFailure));
          return cubit;
        },
        act: (cubit) => cubit.createUser(
            createdAt: tCreateUserParam.createdAt,
            name: tCreateUserParam.name,
            avatar: tCreateUserParam.avatar),
        expect: () =>
            [const CreatingUser(), AuthenticationErr(tApiFailure.errorMessage)],
        verify: (_) {
          verify(() => createUser(tCreateUserParam)).called(1);
          verifyNoMoreInteractions(createUser);
        },
      );
    },
  );

// for testing cubit of getting users

  group(
    'getusers',
    () {
      blocTest<AuthenticationCubit, AuthenticationState>(
          'should emit [GettingUsers, UsersLoaded] on success ',
          build: () {
            when(() => getUsers()).thenAnswer((_) async => const Right(tUsers));

            return cubit;
          },
          act: (cubit) => cubit.getUsers(),
          expect: () => const [GettingUsers(), UsersLoaded(tUsers)],
          verify: (_) {
            verify(() => getUsers()).called(1);
            verifyNoMoreInteractions(getUsers);
          });

      blocTest(
        'should emit [APiFailure] on failure',
        build: () {
          when(() => getUsers()).thenAnswer(
            (_) async => const Left(tApiFailure),
          );
          return cubit;
        },
        act: (cubit) => cubit.getUsers(),
        expect: () =>
            [const GettingUsers(), AuthenticationErr(tApiFailure.errorMessage)],
        verify: (_) {
          verify(() => getUsers()).called(1);
          verifyNoMoreInteractions(getUsers);
        },
      );
    },
  );
}
