import 'package:flutter/material.dart';

class LoadingColumn extends StatelessWidget {
  LoadingColumn({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircularProgressIndicator(),
        SizedBox(
          height: 10,
        ),
        Text("$message ....")
      ],
    );
  }
}
