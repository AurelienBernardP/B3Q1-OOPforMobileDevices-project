import 'package:first/Item.dart';
import 'package:first/TreeList.dart';
import 'package:flutter/material.dart';

import 'Health.dart';
import 'Zone.dart';
import 'dart:async';

/*
 * TreeBackEnd class
 * Attributes :
 *    _treeHealth : Health object describing the health of the tree
 *    _image : flutter widget image displayed to the screen
 *    _plantedZone : reference to the zone object where the tree is planted
 *    _name : string, given name of the tree
 *    plantedTree : item of the tree that is planted
 */
class TreeBackEnd {

  Health _treeHealth;
  Widget _image;
  Zone _plantedZone;
  String _name;
  Item plantedTree;
  
  /* Class contructor
   * arguments :(they are all optional)
   *    _treeHealth : Health object describing the health of the tree
   *    _image : image displayed to the screen
   *    _plantedZone : reference to the zone object where the tree is planted
   *    _name : string, given name of the tree
   *    plantedTree : item of the tree that is planted
   * 
   * return: instantiated class
   */
  TreeBackEnd(
      {Zone zone, Item tree, String name, Health health}) {
    _image = Container(
      decoration: BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage(tree.getIcon()),
          fit: BoxFit.fill,
        ),
      ),
    );
    if (health == null)
      _treeHealth = Health();
    else
      _treeHealth = health;
    if (zone != null) {
      _plantedZone = zone;
    }
    if (tree != null) {
      plantedTree = tree;
    }
    if (name != null) {
      this._name = name;
    } else {
      this._name = "Grooot";
    }

    TreeList().addTreeToList(this);
  }

  /*Getter
   * arguments: /
   * 
   * returns: reference to the zone object where the tree is planted
   */
  Zone getZone() => _plantedZone;

  /*Getter
   * arguments: /
   * 
   * returns: reference to flutter widget image displayed to the screen
   */
  Widget getImage() {
    return _image;
  }

  /*Getter
   * arguments: /
   * 
   * returns: reference to Health object describing the health of this tree
   */
  Health getHealth() {
    return _treeHealth;
  }

  /*Getter
   * arguments: /
   * 
   * returns: reference to string given name of the tree
   */
  String getName() => _name;

  /* background image getter
   * arguments: /
   * 
   * returns: Flutter BoxDecoration object dependant of the zonetype in which
   *          the tree is planted
   */
  BoxDecoration getBackground() {
    return BoxDecoration(
      image: new DecorationImage(
          image: new AssetImage(
            "assets/images/unlocked/" +
                _plantedZone.getZoneType() +
                "Unlocked.png",
          ),
          fit: BoxFit.cover),
    );
  }
}
