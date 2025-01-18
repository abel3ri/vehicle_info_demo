import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_monitoring_demo/app/modules/home/widgets/r_battery_indicator.dart';

class RBatteryDetails extends StatelessWidget {
  final int batteryLevel;
  final double energy;
  final double range;

  const RBatteryDetails({
    super.key,
    required this.batteryLevel,
    required this.energy,
    required this.range,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RBatteryIndicator(batteryLevel: batteryLevel),
        SizedBox(width: Get.width * 0.02),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: energy.toStringAsFixed(1),
                style: Theme.of(context).textTheme.titleLarge,
                children: [
                  TextSpan(
                    text: " kwh",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(
                text: range.toStringAsFixed(0),
                style: Theme.of(context).textTheme.titleLarge,
                children: [
                  TextSpan(
                    text: " km",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
