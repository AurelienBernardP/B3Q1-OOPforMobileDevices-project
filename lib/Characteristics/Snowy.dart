import '../Characteristic.dart';
import 'CharacteristicDisplay.dart';

class Snowy extends Characteristic{
  static final Snowy _singleton = Snowy._internal();

  factory Snowy(){
    return _singleton;
  }

  Snowy._internal(){
    this.soilQuality = 1;
    this.vulnerability = 2;
    this.sunExposure = 0;
    this.display = CharacteristicDisplay(this);
  }

  String getName(){
    return "Snowy";
  }


}
