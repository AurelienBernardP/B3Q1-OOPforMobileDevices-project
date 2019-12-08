import 'package:first/AdTreesAppTopBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Guide extends StatefulWidget {
  @override
  _GuideState createState() => _GuideState();
}

class _GuideState extends State<Guide> {

  int pageNumber = 0; // number of the page the user is on in the guide
  final int NBPAGES = 7; // number of pages there are in the guide

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "Guide",
      home: Stack(
        children: <Widget>[
          new Container(
            height: MediaQuery.of(context).size.height / 8.5,
            width: double.infinity,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/table.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AdTreesAppTopBar('How to play', context, isGuide: true)
                .getBar(),
            body: _buildGuide(),
          ),
        ],
      ),
    );
  }

  /*
   * input: /
   * effect: increases the number of the current page in the guide,
   *         if number of max pages is reached it rolls back to 0 and refreshes the screen
   */
  void _nextPage() {

    setState(() {
      pageNumber = (pageNumber + 1) % NBPAGES;
    });
  }

  /*
   * input: /
   * effect: decreases the number of the current page in the guide,
   *         if done on 0 it set to te last page of the guide and refreshed the screen
   */
  void _previousPage() {

    setState(
      () {
        if (pageNumber == 0) {
          pageNumber = NBPAGES - 1;
        } else {
          pageNumber = (pageNumber - 1);
        }
      },
    );
  }

  /*
   * input: /
   * Returns: built widget corresponding to the body of the screen
   */
  Widget _buildGuide() {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.black,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/table.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: _addTitle(),
              flex: 2,
            ),
            Expanded(
              child: _addText(),
              flex: 8,
            ),
            Expanded(
              child: Container(
                margin:
                    EdgeInsets.only(bottom: height / 80, right: width / 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          bottom: height / 80, left: width / 100),
                      alignment: Alignment.bottomLeft,
                      child: _addLeftButton(height),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          bottom: height / 80, right: width / 100),
                      alignment: Alignment.bottomRight,
                      child: _addRightButton(height),
                    ),
                  ],
                ),
              ),
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }

  /*
   * input: /
   * Return: Built widget corresponding to the title of the guide's page
   */
  Widget _addTitle() {

    double height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("assets/images/title.png"),
          fit: BoxFit.fill,
        ),
      ),
      margin: EdgeInsets.all(height / 25),
      child: Container(
        margin: EdgeInsets.all(5),
        child: Text(
          _getTitle(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: height / 22,
          ),
        ),
      ),
    );
  }

  /*
   * input: /
   * Return: the built widget corresponding to content of the guide's page
   */
  Widget _addText() {
    return Container(margin: new EdgeInsets.all(20.0), child: _getText());
  }

  /*
   * input: Text as a String
   * Return: Text widget with the design  set for this screen
   */
  Text formatText(String text) {

    double height = MediaQuery.of(context).size.height;

    return Text(
      text,
      style: TextStyle(
        color: Colors.grey[100],
        fontSize: height / 35,
      ),
    );
  }

  /*
   * input: /
   * Return: Content of the Guide corresponding to the guiven page
   */
  _getText() {
    
    switch (pageNumber) {

      case 0:
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Column(
                  children: <Widget>[
                    formatText(
                        "The world map is divided into zones.\n A zone has different characteristics depending on its type.\n This zones can be unlocked with coins and trees can be plated in them.\n To perform any action on a zone just tap on it and options will apear"),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset("assets/images/treemap.jpeg"),
                    ),
                  ],
                ),
              ),
            );
          },
        );

      case 1:
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Column(
                  children: <Widget>[
                    formatText(
                        "A tree can be accesed from the world map or from the tree list.\n Here you can see the health of your plant, you can also water it nurish it or play a game to clean it.\n Each option is displayed with a tapable button.\n"),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset("assets/images/treeScreen.png"),
                    ),
                  ],
                ),
              ),
            );
          },
        );

      case 2:
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Column(
                  children: <Widget>[
                    formatText(
                        "The shop can be accesed from the main menu the world map or from the any tree.\n In the shop you will be able to exchange Coins for usable items like trees!.\n Coins can be earned in many ways:\n ·Shaking a tree you planted \n ·Playing a game to clean a planted tree \n Watching a short ad by taping on the play button"),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset("assets/images/shopScreen.png"),
                    ),
                  ],
                ),
              ),
            );
          },
        );

      case 3:
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Column(
                  children: <Widget>[
                    formatText(
                        "In the invetory you will be able to see the quantity you have of each item"),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset("assets/images/InventoryScreen.png"),
                    ),
                  ],
                ),
              ),
            );
          },
        );

      case 4:
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Column(
                  children: <Widget>[
                    formatText(
                        "From the cleanser item in the tree screen (shield icon) you can acess the game.\n A poluted zone will apear, and it is your task to clean and sort the trash in the area!\n Trash needs to be sorted between compost, on the left, and recycling ,on the right.\n The trash can be dragged into the corresponding bin.\n You will be rewarded for each trash you throw correctly, but only if you clean them all!"),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset("assets/images/gameScreen.png"),
                    ),
                  ],
                ),
              ),
            );
          },
        );

      case 5:
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Column(
                  children: <Widget>[
                    formatText(
                        "From the tree list you can sort and see the time left to shake the trees or their health more rapidely.\n You can select the element you sort the trees by from the list at the of the screen.\n To access a tree simply tap on its box!"),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset("assets/images/treeListScreen.png"),
                    ),
                  ],
                ),
              ),
            );
          },
        );

      case 6:
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Column(
                  children: <Widget>[
                    formatText(
                        "This aplication was developed by Tasnim Safadi, Aurélien Bernard, and Kenan Ozdemir.\n\n The aim of this app is to sensitize the public about the environment in a playfull manner.\n Most of the generated revenue by this app will be transmited to organization dedicated to improve the environment.\n\n Thankyou for your contribution and support."),
                  ],
                ),
              ),
            );
          },
        );
    }
  }

  /*
   * input: height : height and width of the desired square button
   *        
   * Return: button with a right arrow gesture detector to go to the next page
   */
  Widget _addRightButton(double height) {
    return GestureDetector(
      onTap: () {
        _nextPage();
      },
      child: Container(
        margin: new EdgeInsets.all(20.0),
        width: height / 10,
        height: height / 10,
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/right.png"),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  /*
   * input: height : height and width of the desired square button
   *        
   * Return: button with a left arrow gesture detector to go to the previous page
   */
  Widget _addLeftButton(double height) {
    return GestureDetector(
      onTap: () {
        _previousPage();
      },
      child: Container(
        margin: new EdgeInsets.all(20.0),
        width: height / 10,
        height: height / 10,
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/left.png"),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  /*
   * input: /
   *        
   * Return: String holdng the title of the page
   */
  String _getTitle() {

    switch (pageNumber) {

      case 0:
        return "Map";

      case 1:
        return "Tree screen";

      case 2:
        return "Shop & coins";

      case 3:
        return "Inventory";

      case 4:
        return "Polution game";

      case 5:
        return "Tree List";

      case 6:
        return "About";

    }
  }

}
