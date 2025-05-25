import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/running_ride_controller.dart';
import '../../widgets/vehicle_card.dart';
import '../ride_details/RideDetailsPage.dart';

// Make sure you import your controller and model
// import 'running_ride_controller.dart';
// import 'vehicle_model.dart';

class RunningRide extends StatefulWidget {
  const RunningRide({super.key});

  @override
  State<RunningRide> createState() => _RunningRideState();
}

class _RunningRideState extends State<RunningRide> {
  final RunningRideController controller = Get.put(RunningRideController());



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.vehicles.isEmpty) {
          return RefreshIndicator(
            onRefresh: controller.runningVehicles,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: const [
                SizedBox(height: 200),
                Center(
                  child: Text(
                    'No running rides available.',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.runningVehicles,
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: controller.vehicles.length,
            itemBuilder: (context, index) {
              final vehicle = controller.vehicles[index];

              return  VehicleCard(vehicle: vehicle, isRunning: true);
              ;
            },
          ),
        );
      }),
    );
  }
}
