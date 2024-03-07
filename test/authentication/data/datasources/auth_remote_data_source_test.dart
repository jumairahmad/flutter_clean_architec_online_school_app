import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:school_course_app_1/authentication/data/datasources/auth_remote_data_source.dart';
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
              'createAt': 'createdAt',
              'name': 'name',
              'avatar': 'avatar',
            }),
          )).called(1);

      verifyNoMoreInteractions(client);
    });

    //second test

    
  });
}
