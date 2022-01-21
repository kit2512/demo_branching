import 'package:demo_branching/src/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User'),
        actions: [
          IconButton(
            onPressed: () =>
                context.read<AuthenticationBloc>().add(LogOutRequested()),
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return Text(
              state.user.id,
            );
          },
        ),
      ),
    );
  }
}
