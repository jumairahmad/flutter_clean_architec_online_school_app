import 'package:school_course_app_1/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel(
      {required super.id,
      required super.name,
      required super.avatar,
      required super.createdAt});
}
