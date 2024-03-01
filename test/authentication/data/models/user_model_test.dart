import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:school_course_app_1/authentication/data/models/user_model.dart';
import 'package:school_course_app_1/authentication/domain/entities/user.dart';
import 'package:school_course_app_1/core/utils/typedef.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = UserModel.empty();
  test('should be a subclasss of [User] entity', () {
    expect(tModel, equals(isA<User>()));
  });

  final tJson = fixture('user.json');
  final tMap = jsonDecode(tJson) as DataMap;

  group('fromMap', () {
    test('should return a [Usermodel] with the right data', () {
      final result = UserModel.fromMap(tMap);
      expect(result, equals(tModel));
    });
  });

  group('fromJson', () {
    test('should return a [Usermodel] with the right data', () {
      final result = UserModel.fromJson(tJson);
      expect(result, equals(tModel));
    });
  });

  group('toMap', () {
    test('should return a [Map] with the right data ', () {
      final result = tModel.toMap();
      expect(result, equals(tMap));
    });
  });

  group('toJson', () {
    test('should return a [DataMap] with the right data ', () {
      final result = tModel.toJson();

      final tJson = jsonEncode({
        "id": "1",
        "avatar": "empty_at",
        "createdAt": "empty_ct",
        "name": "empty_na"
      });

      expect(result, equals(tJson));
    });
  });

  group('copyWith', () {
    test('should return a [UserModel] with the right data ', () {
      // arrange

      final result = tModel.copyWith(name: 'Aleem');
      expect(result.name, equals('Aleem'));
    });
  });
}
