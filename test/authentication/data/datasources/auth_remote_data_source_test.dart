import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:school_course_app_1/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:school_course_app_1/core/errors/exceptions.dart';
import 'package:school_course_app_1/core/utils/constants.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthRemoteDataSource remoteDataSource;
  registerFallbackValue(Uri());

  setUp(() {
    client = MockClient();

    remoteDataSource = AuthRemoteDataSourceImpl(client);
  });

  group('createUser', () {
    test('should complete successfully when the status code is 200 or 2021',
        () async {
      //act
      when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
        (_) async => http.Response('user created successfully', 201),
      );

      final methodCall = remoteDataSource.createUser;

      expect(methodCall(createdAt: 'createdAt', name: 'name', avatar: 'avatar'),
          completes);

      verify(() => client.post(
            Uri.parse('$kBaseUrl$kCreateUserEndpoint'),
            body: jsonEncode({
              'createdAt': 'createdAt',
              'name': 'name',
              'avatar': 'avatar',
            }),
          )).called(1);

      verifyNoMoreInteractions(client);
    });

    //second test
    test('should throw API EXception when the status code is not 200 or 2021',
        () async {
      when(() => client.post(any(), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response('error creating user', 400));

      final methodCall = remoteDataSource.createUser;

      expect(
        () async =>
            methodCall(createdAt: 'createdAt', name: 'name', avatar: 'avatar'),
        throwsA(
          const APIException(message: 'error creating user', statusCode: 400),
        ),
      );
      verify(() => client.post(
            Uri.parse('$kBaseUrl$kCreateUserEndpoint'),
            body: jsonEncode({
              'createdAt': 'createdAt',
              'name': 'name',
              'avatar': 'avatar',
            }),
          )).called(1);

      verifyNoMoreInteractions(client);
    });
  });

//lets write tests for getusers

  group('getusers', () {
    test('should return a list of Users ', () async {
      when(() => client.get(any())).thenAnswer(
          (_) async => http.Response('geting users successfully', 200));

      final methodcall = remoteDataSource.getUsers;

      expect(methodcall(), completes);

      verify(
        () => client.get(Uri.parse('$kBaseUrl$kGetuserEndPoint')),
      ).called(1);

      verifyNoMoreInteractions(client);
    });

    //second test for server failure for chekcing if any exception occured orr not

    test('should return APIFailure', () async {
      when(
        () => client.get(any()),
      ).thenAnswer(
        (_) async => http.Response('error getting users', 400),
      );

      // next step
      final methodcall = remoteDataSource.getUsers;

      expect(
        () async => methodcall(),
        throwsA(
          const APIException(message: 'error getting users', statusCode: 400),
        ),
      );

      //last step
      verify(
        () => client.get(Uri.parse('$kBaseUrl$kGetuserEndPoint')),
      ).called(1);

      verifyNoMoreInteractions(client);
    });
  });
}
