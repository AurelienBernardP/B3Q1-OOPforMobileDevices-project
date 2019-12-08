/*
 * PollutionItem class
 * Attributes:
 *    visible: a boolean that is used to determine whether a pollution should be visible or not
 *    type: an integer that will change depending on the garbage
 *    image: the image associated with the garbage type
 */

class PollutionItem{

  bool visible = false;
  int type;
  String image;

  /*
   * input: /
   * output: visible, the visibility of the PollutionItem
   */
  bool isVisible(){
    return visible;
  }

  /*
   * input: data, an integer
   * effect: makes the PollutionItem visible, sets its type to data and adds the corresponding image
   */
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

  /*
   * input: /
   * effect: makes the PollutionItem invisible
   */
  void makeInvisible(){
    visible = false;
  }

  /*
   * input: /
   * output: image, the path to the image associated with the PollutionItem
   */
  String getImage(){
    return image;
  }

  /*
   * input: /
   * output: type, the type of the PollutionItem
   */
  int getType(){
    return type;
  }

}