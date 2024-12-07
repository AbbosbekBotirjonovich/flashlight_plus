import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flashlight_plus_method_channel.dart';

abstract class FlashlightPlusPlatform extends PlatformInterface {
  FlashlightPlusPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlashlightPlusPlatform _instance = MethodChannelFlashlightPlus();

  static FlashlightPlusPlatform get instance => _instance;

  static set instance(FlashlightPlusPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> isAvailableTorch() {
    throw UnimplementedError('isAvailable() has not been implemented.');
  }

  Future<bool?> turnOn() {
    throw UnimplementedError('toggleOnFlashlight() has not been implemented.');
  }

  Future<bool?> turnOff() {
    throw UnimplementedError('toggleOffFlashlight() has not been implemented.');
  }
}
