class VehicleModel {
  final String id;
  final String name;
  final String type;
  final String status;
  final String image;
  final int battery;
  final double costPerMinute;
  final double lat;
  final double lng;
  final DateTime? startedTime; // nullable DateTime for started time

  VehicleModel({
    required this.id,
    required this.name,
    required this.type,
    required this.status,
    required this.image,
    required this.battery,
    required this.costPerMinute,
    required this.lat,
    required this.lng,
    this.startedTime,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      status: json['status'],
      image: json['image'],
      battery: json['battery'],
      costPerMinute: (json['cost_per_minute'] as num).toDouble(),
      lat: (json['location']['lat'] as num).toDouble(),
      lng: (json['location']['lng'] as num).toDouble(),
      startedTime: json['started_time'] != null
          ? DateTime.parse(json['started_time'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "type": type,
      "status": status,
      "image": image,
      "battery": battery,
      "cost_per_minute": costPerMinute,
      "location": {
        "lat": lat,
        "lng": lng,
      },
      "started_time": startedTime?.toIso8601String(),
    };
  }
}
