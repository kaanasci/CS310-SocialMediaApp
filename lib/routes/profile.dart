import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}
class _ProfileState extends State<ProfilePage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  var user = FirebaseAuth.instance.currentUser;

  final textStylesStats = TextStyle(
    fontSize: 11.0,
    color: Colors.white,
  );
  final textStylesTop = TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  final textStyle3 = TextStyle(
    color: Colors.white,
  );
  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.deepPurple,
                        Colors.deepPurpleAccent.withOpacity(0.9),
                        Colors.deepPurple.withOpacity(0.2),
                      ],
                      stops: [0.5, 0.7, 1],
                      begin: Alignment.topRight,
                    )
                )
            ),
            Column(
              children: <Widget>[
                SizedBox(height: 32.0,),
                _topRow(),
                _profileRow(),
                _bioRow(),
                _statesRow(),
                _bottomCard(),
              ],
            )
          ],
        )
    );
  }
  _profileRow(){
    return StreamBuilder(
      stream : FirebaseFirestore.instance.collection('users').doc(user.uid).snapshots(),
      builder: (context,snapshot) {
        return Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(snapshot.data['image']),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    )
                ),
                SizedBox(width: 15.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      snapshot.data['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      snapshot.data['name'],
                      style: textStyle3,
                    ),
                  ],
                )
              ],
            )
        );
      }
    );
  }
  _topRow(){
    return IconTheme(
        data: IconThemeData(color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget> [
            IconButton(icon: Icon(Icons.arrow_back), onPressed:(){ Navigator.pushNamed(context, '/home');}),
            Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.cast), onPressed:(){}),
                IconButton(icon: Icon(Icons.more_horiz), onPressed: (){}),
              ],
            )
          ],
        )
    );
  }
  _bioRow(){
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').doc(user.uid).snapshots(),
      builder: (context,snapshot) {
        return Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
          child: Text(
            snapshot.data['bio'],
            style: textStyle3,
          )
        );
      },
    );
  }
  _statesRow(){
    return StreamBuilder(
     // stream: FirebaseFirestore.instance.collection('users').doc('2OBbqfeE6pXvCaDqZhFOE33Hyfb2').collection('info').snapshots(),
      stream: FirebaseFirestore.instance.collection('users').doc(user.uid).snapshots(),
      builder: (context,snapshot) {
        return Padding(
          padding:EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    snapshot.data['following'].toString(),
                    style: textStylesTop,
                  ),
                  Text(
                    "following",
                    style: textStylesStats,
                  ),
                ],
              ),

              Column(
                children: <Widget>[
                  Text(
                    snapshot.data['followers'].toString(),
                    style: textStylesTop,
                  ),
                  Text(
                    "followers",
                    style: textStylesStats,
                  ),
                ],
              ),

              Column(
                children: <Widget>[
                  Text(
                    snapshot.data['chakils'].toString(),
                    style: textStylesTop,
                  ),
                  Text(
                    "chakils",
                    style: textStylesStats,
                  ),
                ],
              ),

            ],
          ),
        );
      },
    );
  }
  _bottomCard(){
    return Expanded(
      child: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(50, 70),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                    )
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                              "My Chakils",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0,
                              )
                          )
                      ),
                      SizedBox(height: 20.0),
                      Container(
                          width: 100.0,
                          height: 300.0,
                          child: StreamBuilder(
                            stream : FirebaseFirestore.instance.collection('users').doc(user.uid).collection("posts").snapshots(),
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
                                          minLeadingWidth : 10,
                                          dense: false,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          )
                      ),
                    ],
                  ),
                ),
            ),
          ),
          Align(
            alignment: Alignment(0.8,-0.8),
            child: Container(
              width: 50.0,
              height: 50.0,
              child: IconButton(
                  icon: Icon(
                      Icons.edit),
                  color:Colors.white,
                  onPressed:() {Navigator.pushNamed(context, '/editprofile');}
              ),

              decoration: BoxDecoration(
                color: Colors.purple,
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.4),
                    spreadRadius: 1.0,
                    blurRadius: 3.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
