import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/createUser.dart';
import '../../domain/usecases/get_users.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({
    required CreateUser createUser,
    required GetUsers getUsers,
  })  : _createUser = createUser,
        _getUsers = getUsers,
        super(const AuthenticationInitial());

  final CreateUser _createUser;
  final GetUsers _getUsers;

  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    emit(const CreatingUser());

    final result = await _createUser(
        CreateUserParams(name: name, avatar: avatar, createdAt: createdAt));

    //lets check the results and return the error or results so that the results will be added

    result.fold(
      (failure) => emit(
        AuthenticationErr(failure.errorMessage),
      ),
      (r) => emit(const UserCreated()),
    );
  }

  Future<void> getUsers() async {
    emit(const GettingUsers());

    final results = await _getUsers();
    results.fold(
        (failure) => emit(
              AuthenticationErr(failure.errorMessage),
            ),
        (users) => emit(UsersLoaded(users)));
  }
}
