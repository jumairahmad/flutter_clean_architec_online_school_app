import 'package:equatable/equatable.dart';
import 'package:school_course_app_1/core/errors/exceptions.dart';

class Failure extends Equatable {
  const Failure({required this.message, required this.code});

  final String message;
  final int code;

  @override
  List<Object?> get props => [message, code];
}

class ApiFailure extends Failure {
  const ApiFailure({required super.message, required super.code});

  factory ApiFailure.fromException(APIException exception) =>
      ApiFailure(message: exception.message, code: exception.statusCode);
}
