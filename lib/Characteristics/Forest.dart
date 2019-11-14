import '../Characteristic.dart';
import 'CharacteristicDisplay.dart';

class Forest extends Characteristic{
  static final Forest _singleton = Forest._internal();

  factory Forest(){
    return _singleton;
  }

  Forest._internal(){
    this.soilQuality = 2;
    this.vulnerability = 0;
    this.sunExposure = 1;
    this.display = CharacteristicDisplay(this);
  }



}
