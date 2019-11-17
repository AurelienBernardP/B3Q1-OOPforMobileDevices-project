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

  Item getPlantedTree(){
    return plantedTree;
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

  void plantTree(Item tree, {String name}){
    plantedTree = tree;
    plantedTreeScreen = TreeScreen(location:this, treeType:tree, name: name);

  }

  void removeTree(){
    plantedTree = null;
  }

  Widget buildZone(BuildContext context){
    return this.type.buildCharacteristic(context);
  }

  Widget getTreeScreenWidget(){
    return plantedTreeScreen;
  }

  TreeBackEnd getTreeScreen(){
    return plantedTreeScreen.getTreeInfo();
  }
  
  String getZoneType(){
    return this.type.getName();
  }
  
}