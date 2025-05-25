import 'package:get/get.dart';

import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';
import '../../data/models/vehicle_model.dart';
class RunningRideController extends GetxController {
  var vehicles = <VehicleModel>[].obs;

  // Loading indicator
  var isLoading = false.obs;

  // Fetch vehicles with status "running"
  Future<void> runningVehicles() async {
    isLoading.value = true;
    update();

    try {
      final result = await APICaller().getrequest(ApiEndPoint.allVehicles);

      final int statusCode = result['statusCode'];
      final dynamic data = result['data'];

      if (statusCode == 200 && data is List) {
        // Filter vehicles where status == 'running'
        final runningVehiclesList = data
            .map((e) => VehicleModel.fromJson(e))
            .where((vehicle) => vehicle.status == 'running')
            .toList();

        vehicles.value = runningVehiclesList;
        update();
      } else {
        print('⚠️ Unexpected status code: $statusCode or data is not a List');
      }
    } catch (e) {
      print('❌ Error fetching vehicles: $e');
    } finally {
      isLoading.value = false;
      update();
    }
  }


  @override
  void onInit() {
    super.onInit();
    runningVehicles();
  }



}
