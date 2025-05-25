import 'package:flutter/material.dart';
import 'package:vehicle_rental/core/constants/asset.dart';
import 'package:get/get.dart';

import '../data/models/auth_utility.dart';
import '../presentation/screens/login/login_screen.dart';
import '../presentation/screens/vehicle_list/vehicle_list_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NavigationtoLogin();
  }

  Future<void> NavigationtoLogin() async {


    Future.delayed(const Duration(seconds: 3)).then((_) async {
      final islogin= await AuthUtlity.checkUserLogin();

      //get navigation
      if (mounted) {
      Get.to( islogin ? VehicleListScreen()  : LoginScreen() );
      }
    });}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(AssetUtils.logo,width: 400,),
      ),
    );
  }
}
