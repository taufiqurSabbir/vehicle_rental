import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental/core/constants/app_colors.dart';
import '../../../data/models/vehicle_model.dart';
import '../../controllers/vehicle_controller.dart';

class RideDetailsPage extends StatefulWidget {
  final VehicleModel vehicle;

  const RideDetailsPage({Key? key, required this.vehicle}) : super(key: key);

  @override
  State<RideDetailsPage> createState() => _RideDetailsPageState();
}

class _RideDetailsPageState extends State<RideDetailsPage> {
  final VehicleController vehicleController = Get.put(VehicleController());

  late Timer _timer;
  Duration elapsed = Duration.zero;
  double liveAmount = 0.0;

  @override
  void initState() {
    super.initState();

    // Start time fallback
    if (widget.vehicle.startedTime != null) {
      elapsed = DateTime.now().difference(widget.vehicle.startedTime!);
    }

    _startTimer();
  }

  void _startTimer() {
    _calculateLiveAmount();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (widget.vehicle.startedTime != null) {
          elapsed = DateTime.now().difference(widget.vehicle.startedTime!);
        }
        _calculateLiveAmount();
      });
    });
  }

  void _calculateLiveAmount() {
    final costPerMinute = widget.vehicle.costPerMinute ?? 0.0;
    final totalMinutes = elapsed.inSeconds / 60;
    liveAmount = costPerMinute * totalMinutes;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String formatDuration(Duration d) {
    final hours = d.inHours.toString().padLeft(2, '0');
    final minutes = (d.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    final vehicle = widget.vehicle;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(vehicle.name ?? 'Ride Details'),
        backgroundColor: AppColors.primarycolor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  // Vehicle Image
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                    child: vehicle.image != null && vehicle.image!.isNotEmpty
                        ? Image.network(vehicle.image!,
                            height: 250.h,
                            width: double.infinity,
                            fit: BoxFit.cover)
                        : Container(
                            height: 200,
                            width: double.infinity,
                            color: Colors.grey[300],
                            child: const Icon(Icons.directions_car,
                                size: 100, color: Colors.grey),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _infoTile(
                            Icons.timer,
                            'Started at',
                            vehicle.startedTime != null
                                ? vehicle.startedTime!
                                    .toLocal()
                                    .toString()
                                    .substring(0, 19)
                                : 'Unknown'),
                        const SizedBox(height: 12),
                        _infoTile(Icons.watch_later_outlined, 'Elapsed Time',
                            formatDuration(elapsed),
                            isBold: true),
                        const SizedBox(height: 12),
                        _infoTile(
                            Icons.attach_money,
                            'Amount (\$/min: ${vehicle.costPerMinute?.toStringAsFixed(2) ?? '0.00'})',
                            '\$${liveAmount.toStringAsFixed(2)}',
                            isBold: true,
                            valueColor: Colors.green[700]),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  )
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Stop Ride Button
            ElevatedButton.icon(
              onPressed: () async {
               await vehicleController.stopRide(vehicle);
              },
              icon: const Icon(Icons.stop_circle_outlined),
              label: const Text('Stop Ride'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primarycolor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                textStyle:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(IconData icon, String label, String value,
      {bool isBold = false, Color? valueColor}) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primarycolor),
        const SizedBox(width: 12),
        Expanded(
          child: Text(label,
              style: const TextStyle(fontSize: 16, color: Colors.black87)),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 20 : 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: valueColor ?? Colors.black,
          ),
        ),
      ],
    );
  }
}
