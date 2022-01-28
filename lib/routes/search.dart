import 'package:cs310_week5_app/routes/welcome.dart';
import 'package:flutter/material.dart';
import 'package:cs310_week5_app/routes/login.dart';
import 'package:cs310_week5_app/routes/home.dart';
import 'package:cs310_week5_app/routes/postcard.dart';
import 'package:cs310_week5_app/routes/walkthrough.dart';
import 'package:walkthrough/walkthrough.dart';
import 'package:cs310_week5_app/routes/home.dart';
import 'package:cs310_week5_app/utils/color.dart';
import 'package:cs310_week5_app/utils/dimension.dart';
import 'package:cs310_week5_app/utils/styles.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search>{

  List<Post> explore = [
    Post(
      postId: 1,
      ownerId: 1,
      username: "Shenanigans",
      location: "Office Code",
      caption: "At my own Disneyland",
      mediaUrl: "https://www.microsoft.com/tr-tr/microsoft-365/blog/wp-content/uploads/sites/60/2019/01/OfficeNews_365Mac-440x268.png",
      createdAt: "Yesterday",
      hashtags: ["#working","#9to5"],
    ),
    Post(
      postId: 2,
      ownerId: 2,
      username: "CaglaYenici",
      location: "Quarantine",
      caption: "Quarantine,Quarantining,Quarantined",
      mediaUrl: "https://www.thesun.co.uk/wp-content/uploads/2020/12/NINTCHDBPICT000627854977.jpg",
      createdAt: "April 23",
      hashtags: ["#covid19","#stayhome"],
    ),
    Post(
      postId: 3,
      ownerId: 3,
      username: "İloilo",
      location: "Bağcılar",
      caption: "Bıktım...",
      mediaUrl: "https://i.pinimg.com/736x/78/9f/aa/789faa8255e34c2bd1f33577ed76c17d.jpg",
      createdAt: "April 25",
      hashtags: ["#bıktım"],
    ),

    Post(
      postId: 4,
      ownerId: 4,
      username: "KrLkAaN",
      location: "Sihirdar Vadisi",
      caption: "Oyunda",
      mediaUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8uQ2BAZjMLMV7KtoaTzBotN9GJ2c6KZNP3A&usqp=CAU",
      createdAt: "April 19",
      hashtags: ["#LOL"],
    ),

  ];
  TextEditingController searchController = new TextEditingController();
  searchFunction(){}
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
          'Search',
          style: kAppBarTitleTextStyle,
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: Column(
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
                        hintText: 'Search',
                        contentPadding:
                        EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      ),
                    ),
                  ),
                  new IconButton(
                    icon: new Icon(
                      Icons.search,
                      size: 30.0,
                    ),
                    onPressed: searchFunction,
                  )
                ],
              ),
            ), //COLBURAYA
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GridView.builder(
                      itemCount: explore.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20.0,
                        crossAxisSpacing: 20.0,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) => ItemCard(
                          product: explore[index]
                      )),
                )),
          ]),
    );

  }

}
