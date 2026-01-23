import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wise_players/core/colors/colors.dart';
import 'package:wise_players/core/routes/routes_path.dart';
import 'package:wise_players/core/shared_pref/shared_pref.dart';
import 'package:wise_players/core/widgets/custom_button.dart';
import 'package:wise_players/core/widgets/custom_text.dart';

import '../../../../core/utils/app_logo.dart';
import '../../../../core/utils/get_device_info.dart';
import '../../../../core/widgets/custom_textFormFiled.dart';
import '../../../../data/_api/api_services/api_services.dart';
import '../../../../data/_api/dio_client.dart';

class LoginWithMac extends StatefulWidget {
  static const String routeName = '/login_with_mac';
  const LoginWithMac({super.key});

  @override
  State<LoginWithMac> createState() => _LoginWithMacState();
}

class _LoginWithMacState extends State<LoginWithMac> {
  ApiService apiService = ApiService();
  String deviceMac = "";
  String deviceKey = "";
  TextEditingController macCtrl = TextEditingController();
  TextEditingController deviceKeyCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    getDeviceInfo0();
  }

  getDeviceInfo0() async {
    bool isActive = await SharedPref.getUserDeviceStatus();
    if (isActive == false) {
      final userDeviceInfo = await getDeviceInfo();

      final res = await apiService.loginWithMac({
        "deviceId": userDeviceInfo['macLikeId'],
        "deviceModel": userDeviceInfo['model']!,
        "osVersion": userDeviceInfo['androidVersion']!,
        "platform": "ANDROID",
      });
      final userData = await apiService.validateStatus({
        'fingerprint': userDeviceInfo['macLikeId'],
      });

      if (res.isSuccess && userData.isSuccess) {
        log("running this function userinfo devic get ${userData.data}");
        SharedPref.setUserDeviceInfo(
          macAddress: userDeviceInfo['macLikeId'] ?? "",
          deviceId: userData.data?['deviceId'] ?? "",
          status: userData.data?['status'] ?? "",
          token: userData.data?['token'] ?? "",
          deviceKey: userData.data?['token'] ?? "",
        );
      } else {
        log("Login with mac failed: ${res.error} or  ${userData.error}");
      }
    } else {
      log("Status is false");
      final data = await SharedPref.getUserDeviceInfo();
      deviceMac = data['mac'];
      deviceKey = data['deviceKey'];
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            appLogo(),
            Column(
              children: [
                CText(
                  "To Continue, Using The App",
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),

                CText(
                  "Activate your playlist",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 15),

                CustomTextFormFiled(
                  controller: macCtrl,
                  hintText: "Device Id: 45:45:AB:47:49:C9",
                  isEnabled: false,
                ),
                const SizedBox(height: 20),
                CustomTextFormFiled(
                  controller: macCtrl,
                  isEnabled: false,

                  hintText: "Device key: 485654",
                ),
                const SizedBox(height: 15),
                // CText("Device Id: 45:45:td:47:Ab:c9"),
                // const SizedBox(height: 15),

                // CText("Device key: 485654"),
                // const SizedBox(height: 15),
              ],
            ),
            Spacer(),
            CustomButton(
              child: CText("Activate"),
              onPressed: () {
                GoRouter.of(context).go(AppRoutes.dashboard);
              },
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     CustomButton(
            //       width: 150,
            //       child: CText("Cancel"),
            //       onPressed: () {
            //         log("Get device info called");
            //         getDeviceInfo0();
            //       },
            //       backgroundColor: AppColor.transparent,
            //       isBorderSide: true,
            //     ),
            //     SizedBox(width: 40),
            //     CustomButton(
            //       width: 150,
            //       child: CText("Ok"),
            //       onPressed: () {},
            //       isBorderSide: true,
            //       backgroundColor: AppColor.transparent,
            //     ),
            //   ],
            // ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
