import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:demo_branching/src/repositories/repositories.dart';
import 'ui/screens/screens.dart';

class App extends StatelessWidget {
  App({
    Key? key,
    required this.authenticationRepository,
  }) : super(key: key);

  final AuthenticationRepository authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => ImageRepository(),
        ),
        RepositoryProvider.value(
          value: authenticationRepository,
        ),
      ],
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
