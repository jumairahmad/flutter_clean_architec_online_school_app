import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String createdAt;
  final String avatar;

  const User(
      {required this.id,
      required this.name,
      required this.createdAt,
      required this.avatar});

  const User.empty()
      : this(
            id: '1',
            name: 'empty_na',
            createdAt: 'empty_ca',
            avatar: 'empty_av');

  @override
  List<Object?> get props => [id, name, avatar];
}
