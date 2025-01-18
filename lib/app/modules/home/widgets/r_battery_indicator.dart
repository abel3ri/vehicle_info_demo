import 'package:flutter/material.dart';

class RBatteryIndicator extends StatelessWidget {
  final int batteryLevel;

  const RBatteryIndicator({super.key, required this.batteryLevel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${batteryLevel.toStringAsFixed(0)}%",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: 8),
        Container(
          width: 48,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: (batteryLevel / 100) * 100,
              decoration: BoxDecoration(
                color: batteryLevel > 20
                    ? (batteryLevel > 50 ? Colors.green : Colors.orange)
                    : Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
