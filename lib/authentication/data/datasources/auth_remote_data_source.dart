import 'package:school_course_app_1/authentication/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<void> createUser(
      {required String name,
      required String avatar,
      required String createdAt});

  Future<List<UserModel>> getUsers();
}
