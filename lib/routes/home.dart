import 'package:cs310_week5_app/dummy/database.dart';
import 'package:flutter/material.dart';
import 'package:cs310_week5_app/utils/color.dart';
import 'package:cs310_week5_app/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:cs310_week5_app/model/post.dart';
import 'package:cs310_week5_app/dummy/auth.dart';
import 'package:cs310_week5_app/routes/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_week5_app/model/post.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Post {
  final String username, location, caption, mediaUrl, createdAt,userImage;
  final int ownerId, postId;
  final dynamic likes;
  final List <String> hashtags;

  Post(  {
    this.username,
    this.location,
    this.mediaUrl,
    this.postId,
    this.caption,
    this.likes,
    this.createdAt,
    this.userImage,
    this.ownerId,
    this.hashtags,
  });

}
final List<Post> feeds = [
  Post(username: '@ilaydakuran', location: 'istanbul', caption: 'merhaba ben ilo', mediaUrl: 'dsdf', createdAt: 'sdf', userImage: 'https://instagram.fist6-1.fna.fbcdn.net/v/t51.2885-19/s320x320/165629415_354719755858642_6031966886925404238_n.jpg?tp=1&_nc_ht=instagram.fist6-1.fna.fbcdn.net&_nc_ohc=uZw5e-eLj9IAX8dR31L&edm=ABfd0MgAAAAA&ccb=7-4&oh=4f4d4df791d3709e677ca64201fcf550&oe=60A92C07&_nc_sid=7bff83', ownerId: 1, postId: 3),
  Post(username: '@caglayenici', location: 'istanbul', caption: 'selamlar', mediaUrl: 'dsdf', createdAt: 'sdf', userImage: 'https://cdn.discordapp.com/attachments/782688404353056768/835831370198155284/Screen_Shot_2021-04-25_at_13.55.17.png', ownerId: 2, postId: 2),
  Post(username: '@bekaan', location: 'istanbul', caption: 'hayatı seviyorum', mediaUrl: 'dsdf', createdAt: 'sdf', userImage: 'https://cdn.discordapp.com/attachments/782688404353056768/835831747413147688/Screen_Shot_2021-04-25_at_13.56.52.png', ownerId: 1, postId: 3),
  Post(username: '@alarademir', location: 'istanbul', caption: 'amman allahh', mediaUrl: 'dsdf', createdAt: 'sdf', userImage: 'https://cdn.discordapp.com/attachments/782688404353056768/835832029332373554/Screen_Shot_2021-04-25_at_13.58.00.png', ownerId: 1, postId: 3),
  Post(username: '@ahmetolcum', location: 'istanbul', caption: 'sa', mediaUrl: 'dsdf', createdAt: 'sdf', userImage: 'https://cdn.discordapp.com/attachments/782688404353056768/835832255133122620/Screen_Shot_2021-04-25_at_13.58.53.png', ownerId: 1, postId: 3),
  Post(username: '@elifsahin', location: 'istanbul', caption: 'merhabalarr', mediaUrl: 'dsdf', createdAt: 'sdf', userImage: 'https://imgcy.trivago.com/c_limit,d_dummy.jpeg,f_auto,h_1300,q_auto,w_2000/itemimages/86/71/867186_v2.jpeg', ownerId: 1, postId: 3),
];

DocumentSnapshot snapshot;

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.analytics, this.observer}) : super(key: key);
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _message = '';
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String post;
  String username;
  List<String> likes = [];
  void setMessage(String msg) {
    setState(() {
      _message = msg;
    });
  }

  Future<void> _setLogEvent() async {
    await widget.analytics.logEvent(
        name: 'CS310_Test',
        parameters: <String, dynamic> {
          'string': 'string',
          'int': 310,
          'long': 1234567890123,
          'double': 310.202002,
          'bool': true,
        }
    );
    setMessage('Custom event log succeeded');
  }
  @override
  Widget build(BuildContext context) {
    print('home...');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HOME',
          style: kAppBarTitleTextStyle,
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        elevation: 1.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.notifications_active_outlined,
                color: Colors.white,
                size: 30.0,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/bildirim');

              },
            ),
            TextButton.icon(
              onPressed: () async {
                await _auth.signOut();
                Navigator.pushNamed(context, '/');
              },
              icon: Icon(Icons.person),
              label: Text('Logout'),
            ),
          ]
      ),

      body: StreamBuilder(
        stream : FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,snapshot) {
          if(!snapshot.hasData)
            return Text('Loading data.. Please Wait');
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemExtent: 140,
            itemBuilder: (context, index) {
              return Container(
                child: Card(
                  child: InkWell(
                    splashColor: Colors.grey,
                    onTap: (){},
                    child: ListTile(
                      title: Text(snapshot.data.docs[index]['post']),
                      subtitle: Text(snapshot.data.docs[index]['username']),
                      leading : IconButton(
                        icon: new Icon(
                          Icons.favorite_border,
                          size: 30.0,
                        ),
                        onPressed: (){
                          var user = FirebaseAuth.instance.currentUser;
                            if(!snapshot.data.docs[index]['likes'].contains(user.uid)){
                              FirebaseFirestore.instance.collection("posts").doc(snapshot.data.docs[index].id).update({
                                'likes': snapshot.data.docs[index]['likes'].add(user.uid),
                              });
                            }
                            else{
                              FirebaseFirestore.instance.collection("posts").doc(snapshot.data.docs[index].id).update({
                                'likes': snapshot.data.docs[index]['likes'].remove(user.uid),
                              });
                            }
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(
                                'Successfuly posted')));
                            Navigator.pushNamed(context, '/home');
                          }
                      ),
                      minLeadingWidth : 10,
                      dense: false,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child:  Container(
          color: Colors.grey[200],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              IconButton(icon: Icon(Icons.search), iconSize: 30.0, color: Colors.black87, onPressed: (){Navigator.pushNamed(context, '/search');}),
              IconButton(icon: Icon(Icons.add_circle_outline_sharp), iconSize: 30.0, color: Colors.black87, onPressed: (){Navigator.pushNamed(context, '/addpost');
              } ),
              IconButton(icon: Icon(Icons.person), iconSize: 30.0, color: Colors.black87, onPressed: (){Navigator.pushNamed(context, '/profile');} ),

            ],
          ),
        ),
      ),

);

}}
