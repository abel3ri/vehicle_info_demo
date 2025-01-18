import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:vehicle_monitoring_demo/app/data/models/vehicle_info.dart';

class VehicleService extends GetConnect {
  late FirebaseFirestore db;

  @override
  void onInit() {
    super.onInit();
    db = FirebaseFirestore.instance;
  }

  Stream<Either<String, VehicleInfo>> fetchVehicleInfo() async* {
    try {
      yield* db
          .collection("vehicle_info")
          .doc("vehicle_info")
          .snapshots()
          .map((snapshot) {
        if (!snapshot.exists || snapshot.data() == null) {
          return left<String, VehicleInfo>("Vehicle information not found.");
        }

        final data = snapshot.data()!;
        log(data.toString());
        final vehicleInfo = VehicleInfo.fromJson(data);
        log(vehicleInfo.toString());
        return right<String, VehicleInfo>(vehicleInfo);
      }).handleError((error) {
        return left(error.toString());
      });
    } on FirebaseException catch (e) {
      yield left("Firebase error: ${e.message}");
    } catch (e) {
      yield left("An error occurred: $e");
    }
  }

  Future<Either<String, void>> updateVehicleInfo(
      Map<String, dynamic> updatedData) async {
    try {
      final docRef = db.collection("vehicle_info").doc("vehicle_info");
      await docRef.update(updatedData);
      return right(null);
    } on FirebaseException catch (e) {
      log("Firebase error: ${e.message}");
      return left("Firebase error: ${e.message}");
    } catch (e) {
      log("An error occurred: $e");
      return left("An error occurred: $e");
    }
  }
}
