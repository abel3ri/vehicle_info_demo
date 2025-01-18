import 'package:get/get.dart';
import 'package:vehicle_monitoring_demo/app/data/services/vehicle_service.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<VehicleService>(
      () => VehicleService(),
    );
  }
}
