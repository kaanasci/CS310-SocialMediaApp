import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_week5_app/model/post.dart';
import 'package:cs310_week5_app/dummy/post_list.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference postList = FirebaseFirestore.instance.collection('posts');

  Future<void> createUserData(String name,String email) async {
    return await userCollection.doc(uid).set({
      'username' : name,
      'email' : email,
      'name' : '' ,
      'bio' : 'Hi there! I am using Chakila.' ,
      'following' : 0,
      'followers' : 0,
      'chakils' : 0,
      'image' : 'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'
    });
  }
       /* .then((value) {
      print('');
      userCollection.doc(uid).collection("info").add({
        'following' : '0',
        'followers' : '0',
        'chakils' : '0',
      }
      );
    });
  }
  */
  List<AppPost> _postListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return AppPost(
          username: doc.data()['username'] ?? '',
          post: doc.data()['post'] ?? ''
      );
    }).toList();
  }
  Stream<List<AppPost>> get posts {
    return postList.snapshots().map(_postListFromSnapshot);
  }
}