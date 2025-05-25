import 'package:get/get.dart';
import '../../presentation/controllers/auth_controller.dart';
import '../../presentation/controllers/vehicle_controller.dart';
class ControllerBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => VehicleController());
  }
}
