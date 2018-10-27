package io.flutter.plugins.device

import android.app.Activity
import android.app.Application
import android.view.WindowManager
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

/**
 * DevicePlugin
 */
class DevicePlugin(private val registrar: Registrar, private val channel: MethodChannel) : MethodCallHandler {


  companion object {

    private val CHANNEL_NAME = "plugins.flutter.io/device_plugin"
    private val METHOD_OS = "os";
    private val METHOD_MANUFACTURER = "manufacturer"
    private val METHOD_OS_VERSION = "osVersion"
    private val METHOD_MODEL = "model"
    private val METHOD_SDK_VERSION = "sdkVersion"
    private val METHOD_DEVICE_TYPE = "deviceType"
    private val METHOD_UUID = "uuid"
    private val METHOD_LANGUAGE = "language"
    private val METHOD_REGION = "region"
    private val METHOD_SCREEN_WIDTH_PIXELS = "screenWidthPixels"
    private val METHOD_SCREEN_HEIGHT_PIXELS = "screenHeightPixels"
    private val METHOD_SCREEN_SCALE = "screenScale"
    private val METHOD_SCREEN_WIDTH_DPIS = "screenWidthDIPs"
    private val METHOD_SCREEN_HEIGHT_DPIS = "screenHeightDIPs"
    private val MIN_TABLET_PIXELS = 600



    /**
     * Plugin registration.
     */
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), CHANNEL_NAME)
      channel.setMethodCallHandler(DevicePlugin(registrar, channel))
    }
  }

  private val activity: Activity = registrar.activity()
  private val application: Application = registrar.context() as Application

  private var methodResult: Result? = null



  override fun onMethodCall(call: MethodCall, result: Result) {

    this.methodResult = result

    var metrics = android.util.DisplayMetrics()
    var window = application.getSystemService(android.content.Context.WINDOW_SERVICE) as WindowManager
    window.defaultDisplay.getRealMetrics(metrics)

    when (call.method) {

      METHOD_OS -> methodResult!!.success("Android")

      METHOD_MANUFACTURER -> methodResult!!.success(android.os.Build.MANUFACTURER)

      METHOD_OS_VERSION -> methodResult!!.success(android.os.Build.VERSION.RELEASE)

      METHOD_MODEL -> methodResult!!.success(android.os.Build.MODEL)

      METHOD_SDK_VERSION -> methodResult!!.success(android.os.Build.VERSION.SDK)

      METHOD_DEVICE_TYPE -> {

        var dips = Math.min(metrics.widthPixels, metrics.heightPixels) / metrics.density
        methodResult!!.success(if (dips >= MIN_TABLET_PIXELS) "Tablet" else "Phone")
      }

      METHOD_UUID -> methodResult!!.success(android.provider.Settings.Secure.getString(activity.contentResolver, android.provider.Settings.Secure.ANDROID_ID))

      METHOD_LANGUAGE -> methodResult!!.success(java.util.Locale.getDefault().language.replace("_", "-"))

      METHOD_REGION -> methodResult!!.success(java.util.Locale.getDefault().country)

      METHOD_SCREEN_WIDTH_PIXELS -> methodResult!!.success(metrics.widthPixels) // int

      METHOD_SCREEN_HEIGHT_PIXELS -> methodResult!!.success(metrics.heightPixels) // int

      METHOD_SCREEN_SCALE -> methodResult!!.success(metrics.density) // float

      METHOD_SCREEN_WIDTH_DPIS -> methodResult!!.success(metrics.widthPixels / metrics.density) // float

      METHOD_SCREEN_HEIGHT_DPIS -> methodResult!!.success(metrics.heightPixels / metrics.density) // float

      else -> result.notImplemented()
    }

  }

}
