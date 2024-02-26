import 'package:school_course_app_1/authentication/domain/entities/user.dart';

import 'package:school_course_app_1/core/utils/typedef.dart';

abstract class AuthRepo {
  const AuthRepo();

  ResultVoid createUser(
      {required String name,
      required String avatar,
      required String createdAt});

  ResultFuture<List<User>> getUsers();
}
