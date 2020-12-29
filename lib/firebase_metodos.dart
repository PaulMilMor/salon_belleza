import 'package:firebase_auth/firebase_auth.dart';

//final FirebaseAuth _auth = FirebaseAuth.instance;

class FirebaseProvider {
  final FirebaseAuth auth;

  FirebaseProvider(this.auth);

  Stream<User> get authState => auth.idTokenChanges();

  Future<String> iniciarSesion({String correo, String contra}) async {
    try {
      await auth.signInWithEmailAndPassword(email: correo, password: contra);
      return 'Ingresó';
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return 'No se encontró el usuario.';
          break;
        case 'wrong-password':
          return 'La contraseña es incorrecta.';
          break;
        default:
          return 'Algo salió mal. Error ${e.code}';
          break;
      }
    }
  }

  Future<void> cerrarSesion() async {
    await auth.signOut();
  }
}
