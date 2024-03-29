import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_course_app_1/authentication/domain/usecases/createUser.dart';
import 'package:school_course_app_1/authentication/domain/usecases/get_users.dart';

import '../../domain/entities/user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required CreateUser createUser,
    required GetUsers getUsers,
  })  : _createUser = createUser,
        _getUsers = getUsers,
        super(AuthenticationInitial()) {
    //lets add our evenets here

    on<CreateUserEvent>(_createUserHandler);
    on<GetUsersEvent>(_getUsersHandler);
  }

  final CreateUser _createUser;
  final GetUsers _getUsers;

  Future<void> _createUserHandler(
      CreateUserEvent event, Emitter<AuthenticationState> emit) async {
    emit(const CreatingUser());

    final result = await _createUser(CreateUserParams(
        name: event.name, avatar: event.avatar, createdAt: event.createdAt));

    //lets check the results and return the error or results so that the results will be added

    result.fold(
      (failure) => emit(
        AuthenticationErr(failure.errorMessage),
      ),
      (r) => const UserCreated(),
    );
  }

  Future<void> _getUsersHandler(
      GetUsersEvent event, Emitter<AuthenticationState> emit) async {
    emit(const GettingUsers());

    final results = await _getUsers();
    results.fold(
        (failure) => emit(
              AuthenticationErr(failure.errorMessage),
            ),
        (users) => emit(UsersLoaded(users)));
  }
}
