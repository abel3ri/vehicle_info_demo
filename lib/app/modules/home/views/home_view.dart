import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart' hide Marker;
import 'package:vehicle_monitoring_demo/app/modules/home/views/car_location_view.dart';
import 'package:vehicle_monitoring_demo/app/modules/home/widgets/r_battery_details.dart';
import 'package:vehicle_monitoring_demo/app/modules/home/widgets/show_diaolog.dart';
import 'package:vehicle_monitoring_demo/core/controllers/theme_controller.dart';
import 'package:vehicle_monitoring_demo/core/widgets/r_card.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tesla Model 3"),
        titleTextStyle: context.textTheme.headlineLarge,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () async {
                Get.find<ThemeController>()
                    .changeTheme(Get.isDarkMode ? "light" : "dark");
              },
              child: SvgPicture.asset(
                width: 32,
                height: 32,
                Get.isDarkMode
                    ? "assets/dev-images/light.svg"
                    : "assets/dev-images/dark.svg",
                colorFilter: ColorFilter.mode(
                  Get.theme.colorScheme.error,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () {
          if (controller.isLoading.isTrue) {
            return Center(
              child: Lottie.asset(
                "assets/lotties/loading.json",
                width: 128,
                height: 128,
              ),
            );
          }
          if (controller.vehicleInfo.value == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Unable to load vehicle info",
                    style: context.textTheme.bodyLarge,
                  ),
                  IconButton(
                    onPressed: () async {
                      controller.vehicleInfoSubscription?.resume();
                    },
                    icon: const Icon(Icons.refresh_rounded),
                  ),
                ],
              ),
            );
          }

          final vehicleInfo = controller.vehicleInfo.value;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RCard(
                  child: Image.asset(
                    "assets/dev-images/car_image_1.png",
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 16),
                MasonryGridView.builder(
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return RCard(
                          onTap: () async {
                            await showEditDialog(type: "battery");
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Battery",
                                  style: context.textTheme.titleLarge),
                              const SizedBox(height: 8),
                              Text(
                                controller.formatDuration(
                                    vehicleInfo!.remainingMins!),
                              ),
                              RBatteryDetails(
                                batteryLevel: vehicleInfo.battery!,
                                energy: vehicleInfo.power!,
                                range: vehicleInfo.distance!,
                              ),
                            ],
                          ),
                        );
                      case 1:
                        final isLocked = vehicleInfo?.isLocked ?? true;
                        return RCard(
                          onTap: () async {
                            await controller.toggleLock();
                          },
                          child: Row(
                            children: [
                              Icon(
                                isLocked
                                    ? Icons.lock_rounded
                                    : Icons.lock_open_rounded,
                                size: 48,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                isLocked ? "Locked" : "Unlocked",
                                style: context.textTheme.titleLarge,
                              ),
                            ],
                          ),
                        );
                      case 2:
                        return RCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset(
                                    "assets/cloud-images/cloud-sun.svg",
                                    width: 64,
                                    height: 64,
                                  ),
                                  Text("26℃",
                                      style: context.textTheme.headlineMedium),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Text("Addis Ababa, Ethiopia"),
                            ],
                          ),
                        );
                      case 3:
                        return RCard(
                          onTap: () async {
                            await showEditDialog(type: "coolant");
                          },
                          child: Wrap(
                            children: [
                              Text(
                                "Coolant Temp",
                                style: context.textTheme.titleSmall,
                              ),
                              const SizedBox(width: 12),
                              Text("${vehicleInfo?.coolantTemp}",
                                  style: context.textTheme.titleLarge),
                            ],
                          ),
                        );
                      case 4:
                        return RCard(
                          onTap: () async {
                            await showEditDialog(type: "rpm");
                          },
                          child: Column(
                            children: [
                              const Icon(
                                Icons.speed,
                                size: 64,
                              ),
                              Wrap(
                                children: [
                                  Text(
                                    "RPM",
                                    style: context.textTheme.titleSmall,
                                  ),
                                  const SizedBox(width: 12),
                                  Text("${vehicleInfo?.rpm}",
                                      style: context.textTheme.titleLarge),
                                ],
                              ),
                            ],
                          ),
                        );
                      default:
                        return const SizedBox();
                    }
                  },
                ),
                const SizedBox(height: 16),
                Text("Car Location", style: context.textTheme.titleLarge),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  height: Get.height * 0.25,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: GoogleMap(
                          markers: {
                            const Marker(
                              markerId: MarkerId("car_location"),
                              position:
                                  LatLng(9.023253588586133, 38.751833094027624),
                            ),
                          },
                          initialCameraPosition: const CameraPosition(
                            zoom: 14,
                            target:
                                LatLng(9.023253588586133, 38.751833094027624),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 2,
                        right: 8,
                        child: IconButton(
                          onPressed: () {
                            Get.to(() => const CarLocationView());
                          },
                          icon: CircleAvatar(
                            radius: 16,
                            child: Icon(
                              Icons.fullscreen_rounded,
                              color: Get.theme.primaryColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
