import 'package:flutter/material.dart';

class DetailPostPage extends StatelessWidget {
  final dynamic document;

  DetailPostPage(this.document);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('둘러보기'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(document['userPhotoUrl']),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          document['email'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(document['displayName'])
                      ],
                    ),  
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(document['photoUrl']),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              // 축소, 확대 애니메이션 Hero
              child: Hero(
                tag: document['photoUrl'],
                child: Text(document['contents']),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
