import '../Characteristic.dart';
import 'CharacteristicDisplay.dart';

class Plains extends Characteristic{
  static final Plains _singleton = Plains._internal();

  factory Plains(){
    return _singleton;
  }

  Plains._internal(){
    this.soilQuality = 1;
    this.vulnerability = 2;
    this.sunExposure = 2;
    this.display = CharacteristicDisplay(this);
  }



}
