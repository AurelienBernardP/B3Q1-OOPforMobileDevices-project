import '../Characteristic.dart';
import 'CharacteristicDisplay.dart';

class Path extends Characteristic{
  static final Path _singleton = Path._internal();

  factory Path(){
    return _singleton;
  }

  Path._internal(){
    this.soilQuality = 0;
    this.vulnerability = 2;
    this.sunExposure = 2;
    this.display = CharacteristicDisplay(this);
  }
  @override
  String getName(){
    return "Path";
  }
}

