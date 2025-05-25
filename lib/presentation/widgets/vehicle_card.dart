import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental/presentation/screens/ride_details/RideDetailsPage.dart';

import '../../core/utils/helpers.dart';
import '../../data/models/vehicle_model.dart';
import '../screens/vehicle_detail/vehicle_detail_screen.dart';

class VehicleCard extends StatelessWidget {
  final VehicleModel vehicle;
  final bool isRunning;

  VehicleCard({
    super.key,
    required this.vehicle,
    this.isRunning = false, // default false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Get.to(isRunning
              ? RideDetailsPage(vehicle: vehicle)
              : VehicleDetailScreen(vehicle: vehicle));
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                vehicle.image.toString(),
                width: 150.w,
                height: 100.w,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            vehicle.name.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      vehicle.type.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color:
                                getStatusColor(vehicle.status).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                getStatusIcon(vehicle.status),
                                size: 16,
                                color: getStatusColor(vehicle.status),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                getStatusText(vehicle.status),
                                style: TextStyle(
                                  color: getStatusColor(vehicle.status),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Icon(Icons.chevron_right_rounded,
                size: 28, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
