import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class PollutionItem{

  bool visible = false;
  int type;
  String image;

  bool isVisible(){
    return visible;
  }

  void makeVisible(int data){
    visible = true;
    type = data;
    switch (type) {
      case 0:
        image = "assets/images/banana.png";
        break;
        case 1:
        image = "assets/images/can.png";
        break;
      case 2:
        image = "assets/images/avocado.png";
        break;
      case 3:
        image = "assets/images/bottle.png";
    }
  }

  void makeInvisible(){
    visible = false;
  }

  String getImage(){
    return image;
  }

  int getType(){
    return type;
  }

}