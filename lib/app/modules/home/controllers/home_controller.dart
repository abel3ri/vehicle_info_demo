import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_monitoring_demo/app/data/models/vehicle_info.dart';
import 'package:vehicle_monitoring_demo/app/data/services/vehicle_service.dart';
import 'package:vehicle_monitoring_demo/app/modules/home/widgets/r_text_field.dart';

class HomeController extends GetxController {
  late VehicleService vehicleService;

  RxBool isLoading = false.obs;
  Rx<VehicleInfo?> vehicleInfo = Rx<VehicleInfo?>(null);

  StreamSubscription? vehicleInfoSubscription;

  final batteryController = TextEditingController();
  final minsRemainingController = TextEditingController();
  final powerController = TextEditingController();
  final distanceController = TextEditingController();
  final coolantTempController = TextEditingController();
  final rpmController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    vehicleService = Get.find<VehicleService>();
    fetchVehicleInfo();
  }

  void fetchVehicleInfo() {
    isLoading.value = true;
    vehicleInfoSubscription = vehicleService.fetchVehicleInfo().listen(
      (result) {
        result.fold((l) {
          vehicleInfo.value = null;
          isLoading.value = false;
          Get.snackbar("Error", l);
        }, (r) {
          vehicleInfo.value = r;
          isLoading.value = false;
        });
      },
      onError: (e) {
        Get.snackbar("Error", e);
        isLoading.value = false;
      },
    );
  }

  Future<void> showEditDialog({required String type}) async {
    await showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: Text("Update vehicle info"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (type == 'battery') ...[
              RTextField(
                controller: batteryController,
                labelText: "Battery",
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 8),
              RTextField(
                controller: powerController,
                labelText: "Power",
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 8),
              RTextField(
                controller: minsRemainingController,
                labelText: "Minutes remaining",
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 8),
              RTextField(
                controller: distanceController,
                labelText: "Range",
                keyboardType: TextInputType.number,
              ),
            ],
            if (type == 'rpm') ...[
              RTextField(
                controller: rpmController,
                labelText: "RPM",
                keyboardType: TextInputType.number,
              ),
            ],
            if (type == 'coolant') ...[
              RTextField(
                controller: coolantTempController,
                labelText: "Coolant Temp",
                keyboardType: TextInputType.number,
              ),
            ],
            SizedBox(height: 8),
            FilledButton(
              onPressed: () {},
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }

  String formatDuration(int minutes) {
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;
    if (hours > 0 && remainingMinutes > 0) {
      return "$hours hr $remainingMinutes min remaining";
    } else if (hours > 0) {
      return "$hours hr remaining";
    } else {
      return "$remainingMinutes min remaining";
    }
  }

  @override
  void onClose() {
    super.onClose();
    vehicleInfoSubscription?.cancel();

    batteryController.dispose();
    minsRemainingController.dispose();
    powerController.dispose();
    distanceController.dispose();
    coolantTempController.dispose();
    rpmController.dispose();
  }
}
