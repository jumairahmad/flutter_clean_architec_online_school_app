import 'package:school_course_app_1/authentication/domain/entities/user.dart';
import 'package:school_course_app_1/authentication/domain/repositries/auth_repo.dart';
import 'package:school_course_app_1/core/usecase/usecase.dart';
import 'package:school_course_app_1/core/utils/typedef.dart';

class GetUsers extends UseCaseWithOutParams<List<User>> {
  const GetUsers(this._repository);

  final AuthRepo _repository;

  @override
  ResultFuture<List<User>> call() => _repository.getUsers();
}
