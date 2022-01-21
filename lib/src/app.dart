import 'package:demo_branching/src/repositories/image_repository/image_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ui/screens/screens.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => ImageRepository(),
        ),
      ],
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
