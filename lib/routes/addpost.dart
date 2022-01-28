import 'package:flutter/material.dart';
import 'package:cs310_week5_app/utils/color.dart';
import 'package:cs310_week5_app/utils/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost>{
  TextEditingController searchController = new TextEditingController();
  String post;
  String username;
  List<String> likes = [];
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  getGridViewItems(BuildContext context, String gridItem){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(gridItem),
          actions: <Widget>[
            FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          'Post',
          style: kAppBarTitleTextStyle,
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: Form(
        key: _formKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Container(
                color: AppColors.captionColor,
                width: MediaQuery.of(context).size.width,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      width: MediaQuery.of(context).size.width - 50,
                      height: 40.0,
                      child: new TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: searchController,
                        style: new TextStyle(
                          fontSize: 18.0,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Post',
                          contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        ),
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Please enter a post';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          post = value;
                        },
                      ),
                    ),
                    new IconButton(
                      icon: new Icon(
                        Icons.add_comment,
                        size: 30.0,
                      ),
                      onPressed: (){
                          var user = FirebaseAuth.instance.currentUser;
                          if(_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                          FirebaseFirestore.instance.collection("users").doc(user.uid).get().then((value){
                            print(value.data());
                            username = value.data()['username'];
                            FirebaseFirestore.instance.collection("posts").add({
                              "post": post,
                              "username": username,
                              "likes" : likes,
                            });
                          });
                            FirebaseFirestore.instance.collection("users").doc(user.uid).update({
                                'chakils' : FieldValue.increment(1),
                            }).then((value){
                              FirebaseFirestore.instance.collection("users").doc(user.uid).collection("posts").add({
                                'post': post,
                              });
                            });
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(
                              'Successfuly posted')));
                          Navigator.pushNamed(context, '/home');
                        }
                      },
                    )
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
