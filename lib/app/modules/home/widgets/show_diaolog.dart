import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_monitoring_demo/app/modules/home/controllers/home_controller.dart';
import 'package:vehicle_monitoring_demo/app/modules/home/widgets/r_text_field.dart';

Future<void> showEditDialog({
  required String type,
}) async {
  final homeController = Get.find<HomeController>();
  await showDialog(
    context: Get.context!,
    builder: (context) => AlertDialog(
      title: const Text("Update vehicle info"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (type == 'battery') ...[
            RTextField(
              controller: homeController.batteryController,
              labelText: "Battery",
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            RTextField(
              controller: homeController.powerController,
              labelText: "Power",
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            RTextField(
              controller: homeController.minsRemainingController,
              labelText: "Minutes remaining",
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            RTextField(
              controller: homeController.distanceController,
              labelText: "Range",
              keyboardType: TextInputType.number,
            ),
          ],
          if (type == 'rpm') ...[
            RTextField(
              controller: homeController.rpmController,
              labelText: "RPM",
              keyboardType: TextInputType.number,
            ),
          ],
          if (type == 'coolant') ...[
            RTextField(
              controller: homeController.coolantTempController,
              labelText: "Coolant Temp",
              keyboardType: TextInputType.number,
            ),
          ],
          const SizedBox(height: 8),
          FilledButton(
            onPressed: () async {
              await homeController.updateVehicleInfo();
            },
            child: Text(
              "Submit",
              style: context.textTheme.titleMedium!.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
