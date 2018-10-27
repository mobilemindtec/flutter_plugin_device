#import "DevicePlugin.h"
#import <device/device-Swift.h>

@implementation DevicePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftDevicePlugin registerWithRegistrar:registrar];
}
@end
