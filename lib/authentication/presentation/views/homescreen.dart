import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_course_app_1/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:school_course_app_1/authentication/presentation/widgets/addUserDialouge.dart';
import 'package:school_course_app_1/authentication/presentation/widgets/loadingColumn.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameController = TextEditingController();

  void getUsers() {
    context.read<AuthenticationCubit>().getUsers();
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationErr) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is UserCreated) {
          getUsers();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('School App'),
          ),
          body: state is GettingUsers
              ? LoadingColumn(
                  message: "Users are loading",
                )
              : state is CreatingUser
                  ? LoadingColumn(message: 'Creating User')
                  : state is UsersLoaded
                      ? Center(
                          child: ListView.builder(
                            itemCount: state.users.length,
                            itemBuilder: (context, index) {
                              //extract the use
                              final user = state.users[index];
                              return ListTile(
                                leading: Text(user.name),
                                title: Text(user.createdAt),
                                subtitle: Text(user.avatar),
                              );
                            },
                          ),
                        )
                      : const SizedBox.shrink(),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              await showDialog(
                  context: context,
                  builder: (context) => AddUserDialoge(
                        nametextcontroller: nameController,
                      ));
            },
            label: const Text('Add User'),
            icon: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
