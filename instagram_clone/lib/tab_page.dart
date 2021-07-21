import 'package:flutter/material.dart';
import 'package:instagram_clone/account_page.dart';
import 'package:instagram_clone/home_page.dart';
import 'package:instagram_clone/search_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TabPage extends StatefulWidget {
  // 구글 로그인 유저 정보를 담는 변수
  final User user;

  TabPage(this.user);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _selectedndex = 0;

  List _pages;

  @override
  void initState() {
    super.initState();

    _pages = [
      HomePage(widget.user),
      SearchPage(widget.user),
      AccountPage(widget.user),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _pages[_selectedndex]),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.black,
        onTap: onItemTapped,
          currentIndex: _selectedndex,
          items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home')
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search')
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Account')
        ),
      ]),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      _selectedndex = index;
    });
  }
}
