class Constants{

  static String SPLASH_SCREEN='SPLASH_SCREEN';
static String HOME_SCREEN='HOME_SCREEN';

 static List<CardItem> initializeList(List<CardItem> itemList){

     itemList = [
      CardItem(content: 'bottle', cardColor: BROWN_COLOR),
      CardItem(content: 'apple', cardColor: RED_COLOR),
      CardItem(content: 'stains', cardColor: ORANGE_COLOR),
      CardItem(content: 'dead', cardColor: BLUE_COLOR),
    ];

return itemList;