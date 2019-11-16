import '../Characteristic.dart';
import 'CharacteristicDisplay.dart';

class River extends Characteristic{
  static final River _singleton = River._internal();

  factory River(){
    return _singleton;
  }

  River._internal(){
    this.soilQuality = 1;
    this.vulnerability = 0;
    this.sunExposure = 0;
    this.display = CharacteristicDisplay(this);
  }
  @override
  String getName(){
    return "River";
  }
}

