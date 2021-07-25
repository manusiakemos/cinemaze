import 'package:cinemaze/variables/variables.dart';
import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  final double rating;
  final bool isBold;

  const Rating({this.rating, this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star,
            color: Colors.amber),
        Padding(
          padding: EdgeInsets.only(
              left: paddingSmall,
              right: paddingLarge),
          child: BoldTextOrNot(rating: rating.toString(), isBold: isBold,)
        ),
      ],
    );
  }
}

class BoldTextOrNot extends StatelessWidget {
  final bool isBold;
  final String rating;

  const BoldTextOrNot({this.isBold, this.rating});

  @override
  Widget build(BuildContext context) {
    if(isBold){
      return Text(rating,
          style: headingPrimaryWhite
      );
    }else{
      return Text(rating,
          style: textMuted
      );
    }
  }
}

