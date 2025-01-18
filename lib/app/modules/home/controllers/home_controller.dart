import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_monitoring_demo/app/data/models/vehicle_info.dart';
import 'package:vehicle_monitoring_demo/app/data/services/vehicle_service.dart';

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
          Get.snackbar(
            "Error",
            l,
            snackPosition: SnackPosition.BOTTOM,
          );
        }, (r) {
          vehicleInfo.value = r;
          initFields();
          isLoading.value = false;
        });
      },
      onError: (e) {
        Get.snackbar(
          "Error",
          e,
          snackPosition: SnackPosition.BOTTOM,
        );
        isLoading.value = false;
      },
    );
  }

  Future<void> toggleLock() async {
    await vehicleService.updateVehicleInfo({
      "is_locked": !vehicleInfo.value!.isLocked!,
    });
  }

  Future<void> updateVehicleInfo() async {
    isLoading.value = true;
    Get.back();
    final result = await vehicleService.updateVehicleInfo({
      "battery": int.parse(batteryController.text),
      "coolant_temp": double.parse(coolantTempController.text),
      "distance": double.parse(distanceController.text),
      "power": double.parse(powerController.text),
      "remaining_mins": int.parse(minsRemainingController.text),
      "rpm": double.parse(rpmController.text),
    });

    result.fold(
      (failure) {
        isLoading.value = false;
        Get.snackbar(
          "Error",
          failure,
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      (_) {
        isLoading.value = false;

        Get.snackbar(
          "Success",
          "Vehicle information updated successfully",
          snackPosition: SnackPosition.BOTTOM,
        );
      },
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

  void initFields() {
    if (vehicleInfo.value == null) return;
    batteryController.text = vehicleInfo.value!.battery.toString();
    minsRemainingController.text = vehicleInfo.value!.remainingMins.toString();
    powerController.text = vehicleInfo.value!.power.toString();
    distanceController.text = vehicleInfo.value!.distance.toString();
    rpmController.text = vehicleInfo.value!.rpm.toString();
    coolantTempController.text = vehicleInfo.value!.coolantTemp.toString();
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
