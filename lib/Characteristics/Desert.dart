import '../Characteristic.dart';
import 'CharacteristicDisplay.dart';

class Desert extends Characteristic{
  static final Desert _singleton = Desert._internal();

  factory Desert(){
    return _singleton;
  }

  Desert._internal(){
    this.soilQuality = 0;
    this.vulnerability = 0;
    this.sunExposure = 2;
    this.display = CharacteristicDisplay(this);
  }
  @override
  String getName(){
    return "Desert";
  }
}

