import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental/presentation/screens/vehicle_list/vehicle_list_screen.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/vehicle_model.dart';

class RideSummaryPage extends StatelessWidget {
  final VehicleModel vehicle;
  final double totalAmount;
  final Duration totalDuration;

  const RideSummaryPage({
    Key? key,
    required this.vehicle,
    required this.totalAmount,
    required this.totalDuration,
  }) : super(key: key);

  String formatDuration(Duration d) {
    final hours = d.inHours.toString().padLeft(2, '0');
    final minutes = (d.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Ride Summary"),
        backgroundColor: AppColors.primarycolor,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 16.r,
                    offset: Offset(0, 8.h),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 24.h),
              child: Column(
                children: [
                  // Vehicle Image
                  if (vehicle.image != null && vehicle.image!.isNotEmpty)
                    Container(
                      height: 160.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        image: DecorationImage(
                          image: NetworkImage(vehicle.image!),
                          fit: BoxFit.cover,
                        ),

                      ),
                    )
                  else
                    Container(
                      height: 160.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Icon(
                        Icons.directions_car,
                        size: 80.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),

                  SizedBox(height: 24.h),

                  _infoRow("Vehicle", vehicle.name ?? "Unknown"),
                  SizedBox(height: 20.h),
                  _infoRow("Total Time", formatDuration(totalDuration)),
                  SizedBox(height: 20.h),
                  _infoRow("Rate", "\$${vehicle.costPerMinute?.toStringAsFixed(2) ?? '0.00'} / min"),
                  Divider(height: 48.h, thickness: 1.2),
                  _infoRow("Total Amount", "\$${totalAmount.toStringAsFixed(2)}",
                      isHighlight: true),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton.icon(
                onPressed: () {
                  Get.snackbar(
                    "Payment",
                    "Payment Successful",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: AppColors.primarycolor.withOpacity(0.9),
                    colorText: Colors.white,
                  );
                  Get.to(() => VehicleListScreen());
                },
                icon: Icon(Icons.payment, size: 26.sp),
                label: Text(
                  "Pay Now",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primarycolor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  elevation: 6,
                  shadowColor: AppColors.primarycolor.withOpacity(0.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value, {bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.grey[800],
              fontWeight: FontWeight.w500,
            )),
        Text(value,
            style: TextStyle(
              fontSize: isHighlight ? 22.sp : 18.sp,
              fontWeight: isHighlight ? FontWeight.bold : FontWeight.w500,
              color: isHighlight ? Colors.green[700] : Colors.grey[900],
            )),
      ],
    );
  }
}
