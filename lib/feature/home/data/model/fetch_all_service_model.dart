import 'dart:convert';
import 'dart:developer';

class FetchAllServiceModel {
  String id;
  String userId;
  String? workerId; // Nullable
  String serviceName;
  String description;
  num firstHourCharge;
  num laterHourCharge;
  DateTime date;
  dynamic startTime; // Can be DateTime or String
  dynamic endTime; // Can be DateTime or String
  double latitude;
  double longitude;
  String serviceImg;
  DateTime createdAt;
  String? status;
  num? price;
  bool? payment;
  String? paymentId;
  DateTime? updatedAt; // Nullable

  FetchAllServiceModel({
    required this.id,
    required this.userId,
    this.workerId,
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
    this.status,
    this.price,
    this.payment,
    this.paymentId,
    this.updatedAt,
  });

  FetchAllServiceModel copyWith({
    String? id,
    String? userId,
    String? workerId,
    String? serviceName,
    String? description,
    num? firstHourCharge,
    num? laterHourCharge,
    DateTime? date,
    dynamic startTime,
    dynamic endTime,
    double? latitude,
    double? longitude,
    String? serviceImg,
    DateTime? createdAt,
    String? status,
    num? price,
    bool? payment,
    String? paymentId,
    DateTime? updatedAt,
  }) {
    return FetchAllServiceModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      workerId: workerId ?? this.workerId,
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
      status: status ?? this.status,
      price: price ?? this.price,
      payment: payment ?? this.payment,
      paymentId: paymentId ?? this.paymentId,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'userId': userId,
      'workerId': workerId,
      'service': serviceName,
      'description': description,
      'firstHourCharge': firstHourCharge,
      'laterHourCharge': laterHourCharge,
      'date': date.toIso8601String(),
      'startTime': startTime is DateTime
          ? (startTime as DateTime).toIso8601String()
          : startTime,
      'endTime': endTime is DateTime
          ? (endTime as DateTime).toIso8601String()
          : endTime,
      'latitude': latitude,
      'longitude': longitude,
      'serviceImg': serviceImg,
      'createdAt': createdAt.toIso8601String(),
      'status': status,
      'price': price,
      'payment': payment,
      'paymentId': paymentId,
      'updatedAt': updatedAt?.toIso8601String(),
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
      workerId: map['workerId'] as String?,
      serviceName: map['service'] as String,
      description: map['description'] as String,
      firstHourCharge: map['firstHourCharge'] as num,
      laterHourCharge: map['laterHourCharge'] as num,
      date: DateTime.parse(map['date'] as String),
      startTime: map['startTime'] is String
          ? map['startTime']
          : DateTime.parse(map['startTime'] as String),
      endTime: map['endTime'] is String
          ? map['endTime']
          : DateTime.parse(map['endTime'] as String),
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      serviceImg: map['serviceImg'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      status: map['status'] as String?,
      price: map['price'] as num?,
      payment: map['payment'] as bool?,
      paymentId: map['paymentId'] as String?,
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'] as String)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FetchAllServiceModel.fromJson(String source) =>
      FetchAllServiceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FetchAllServiceModel(id: $id, userId: $userId, workerId: $workerId, serviceName: $serviceName, description: $description, firstHourCharge: $firstHourCharge, laterHourCharge: $laterHourCharge, date: $date, startTime: $startTime, endTime: $endTime, latitude: $latitude, longitude: $longitude, serviceImg: $serviceImg, createdAt: $createdAt, status: $status, price: $price, payment: $payment, paymentId: $paymentId, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant FetchAllServiceModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.workerId == workerId &&
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
        other.createdAt == createdAt &&
        other.status == status &&
        other.price == price &&
        other.payment == payment &&
        other.paymentId == paymentId &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        workerId.hashCode ^
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
        createdAt.hashCode ^
        status.hashCode ^
        price.hashCode ^
        payment.hashCode ^
        paymentId.hashCode ^
        updatedAt.hashCode;
  }
}
