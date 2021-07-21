import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instagram_clone/tab_page.dart';

class LoginPage extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Instagram Clone',
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            SignInButton(
              Buttons.Google,
              onPressed: (){
                _handleSignIn().then((user) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => TabPage(user)),
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  // 비동기 방식으로 구글 로그인
  Future<User> _handleSignIn() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    User user = (await _auth.signInWithCredential(
      GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      )
    )).user;
    print("signed in " + user.displayName);

    return user;
  }
}
