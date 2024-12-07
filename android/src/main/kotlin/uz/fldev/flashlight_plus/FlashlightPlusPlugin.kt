package uz.fldev.flashlight_plus

import android.annotation.TargetApi
import android.content.Context
import android.hardware.camera2.CameraManager
import android.os.Build
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlashlightPlusPlugin */
class FlashlightPlusPlugin : FlutterPlugin, MethodCallHandler {

    private lateinit var channel: MethodChannel
    private var appContext: Context? = null

    private var cameraManager: CameraManager? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        appContext = flutterPluginBinding.applicationContext
        cameraManager =
            appContext!!.applicationContext.getSystemService(Context.CAMERA_SERVICE) as CameraManager
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flashlight_plus")
        channel.setMethodCallHandler(this)
    }

    @TargetApi(Build.VERSION_CODES.M)
    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "uz.fldev.flashlight_plus.isAvailableTorch" -> {
                try {
                    cameraManager.let {
                        result.success(isFlashlightAvailable(it!!))
                    }
                } catch (e: Exception) {
                    result.success(false)
                }
            }

            "uz.fldev.flashlight_plus.turnOnFlashLight" -> {
                try {
                    turnOnFlashLight(cameraManager!!)
                    result.success(true)
                } catch (e: Exception) {
                    result.success(null)
                }
            }

            "uz.fldev.flashlight_plus.turnOffFlashLight" -> {
                try {
                    turnOffFlashLight(cameraManager!!)
                    result.success(true)
                } catch (e: Exception) {
                    result.success(null)
                }
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        appContext = null
        cameraManager = null
        channel.setMethodCallHandler(null)
    }

    private fun isFlashlightAvailable(cameraManager: CameraManager): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            cameraManager.cameraIdList.any { cameraId ->
                try {
                    val cameraCharacteristics = cameraManager.getCameraCharacteristics(cameraId)
                    val hasFlash =
                        cameraCharacteristics.get(android.hardware.camera2.CameraCharacteristics.FLASH_INFO_AVAILABLE)
                    hasFlash == true
                } catch (e: Exception) {
                    false
                }
            }
        } else {
            false
        }
    }

    private fun turnOnFlashLight(cameraManager: CameraManager) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M && isFlashlightAvailable(cameraManager)) {
            val cameraId = cameraManager.cameraIdList[0]
            cameraManager.setTorchMode(cameraId, true)
        }
    }

    private fun turnOffFlashLight(cameraManager: CameraManager) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M && isFlashlightAvailable(cameraManager)) {
            val cameraId = cameraManager.cameraIdList[0]
            cameraManager.setTorchMode(cameraId, false)
        }
    }
}
