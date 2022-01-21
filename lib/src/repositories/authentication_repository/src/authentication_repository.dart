import 'models/models.dart';

abstract class AuthenticationRepository {
  Stream<User> get userChanges;

  User get currentUser;

  Future<void> signInWithEmailAndPassword(String email, String password);

  Future<void> signUpWithEmailAndPassword(String email, String password);

  Future<void> signInWithGoogle();

  Future<void> signInWithFacebook();

  Future<void> signOut();
}
