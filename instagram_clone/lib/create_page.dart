import 'dart:io';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreatePage extends StatefulWidget {
  final User user;

  CreatePage(this.user);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final textEditingController = TextEditingController();

  File _image;

  // textEditingController는 화면이 없어질때 메모리 해제를 해줘야하는 객
  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed:() => _getImage(),
        child: Icon(Icons.add_a_photo),
      ),
    );
  }


  Widget _buildAppBar() {
    return AppBar(
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.send),
          onPressed: (){
            final firebaseStorageRef = FirebaseStorage.instance
                .ref()
                .child('post')
                .child('${DateTime.now().millisecondsSinceEpoch}.png');

            final task = firebaseStorageRef.putFile(
                _image, SettableMetadata(contentType: 'image/png')
            );

            task.then((TaskSnapshot snapshot){
              var downloadUrl = snapshot.ref.getDownloadURL();

              downloadUrl.then((url ){
                var doc = FirebaseFirestore.instance.collection('post').doc();
                doc.set({
                  'id': doc.id,
                  'photoUrl': url.toString(),
                  'contents': textEditingController.text,
                  'email':widget.user.email,
                  'displayName':widget.user.displayName,
                  'userPhotoUrl':widget.user.photoURL
                });
              });
            }).then((value) => Navigator.pop(context));

          },
        )
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _image == null ? Text('No Image') : Image.file(_image),
          TextField(
            decoration: InputDecoration(hintText: '내용을 입력하세요.'),
            controller: textEditingController,
          )
        ],
      ),
    );
  }

  // 이미지를 가져오는 형식은 Future<File>, 그렇기 때문에 _image = image 불가능, 비동기로 await를 이용하여 캐스팅
  Future _getImage() async{
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }
}


