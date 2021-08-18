import 'package:flutter/material.dart';
import 'package:instagram_clone/tab_page.dart';
import 'package:instagram_clone/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 리액티브 프로그래밍, 스트림 데이터 제어
    return StreamBuilder<User>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return TabPage(snapshot.data);
        }
        else{
          return LoginPage();
        }
      }
    );
  }
}
