import 'package:get/get.dart';
import 'package:vehicle_rental/presentation/controllers/running_ride_controller.dart';
import 'package:vehicle_rental/presentation/screens/vehicle_list/vehicle_list_screen.dart';
import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';
import '../../data/models/auth_utility.dart';
import '../../data/models/user_model.dart';
import '../../data/models/vehicle_model.dart';
import '../screens/ride_details/ride_summary.dart';

class VehicleController extends GetxController {
  var vehicles = <VehicleModel>[].obs;
  var isLoading = false.obs;

  Future<void> getVehicles() async {
    isLoading.value = true;
    try {
      final result = await APICaller().getrequest(ApiEndPoint.allVehicles);

      final int statusCode = result['statusCode'];
      final dynamic data = result['data'];

      if (statusCode == 200 && data is List) {
        vehicles.value = data.map((e) => VehicleModel.fromJson(e)).toList();
        update();
      } else {
        print(' Unexpected status code: $statusCode or data is not a List');
      }
    } catch (e) {
      print(' Error fetching vehicles: $e');
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> BookRide(VehicleModel vehicle) async {
    final String startedTime = DateTime.now().toIso8601String();
    try {
      final Vehiclebody = {
        "status": "running",
        "started_time": startedTime,
      };


      UserModel? fetchedUser = await AuthUtlity.getUserInfo();
      print(fetchedUser?.id);

      final result = await APICaller()
          .putrequest(ApiEndPoint.VehicleDetails(vehicle.id), Vehiclebody);


      final userUpdateBody = {
        "total_trip": (fetchedUser?.totalTrip ?? 0) + 1,
      };

      await APICaller().putrequest(
        ApiEndPoint.loginUser(fetchedUser!.id!),
        userUpdateBody,
      );

      print('Ride started successfully: $result');
      print('result ====== $result');

      final int statusCode = result['statusCode'];
      if (statusCode == 200) {
        await getVehicles();
        Get.snackbar("Ride Started", "Vehicle ${vehicle.name} is now running");
        Get.to(VehicleListScreen());
      } else {
        Get.snackbar('Warning', "Something wrong ...!");
      }
    } catch (e) {
      print('Error booking ride: $e');
    }
  }

  Future<void> stopRide(VehicleModel vehicle) async {
    final DateTime endTime = DateTime.now();
    final Duration totalDuration = endTime.difference(vehicle.startedTime!);
    final double costPerMinute = vehicle.costPerMinute ?? 0.0;
    final double totalMinutes = totalDuration.inSeconds / 60;
    final double totalAmount = costPerMinute * totalMinutes;
    try {
      final Vehiclebody = {
        "status": "available",
      };

      final result = await APICaller()
          .putrequest(ApiEndPoint.VehicleDetails(vehicle.id), Vehiclebody);


      print('Ride started successfully: $result');
      print('result ====== $result');

      final int statusCode = result['statusCode'];
      if (statusCode == 200) {
        await getVehicles();
        await RunningRideController().runningVehicles();
        Get.snackbar("Ride Stopped", "Vehicle ${vehicle.name} is now Stopped");
        Get.to(() => RideSummaryPage(
          vehicle: vehicle,
          totalAmount: totalAmount,
          totalDuration: totalDuration,
        ));
      } else {
        Get.snackbar('Warning', "Something wrong ...!");
      }
    } catch (e) {
      print('Error booking ride: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    getVehicles();
  }
}
