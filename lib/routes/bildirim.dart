import 'package:cs310_week5_app/utils/dimension.dart';
import 'package:flutter/material.dart';
import 'package:cs310_week5_app/utils/color.dart';
import 'package:cs310_week5_app/utils/styles.dart';
import 'package:http/http.dart' show get;
import'dart:convert';
import 'package:cs310_week5_app/routes/nots_model.dart';
import 'package:cs310_week5_app/routes/nots.dart';

class bildirim extends StatefulWidget {
  @override
  _bildirimState createState() => _bildirimState();
}
final List<NotsModel> nots = [
  NotsModel(title:'Has liked your photo',user:'John', imageUrl: 'https://www.microsoft.com/tr-tr/microsoft-365/blog/wp-content/uploads/sites/60/2019/01/OfficeNews_365Mac-440x268.png'),
  NotsModel(title:'Has liked your photo',user:'Marry', imageUrl: 'https://i.pinimg.com/736x/78/9f/aa/789faa8255e34c2bd1f33577ed76c17d.jpg'),
NotsModel(title:'Liked your photo',user:'Ahmet', imageUrl: 'https://instagram.fist6-1.fna.fbcdn.net/v/t51.2885-19/s320x320/165629415_354719755858642_6031966886925404238_n.jpg?tp=1&_nc_ht=instagram.fist6-1.fna.fbcdn.net&_nc_ohc=uZw5e-eLj9IAX8dR31L&edm=ABfd0MgAAAAA&ccb=7-4&oh=4f4d4df791d3709e677ca64201fcf550&oe=60A92C07&_nc_sid=7bff83'),
NotsModel(title:'Has left a comment',user:'İlayda', imageUrl: 'https://instagram.fist6-1.fna.fbcdn.net/v/t51.2885-19/s320x320/165629415_354719755858642_6031966886925404238_n.jpg?tp=1&_nc_ht=instagram.fist6-1.fna.fbcdn.net&_nc_ohc=uZw5e-eLj9IAX8dR31L&edm=ABfd0MgAAAAA&ccb=7-4&oh=4f4d4df791d3709e677ca64201fcf550&oe=60A92C07&_nc_sid=7bff83'),
NotsModel(title:'Liked your photo',user:'Çağla', imageUrl: 'https://instagram.fist6-1.fna.fbcdn.net/v/t51.2885-19/s320x320/165629415_354719755858642_6031966886925404238_n.jpg?tp=1&_nc_ht=instagram.fist6-1.fna.fbcdn.net&_nc_ohc=uZw5e-eLj9IAX8dR31L&edm=ABfd0MgAAAAA&ccb=7-4&oh=4f4d4df791d3709e677ca64201fcf550&oe=60A92C07&_nc_sid=7bff83'),
];

class _bildirimState extends State<bildirim> {

  @override
  Widget build(context){
    return MaterialApp(
        home:Scaffold(
        appBar: AppBar(
        title: Text('Notifications'),
          backgroundColor: AppColors.primary,
    ),
          body: ListView.builder(

            itemCount: nots.length,
            itemExtent: 140,
            itemBuilder: (context, index) {
              return Container(

                child: Card(
                  child: InkWell(
                    splashColor: Colors.grey,
                    onTap: (){},
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.deepPurple[300],
                          width: 2.5,
                        ),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: <Widget>[
                      Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Text(
                          nots[index].title,
                        style: TextStyle(fontSize: 25.0),
                      ),
                    ),
                    Expanded(
                      child: Container(
                    // padding: EdgeInsets.all(100.0),
                        // For  demo we use fixed height  and width
                        // Now we dont need them
                        // height: 180,
                        // width: 160,

                        decoration: BoxDecoration(

                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              alignment: Alignment.centerRight,
                              scale: 1.0,
                              image: NetworkImage(nots[index].imageUrl),fit: BoxFit.scaleDown),
                        ),
                      ),
                    ),

                      Padding(
                        padding: EdgeInsets.only(bottom: 5.0),
                        child:
                        Row(
                          children: <Widget>[
                            Icon(Icons.account_circle,
                              size: 25.0,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 4.0),
                              child: Text(
                                  nots[index].user,
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),

                          ],
                        ),
                      ),

                      ],

                    ),
                  ),
                ),
              ),);
            },
          ),

        bottomNavigationBar: BottomAppBar(

        shape: const CircularNotchedRectangle(),
        child: Container(
        height: 50.0,
        ),
        ),
        floatingActionButton: FloatingActionButton( //for http request, retrieve notifications from backend
        tooltip: 'Refresh',
            child: Icon(Icons.refresh,

        ),
            backgroundColor:AppColors.primary,
        onPressed: (){}
        ),

    ),
    );
  }
}