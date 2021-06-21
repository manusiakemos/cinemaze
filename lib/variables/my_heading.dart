import 'package:flutter/material.dart';
class MyHeading extends TextStyle {

  const MyHeading({this.headingStyleCustom : HeadingStyle.s, this.headingColor : Colors.black}) : super();
  final HeadingStyle headingStyleCustom;
  final Color headingColor;


  @override
  // TODO: implement color
  Color get color => headingColor;

  @override
  // TODO: implement fontFamily
  String get fontFamily => "SourceSansPro";

  @override
  // TODO: implement fontSize
  double get fontSize => selectStyle();

  double selectStyle(){
    if(headingStyleCustom == HeadingStyle.s){
      return 12;
    }else if (headingStyleCustom == HeadingStyle.m){
      return 16;
    }else{
      return 24;
    }
  }

  @override
  // TODO: implement fontWeight
  FontWeight get fontWeight => selectWeight();
  FontWeight selectWeight(){
    if(headingStyleCustom == HeadingStyle.s){
      return FontWeight.bold;
    }else if (headingStyleCustom == HeadingStyle.m){
      return FontWeight.bold;
    }else{
      return FontWeight.bold;
    }
  }
}

enum HeadingStyle{s, m, l}