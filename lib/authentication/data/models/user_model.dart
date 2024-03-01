import 'dart:convert';

import 'package:school_course_app_1/authentication/domain/entities/user.dart';
import 'package:school_course_app_1/core/utils/typedef.dart';

class UserModel extends User {
  const UserModel(
      {required super.id,
      required super.name,
      required super.avatar,
      required super.createdAt});

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  UserModel.fromMap(DataMap map)
      : this(
          avatar: map['avatar'] as String,
          id: map['id'] as String,
          name: map['name'] as String,
          createdAt: map['createdAt'] as String,
        );

  DataMap toMap() =>
      {'id': id, 'avatar': avatar, 'createdAt': createdAt, 'name': name};

  String toJson() => jsonEncode(toMap());

  UserModel copyWith({
    String? avatar,
    String? id,
    String? createdAt,
    String? name,
  }) {
    return UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
        createdAt: createdAt ?? this.createdAt);
  }

  const UserModel.empty()
      : this(
            id: "1",
            createdAt: "empty_ct",
            name: "empty_na",
            avatar: "empty_at");
}
