import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vehicle_rental/core/constants/app_colors.dart';
import 'package:vehicle_rental/data/models/vehicle_model.dart';
import 'package:get/get.dart';
import '../../controllers/vehicle_controller.dart';
import '../../widgets/vechicle_title.dart';

class VehicleDetailScreen extends StatelessWidget {
  VehicleModel vehicle;

   VehicleDetailScreen({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    final isAvailable = vehicle.status.toString() == "available";
    final VehicleController vehicleController = Get.put(VehicleController());

    return Scaffold(
      backgroundColor: const Color(0xffF6F8FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Hero(
                  tag: vehicle.name.toString(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      vehicle.image.toString(),
                      width: 500.w,
                      height: 200.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                vehicle.name.toString(),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                vehicle.type.toString(),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    isAvailable ? Icons.check_circle : Icons.cancel,
                    color: isAvailable ? Colors.green : Colors.red,
                    size: 20,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    vehicle.status.toString(),
                    style: TextStyle(
                      fontSize: 15,
                      color: isAvailable ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              VechicleTitle(title: 'Location', value: vehicle.lat.toString(),),
              VechicleTitle(title: 'Battery', value: '${vehicle.battery}%',),
              VechicleTitle(title: 'Cost', value: '${vehicle.costPerMinute}\$/min',),
              const Spacer(),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                  backgroundColor: isAvailable ? AppColors.primarycolor : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: isAvailable
                    ? () async {
                 await vehicleController.BookRide(vehicle);
                }
                    : null,
                icon: const Icon(Icons.directions_bike),
                label: const Text(
                  "Book Now",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

