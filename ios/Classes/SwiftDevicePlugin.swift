import Flutter
import UIKit
import SAMKeychain

public class SwiftDevicePlugin: NSObject, FlutterPlugin {

    private static let CHANNEL_NAME = "plugins.flutter.io/device_plugin"
    private static let METHOD_OS = "os";
    private static let METHOD_MANUFACTURER = "manufacturer"
    private static let METHOD_OS_VERSION = "osVersion"
    private static let METHOD_MODEL = "model"
    private static let METHOD_SDK_VERSION = "sdkVersion"
    private static let METHOD_DEVICE_TYPE = "deviceType"
    private static let METHOD_UUID = "uuid"
    private static let METHOD_LANGUAGE = "language"
    private static let METHOD_REGION = "region"
    private static let METHOD_SCREEN_WIDTH_PIXELS = "screenWidthPixels"
    private static let METHOD_SCREEN_HEIGHT_PIXELS = "screenHeightPixels"
    private static let METHOD_SCREEN_SCALE = "screenScale"
    private static let METHOD_SCREEN_WIDTH_DPIS = "screenWidthDIPs"
    private static let METHOD_SCREEN_HEIGHT_DPIS = "screenHeightDIPs"
    private static let MIN_TABLET_PIXELS = 600


    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: CHANNEL_NAME, binaryMessenger: registrar.messenger())
        let instance = SwiftDevicePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        
        //registrar.addApplicationDelegate(instance)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {

            case SwiftDevicePlugin.METHOD_OS:
                result("iOS")
                break
            case SwiftDevicePlugin.METHOD_MANUFACTURER:
                result("Apple")
                break
            case SwiftDevicePlugin.METHOD_OS_VERSION:
                result(UIDevice.current.systemVersion)
                break
            case SwiftDevicePlugin.METHOD_MODEL:
                result(UIDevice.current.model)
                break
            case SwiftDevicePlugin.METHOD_SDK_VERSION:
                result(UIDevice.current.systemVersion)
                break
            case SwiftDevicePlugin.METHOD_DEVICE_TYPE:
                UIDevice.current.userInterfaceIdiom
                result(UIDevice.current.userInterfaceIdiom == .phone ? "Phone" : "Tablet")
                break
            case SwiftDevicePlugin.METHOD_UUID:                
                result(self.getUUID())
                break
            case SwiftDevicePlugin.METHOD_LANGUAGE:
                result(NSLocale.preferredLanguages[0])
                break
            case SwiftDevicePlugin.METHOD_REGION:
                let value = (Locale.current as NSLocale).object(forKey: .countryCode) as! String
                result(value)
                break
            case SwiftDevicePlugin.METHOD_SCREEN_WIDTH_PIXELS:
                result(UIScreen.main.bounds.size.width * UIScreen.main.scale)
                break
            case SwiftDevicePlugin.METHOD_SCREEN_HEIGHT_PIXELS:
                result(UIScreen.main.bounds.size.height * UIScreen.main.scale)
                break
            case SwiftDevicePlugin.METHOD_SCREEN_SCALE:
                result(UIScreen.main.scale)
                break
            case SwiftDevicePlugin.METHOD_SCREEN_WIDTH_DPIS:
                result(UIScreen.main.bounds.size.width)
                break
            case SwiftDevicePlugin.METHOD_SCREEN_HEIGHT_DPIS:
                result(UIScreen.main.bounds.size.height)
                break
            default:
                result(FlutterMethodNotImplemented)
            }
    }

    func getUUID() -> String {
        let mainBundle = Bundle.main
        let appName = mainBundle.infoDictionary![String(kCFBundleNameKey)] as! String
        var strApplicationUUID = SAMKeychain.password(forService: appName, account: "incoding")
        if (strApplicationUUID == nil) {
            let currentDevice = UIDevice.current
            strApplicationUUID = currentDevice.identifierForVendor?.uuidString
            SAMKeychain.setPassword(strApplicationUUID!, forService: appName, account: "incoding")
        }
        return strApplicationUUID!
    }    
}


