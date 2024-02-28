import 'package:equatable/equatable.dart';
import 'package:school_course_app_1/authentication/domain/repositries/auth_repo.dart';
import 'package:school_course_app_1/core/usecase/usecase.dart';
import 'package:school_course_app_1/core/utils/typedef.dart';

class CreateUser extends UseCaseWithParams<void, CreateUserParams> {
  const CreateUser(this._repository);
  final AuthRepo _repository;

  @override
  ResultVoid call(CreateUserParams params) => _repository.createUser(
      name: params.name, avatar: params.avatar, createdAt: params.createdAt);
}

class CreateUserParams extends Equatable {
  final String name;
  final String avatar;
  final String createdAt;

  const CreateUserParams(
      {required this.name, required this.avatar, required this.createdAt});

  const CreateUserParams.empty()
      : this(createdAt: '_empty_ca', name: 'empty_na', avatar: 'empty_av');

  @override
  List<Object?> get props => [createdAt, name, avatar];
}
