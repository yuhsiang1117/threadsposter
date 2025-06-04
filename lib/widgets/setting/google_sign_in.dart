import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential> signInWithGoogle() async {
  // 開始 Google 登入流程
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  if (googleUser == null) {
    throw Exception("使用者取消登入");
  }

  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Firebase 登入
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
