import 'dart:convert';
import 'dart:developer';

class FetchAllServiceModel {
  String id;
  String userId;
  String serviceName;
  String description;
  num firstHourCharge;
  num laterHourCharge;
  DateTime date;
  DateTime startTime;
  DateTime endTime;
  double latitude;
  double longitude;
  String serviceImg;
  DateTime createdAt;

  FetchAllServiceModel({
    required this.id,
    required this.userId,
    required this.serviceName,
    required this.description,
    required this.firstHourCharge,
    required this.laterHourCharge,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.latitude,
    required this.longitude,
    required this.serviceImg,
    required this.createdAt,
  });

  FetchAllServiceModel copyWith({
    String? id,
    String? userId,
    String? serviceName,
    String? description,
    num? firstHourCharge,
    num? laterHourCharge,
    DateTime? date,
    DateTime? startTime,
    DateTime? endTime,
    double? latitude,
    double? longitude,
    String? serviceImg,
    DateTime? createdAt,
  }) {
    return FetchAllServiceModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      serviceName: serviceName ?? this.serviceName,
      description: description ?? this.description,
      firstHourCharge: firstHourCharge ?? this.firstHourCharge,
      laterHourCharge: laterHourCharge ?? this.laterHourCharge,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      serviceImg: serviceImg ?? this.serviceImg,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'userId': userId,
      'service': serviceName,
      'description': description,
      'firstHourCharge': firstHourCharge,
      'laterHourCharge': laterHourCharge,
      'date': date.toIso8601String(),
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
      'serviceImg': serviceImg,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory FetchAllServiceModel.fromMap(Map<String, dynamic> map) {
    log(map.length.toString());
    map.forEach(
      (key, value) {
        log("key -> $key value -> $value");
      },
    );
    return FetchAllServiceModel(
      id: map['_id'] as String,
      userId: map['userId'] as String,
      serviceName: map['service'] as String,
      description: map['description'] as String,
      firstHourCharge: map['firstHourCharge'] as num,
      laterHourCharge: map['laterHourCharge'] as num,
      date: DateTime.parse(map['date'] as String),
      startTime: DateTime.parse(map['startTime'] as String),
      endTime: DateTime.parse(map['endTime'] as String),
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      serviceImg: map['serviceImg'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory FetchAllServiceModel.fromJson(String source) =>
      FetchAllServiceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FetchAllServiceModel(id: $id, userId: $userId, serviceName: $serviceName, description: $description, firstHourCharge: $firstHourCharge, laterHourCharge: $laterHourCharge, date: $date, startTime: $startTime, endTime: $endTime, latitude: $latitude, longitude: $longitude, serviceImg: $serviceImg, createdAt: $createdAt,)';
  }

  @override
  bool operator ==(covariant FetchAllServiceModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.serviceName == serviceName &&
        other.description == description &&
        other.firstHourCharge == firstHourCharge &&
        other.laterHourCharge == laterHourCharge &&
        other.date == date &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.serviceImg == serviceImg &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        serviceName.hashCode ^
        description.hashCode ^
        firstHourCharge.hashCode ^
        laterHourCharge.hashCode ^
        date.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        serviceImg.hashCode ^
        createdAt.hashCode;
  }
}
