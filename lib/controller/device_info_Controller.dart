import 'dart:developer';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';




class DeviceDetailsController extends GetxController {


  String ipAddress = '';
  String deviceNameInformation = '';
  RxString version = ''.obs;
  String deviceVersion = '';
  String deviceIds = '';
  bool disabled = false;



  deviceName() async {
    if (Platform.isAndroid)
    {
      DeviceInfoPlugin deviceName = DeviceInfoPlugin();
      AndroidDeviceInfo deviceNameInfo = await deviceName.androidInfo;
      deviceNameInformation = deviceNameInfo.type.toString();
      log('device Name Is.....$deviceNameInformation');
    }
    if (Platform.isIOS) {
      DeviceInfoPlugin deviceName = DeviceInfoPlugin();
      MacOsDeviceInfo deviceNameInfo = await deviceName.macOsInfo;
      deviceNameInformation = deviceNameInfo.computerName.toString();
      log('device Name Is.....$deviceNameInformation');
    }
  }


  // deviceId() async {
  //   if (Platform.isWindows){
  //     DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //     WindowsDeviceInfo deviceId = await deviceInfo.windowsInfo;
  //     deviceVersion = deviceId.deviceId.toString().replaceAll(RegExp(r'[{}]', multiLine: true), '');
  //     log('device version Is.....$deviceVersion');
  //
  //   }
  //   if (Platform.isMacOS) {
  //     DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //     MacOsDeviceInfo deviceId = await deviceInfo.macOsInfo;
  //     deviceVersion = deviceId.model.toString();
  //     log('device version Is.....$deviceVersion');
  //
  //   }
  // }






  @override
  void onInit() {
    super.onInit();
    deviceName();

  }
}