import 'package:first/Item.dart';

import 'package:first/TreeList.dart';

import 'Health.dart';

import 'package:flutter/material.dart';

import 'Zone.dart';
import 'dart:async';


class TreeBackEnd {
  Health treeHealth;
  Widget image;
  Zone plantedZone;
  String name;
  Item plantedTree;

  TreeBackEnd(
      {Zone zone, Item tree, String name, DateTime time, Health health}) {
    image = Container(
      decoration: BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage(tree.getIcon()),
          fit: BoxFit.fill,
        ),
      ),
    );
    if (health == null)
      treeHealth = Health();
    else
      treeHealth = health;
    if (zone != null) {
      plantedZone = zone;
    }
    if (tree != null) {
      plantedTree = tree;
    }
    if (name != null) {
      this.name = name;
    } else {
      this.name = "Grooot";
    }

    TreeList().addTreeToList(this);
  }

  Zone getZone() => plantedZone;


  Widget getImage() {
    return image;
  }

  Health getHealth() {
    return treeHealth;
  }

  String getName() => name;
  BoxDecoration getBackground() {
    return BoxDecoration(
      image: new DecorationImage(
          image: new AssetImage(
            "assets/images/unlocked/" +
                plantedZone.getZoneType() +
                "Unlocked.png",
          ),
          fit: BoxFit.cover),
    );
  }
}
