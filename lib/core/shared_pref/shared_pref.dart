import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static Future<String?> setUserDeviceInfo({
    required String macAddress,
    required String deviceId,
    required String status,
    required String token,
    required String deviceKey,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('deviceId', deviceId);
    pref.setString('mac', macAddress);
    pref.setString('status', status);
    pref.setString('token', token); //INACTIVE
    pref.setString('deviceKey', deviceKey);
  }

  static Future<Map<String, dynamic>> getUserDeviceInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> userinfo = {
      'deviceId': pref.getString('deviceId') ?? '',
      'mac': pref.getString('mac') ?? '',
      'status': pref.getString('status') ?? '',
      'token': pref.getString('token') ?? '', //INACTIVE
      'deviceKey': pref.getString('deviceKey') ?? '',
    };
    return userinfo;
  }

  static Future<bool> getUserDeviceStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String status = pref.getString('status') ?? "";
    if (status == "INACTIVE" || status.isEmpty || status == "") {
      return false;
    } else {
      return true;
    }
  }
}
