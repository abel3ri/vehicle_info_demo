class VehicleInfo {
  final String? name;
  final int? battery;
  final double? coolantTemp;
  final double? distance;
  final double? power;
  final double? rpm;
  final bool? isLocked;
  final int? remainingMins;

  VehicleInfo({
    this.name,
    this.battery,
    this.coolantTemp,
    this.distance,
    this.power,
    this.rpm,
    this.isLocked,
    this.remainingMins,
  });

  factory VehicleInfo.fromJson(Map<String, dynamic> json) {
    return VehicleInfo(
      name: json['name'] as String?,
      battery: (json['battery'] as num?)?.toInt(),
      coolantTemp: (json['coolant_temp'] as num?)?.toDouble(),
      distance: (json['distance'] as num?)?.toDouble(),
      power: (json['power'] as num?)?.toDouble(),
      rpm: (json['rpm'] as num?)?.toDouble(),
      isLocked: json['is_locked'] as bool?,
      remainingMins: (json['remaining_mins'] as num?)?.toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'battery': battery,
      'coolant_temp': coolantTemp,
      'distance': distance,
      'power': power,
      'rpm': rpm,
      'is_locked': isLocked,
      'remaining_mins': remainingMins,
    };
  }
}
