// TODO Implement this library.
import 'dart:ui';

import 'package:cs310_week5_app/routes/nots_model.dart';
import 'package:flutter/material.dart';
//import '../nots_model.dart';
class Nots extends StatelessWidget{
  final List<NotsModel> nots;

  Nots(this.nots);
  Widget build(context){
    return ListView.builder(itemCount: nots.length,
      itemBuilder: (context, int index){
        return buildNot(nots[index]);
      },
    );

  }

  Widget buildNot(NotsModel not){
    return Container(
      margin: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 10.0,
        bottom: 10.0,
      ),
      padding: EdgeInsets.all(20.0),
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
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              not.title,
              style: TextStyle(fontSize: 25.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child:
            Image.network('http://10.0.2.2:8000/' + not.imageUrl),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 40.0),
            child:
            Row(
              children: <Widget>[
                Icon(Icons.account_circle),
                Padding(
                  padding: EdgeInsets.only(left: 4.0),
                  child: Text(
                    not.user,
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}