import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RCard extends StatelessWidget {
  const RCard({
    super.key,
    required this.child,
    this.padding,
    this.color,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? EdgeInsets.all(8),
        width: double.infinity,
        decoration: BoxDecoration(
          color: color ??
              (Get.isDarkMode
                  ? const Color.fromARGB(255, 39, 39, 39)
                  : const Color.fromARGB(255, 224, 224, 224)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: child,
      ),
    );
  }
}
