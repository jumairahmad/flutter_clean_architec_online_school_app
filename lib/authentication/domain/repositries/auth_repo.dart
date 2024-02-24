import 'package:school_course_app_1/authentication/domain/entities/user.dart';

abstract class AuthRepo {
  const AuthRepo();

  Future<void> createUser(
      {required String name,
      required String avatar,
      required String createdAt});

  Future<List<User>> getUsers();
}
