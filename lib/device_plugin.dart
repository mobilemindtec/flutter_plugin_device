import 'dart:async';

import 'package:flutter/services.dart';

class DevicePlugin {

  static const String _CHANNEL_NAME = "plugins.flutter.io/device_plugin";
  static const String _METHOD_OS = "os";
  static const String _METHOD_MANUFACTURER = "manufacturer";
  static const String _METHOD_OS_VERSION = "osVersion";
  static const String _METHOD_MODEL = "model";
  static const String _METHOD_SDK_VERSION = "sdkVersion";
  static const String _METHOD_DEVICE_TYPE = "deviceType";
  static const String _METHOD_UUID = "uuid";
  static const String _METHOD_LANGUAGE = "language";
  static const String _METHOD_REGION = "region";
  static const String _METHOD_SCREEN_WIDTH_PIXELS = "screenWidthPixels";
  static const String _METHOD_SCREEN_HEIGHT_PIXELS = "screenHeightPixels";
  static const String _METHOD_SCREEN_SCALE = "screenScale";
  static const String _METHOD_SCREEN_WIDTH_DPIS = "screenWidthDIPs";
  static const String _METHOD_SCREEN_HEIGHT_DPIS = "screenHeightDIPs";

  static const MethodChannel _channel =
      const MethodChannel(_CHANNEL_NAME);

  static Future<String> get os async {
    return await _channel.invokeMethod(_METHOD_OS);
  }

  static Future<String> get manufacturer async {
    return await _channel.invokeMethod(_METHOD_MANUFACTURER);
  }

  static Future<String> get osVersion async {
    return await _channel.invokeMethod(_METHOD_OS_VERSION);
  }

  static Future<String> get model async {
    return await _channel.invokeMethod(_METHOD_MODEL);
  }

  static Future<String> get sdkVersion async {
    return await _channel.invokeMethod(_METHOD_SDK_VERSION);
  }

  static Future<String> get deviceType async {
    return await _channel.invokeMethod(_METHOD_DEVICE_TYPE);
  }

  static Future<String> get uuid async {
    return await _channel.invokeMethod(_METHOD_UUID);
  }

  static Future<String> get language async {
    return await _channel.invokeMethod(_METHOD_LANGUAGE);
  }

  static Future<String> get region async {
    return await _channel.invokeMethod(_METHOD_REGION);
  }

  static Future<int> get screenWidthPixels async {
    var value = await _channel.invokeMethod(_METHOD_SCREEN_WIDTH_PIXELS);
    return value;
  }

  static Future<int> get screenHeightPixels async {
    var value = await _channel.invokeMethod(_METHOD_SCREEN_HEIGHT_PIXELS);
    return value;
  }

  static Future<double> get scale async {
    var value = await _channel.invokeMethod(_METHOD_SCREEN_SCALE);
    return value;
  }

  static Future<double> get screenWidthDIPs async {
    var value = await _channel.invokeMethod(_METHOD_SCREEN_WIDTH_DPIS);
    return value;
  }

  static Future<double> get screenHeightDIPs async {
    var value = await _channel.invokeMethod(_METHOD_SCREEN_HEIGHT_DPIS);
    return value;
  }
}
