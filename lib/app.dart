import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental/splash/splash_screen.dart';

import 'core/bindings/controller_binidings.dart';
import 'core/constants/app_colors.dart';


class VehicleRental extends StatefulWidget {
  static GlobalKey<ScaffoldState> globalKey = GlobalKey();
  const VehicleRental({super.key});

  @override
  State<VehicleRental> createState() => _VehicleRentalState();
}

class _VehicleRentalState extends State<VehicleRental> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 640),
        builder: (context, child) => GetMaterialApp(
          theme: ThemeData(
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primarycolor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  )),
            ),
          ),
          key: VehicleRental.globalKey,
          debugShowCheckedModeBanner: false,
          title: 'Vehicle Rental',
          home: SplashScreen(),
          initialBinding: ControllerBinding(),

        ));
  }
}
