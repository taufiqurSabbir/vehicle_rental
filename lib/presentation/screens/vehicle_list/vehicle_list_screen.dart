import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controllers/vehicle_controller.dart';
import '../../widgets/vehicle_card.dart';
import 'package:get/get.dart';

import '../Running_ride/running_ride.dart';
import '../profile/profile_screen.dart';

class VehicleListScreen extends StatefulWidget {
  VehicleListScreen({super.key});

  @override
  State<VehicleListScreen> createState() => _VehicleListScreenState();
}

class _VehicleListScreenState extends State<VehicleListScreen>
    with SingleTickerProviderStateMixin {
  final VehicleController vehicleController = Get.put(VehicleController());



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Two tabs
      child: Scaffold(
        backgroundColor: const Color(0xffF6F8FB),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              const Text(
              "Vehicles",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                letterSpacing: -1,
              ),
            ),

            // Profile clickable text or icon
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()),
                );
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.person,
                    color: Colors.deepPurple,
                    size: 28,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Profile',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
              ],
            ),
                const SizedBox(height: 20),
                TabBar(
                  indicatorColor: Colors.blue,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Tab(text: "All Vehicles"),
                    Tab(text: "Running Rides"),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: TabBarView(
                    children: [
                      // First Tab: All Vehicles
                      Obx(() {
                        if (vehicleController.isLoading.value) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (vehicleController.vehicles.isEmpty) {
                          return const Center(
                              child: Text("No vehicles found"));
                        }

                        return ListView.separated(
                          itemCount: vehicleController.vehicles.length,
                          separatorBuilder: (_, __) =>
                          const SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            final vehicle =
                            vehicleController.vehicles[index];
                            return VehicleCard(vehicle: vehicle);
                          },
                        );
                      }),

                      // Second Tab: Running Rides
                      RunningRide(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
