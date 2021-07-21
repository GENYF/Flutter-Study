import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/create_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/detail_post_page.dart';

class SearchPage extends StatefulWidget {
  final User user;

  SearchPage(this.user);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePage(widget.user))
          );
        },
        child: Icon(Icons.create),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar();
  }

  Widget _buildBody() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('post').snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        var items = snapshot.data?.documents ?? [];

        return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.0,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return _buildListItem(context, items[index]);
            }
        );
      },
    );
  }

  Widget _buildListItem(context, document) {
    // 축소, 확대 애니메이션 Hero
    return Hero(
      tag: document['photoUrl'],
      child: Material(
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DetailPostPage(document);
            }));
          },
          child: Image.network(
            document['photoUrl'],
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
