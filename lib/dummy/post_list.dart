import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cs310_week5_app/model/post.dart';

class PostList extends StatefulWidget {
  const PostList ({Key key}) : super (key:key);
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {

    final posts = Provider.of<List<AppPost>>(context);
    print(posts.toString());
    return Container(
      child: Text(posts.toString()),
    );
  }
}