import 'package:cs310_week5_app/routes/welcome.dart';
import 'package:flutter/material.dart';
import 'package:cs310_week5_app/routes/login.dart';
import 'package:cs310_week5_app/routes/home.dart';
import 'package:cs310_week5_app/routes/signup.dart';
import 'package:cs310_week5_app/routes/walkthrough.dart';
import 'package:walkthrough/walkthrough.dart';
import 'package:cs310_week5_app/routes/home.dart';
import 'package:cs310_week5_app/utils/color.dart';
import 'package:cs310_week5_app/utils/dimension.dart';
import 'package:cs310_week5_app/utils/styles.dart';

class ItemCard extends StatelessWidget {
  final Post product;
  final Function press;
  const ItemCard({
    Key key,
    this.product,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20.0),
              // For  demo we use fixed height  and width
              // Now we dont need them
              // height: 180,
              // width: 160,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                    image: NetworkImage(product.mediaUrl),fit: BoxFit.scaleDown),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child:

            Text(
              // products is out demo list
              product.location,
              style: TextStyle(color: Colors.black),
            ),
          ),

          Text(
            product.caption,
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}