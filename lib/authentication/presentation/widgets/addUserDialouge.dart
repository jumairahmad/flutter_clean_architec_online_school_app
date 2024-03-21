import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_course_app_1/authentication/presentation/cubit/authentication_cubit.dart';

class AddUserDialoge extends StatelessWidget {
  const AddUserDialoge({super.key, required this.nametextcontroller});
  final TextEditingController nametextcontroller;
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nametextcontroller,
                decoration: const InputDecoration(
                  labelText: 'username',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final name = nametextcontroller.text.trim();
                  context.read<AuthenticationCubit>().createUser(
                      createdAt: DateTime.now().toString(),
                      name: name,
                      avatar: 'avatar');
                  Navigator.of(context).pop();
                },
                child: const Text('CreateUser'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
