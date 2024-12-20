import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flashlight_plus_platform_interface.dart';

class MethodChannelFlashlightPlus extends FlashlightPlusPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('flashlight_plus');

  @override
  Future<bool> isAvailableTorch() async {
    final isAvailable =
        await methodChannel.invokeMethod<bool>('uz.fldev.flashlight_plus.isAvailableTorch');
    return isAvailable ?? false;
  }

  @override
  Future<bool?> turnOn() async {
    final value = await methodChannel.invokeMethod<bool?>("uz.fldev.flashlight_plus.turnOnFlashLight");
    return value;
  }

  @override
  Future<bool?> turnOff() async {
    final value = await methodChannel.invokeMethod<bool>("uz.fldev.flashlight_plus.turnOffFlashLight");
    return value;
  }
}
