import 'package:demo_branching/firebase_options.dart';
import 'package:demo_branching/src/repositories/repositories.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final firebaseAuthenticationRepository = FirebaseAuthenticationRepository();
  await firebaseAuthenticationRepository.userChanges.first;
  runApp(App(
    authenticationRepository: firebaseAuthenticationRepository,
  ));
}
