import 'Characteristic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'TreeScreen.dart';
import 'Item.dart';

class Zone{

  Characteristic type;
  TreeScreen plantedTreeScreen;
  Item plantedTree;
  bool locked = true;

  Zone(Characteristic type){
    this.type = type;
  }

  bool isLocked(){
    return locked;
  }

  void unlock(){
    locked = false;
  }

  bool isPlanted(){
    if (plantedTree != null)
      return true;
    return false;
  }

  void viewTree(){
    if(!locked)
      plantedTreeScreen = TreeScreen();
  }

  void plantTree(Item tree){
    plantedTree = tree;
    TreeScreen(location:this, treeType:tree);
  }

  void removeTree(){
    plantedTree = null;
  }

  Widget buildZone(BuildContext context){
    return this.type.buildCharacteristic(context);
  }

  Widget getTreeScreen(){
    return plantedTreeScreen;
  }
  
  String getZoneType(){
    return this.type.getName();
  }
  
}