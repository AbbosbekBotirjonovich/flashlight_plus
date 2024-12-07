import 'flashlight_plus_platform_interface.dart';

class FlashlightPlus {
  Future<bool> get isAvailableTorch =>
      FlashlightPlusPlatform.instance.isAvailableTorch();

  Future<bool?> turnOn() => FlashlightPlusPlatform.instance.turnOn();
  Future<bool?> turnOff() => FlashlightPlusPlatform.instance.turnOff();
}
