part of 'authentication_cubit.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

class CreatingUser extends AuthenticationState {
  const CreatingUser();
}

class GettingUsers extends AuthenticationState {
  const GettingUsers();
}

class UserCreated extends AuthenticationState {
  const UserCreated();
}

class AuthenticationErr extends AuthenticationState {
  const AuthenticationErr(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}

class UsersLoaded extends AuthenticationState {
  const UsersLoaded(this.users);
  final List<User> users;

  @override
  List<Object> get props => users.map((user) => user.id).toList();
}
