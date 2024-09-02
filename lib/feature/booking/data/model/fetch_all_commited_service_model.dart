import 'dart:convert';
import 'dart:developer';

class FetchAllCommitedServiceModel {
  String id;
  String? workerId;
  String serviceName;
  String serviceImg;
  num firstHourCharge;
  num laterHourCharge;
  DateTime date;
  String startTime;
  String endTime;
  String description;
  String status;
  num price;
  bool payment;
  String paymentId;
  double latitude;
  double longitude;
  DateTime createdAt;
  DateTime updatedAt;

  // New fields for userId and userName
  String userId;
  String userName;

  FetchAllCommitedServiceModel({
    required this.id,
    this.workerId,
    required this.serviceName,
    required this.serviceImg,
    required this.firstHourCharge,
    required this.laterHourCharge,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.description,
    required this.status,
    required this.price,
    required this.payment,
    required this.paymentId,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
    // Initialize the new fields
    required this.userId,
    required this.userName,
  });

  FetchAllCommitedServiceModel copyWith({
    String? id,
    String? workerId,
    String? serviceName,
    String? serviceImg,
    num? firstHourCharge,
    num? laterHourCharge,
    DateTime? date,
    String? startTime,
    String? endTime,
    String? description,
    String? status,
    num? price,
    bool? payment,
    String? paymentId,
    double? latitude,
    double? longitude,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userId,
    String? userName,
  }) {
    return FetchAllCommitedServiceModel(
      id: id ?? this.id,
      workerId: workerId ?? this.workerId,
      serviceName: serviceName ?? this.serviceName,
      serviceImg: serviceImg ?? this.serviceImg,
      firstHourCharge: firstHourCharge ?? this.firstHourCharge,
      laterHourCharge: laterHourCharge ?? this.laterHourCharge,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      description: description ?? this.description,
      status: status ?? this.status,
      price: price ?? this.price,
      payment: payment ?? this.payment,
      paymentId: paymentId ?? this.paymentId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'workerId': workerId,
      'service': serviceName,
      'serviceImg': serviceImg,
      'firstHourCharge': firstHourCharge,
      'laterHourCharge': laterHourCharge,
      'date': date.toIso8601String(),
      'startTime': startTime,
      'endTime': endTime,
      'description': description,
      'status': status,
      'price': price,
      'payment': payment,
      'paymentId': paymentId,
      'latitude': latitude,
      'longitude': longitude,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'userId': userId, // Include new fields in the map
      'userName': userName,
    };
  }

  factory FetchAllCommitedServiceModel.fromMap(Map<String, dynamic> map) {
    log(map.length.toString());
    map.forEach(
      (key, value) {
        log("key -> $key value -> $value");
      },
    );
    return FetchAllCommitedServiceModel(
      id: map['_id'] as String,
      workerId: map['workerId'] as String?,
      serviceName: map['service'] as String,
      serviceImg: map['serviceImg'] as String,
      firstHourCharge: map['firstHourCharge'] as num,
      laterHourCharge: map['laterHourCharge'] as num,
      date: DateTime.parse(map['date'] as String),
      startTime: map['startTime'] as String,
      endTime: map['endTime'] as String,
      description: map['description'] as String,
      status: map['status'] as String,
      price: map['price'] as num,
      payment: map['payment'] as bool,
      paymentId: map['paymentId'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
      userId: map['userId']['_id']
          as String, // Parse new fields from the nested map
      userName: map['userId']['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FetchAllCommitedServiceModel.fromJson(String source) =>
      FetchAllCommitedServiceModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FetchAllCommitedServiceModel(id: $id, workerId: $workerId, serviceName: $serviceName, serviceImg: $serviceImg, firstHourCharge: $firstHourCharge, laterHourCharge: $laterHourCharge, date: $date, startTime: $startTime, endTime: $endTime, description: $description, status: $status, price: $price, payment: $payment, paymentId: $paymentId, latitude: $latitude, longitude: $longitude, createdAt: $createdAt, updatedAt: $updatedAt, userId: $userId, userName: $userName)';
  }

  @override
  bool operator ==(covariant FetchAllCommitedServiceModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.workerId == workerId &&
        other.serviceName == serviceName &&
        other.serviceImg == serviceImg &&
        other.firstHourCharge == firstHourCharge &&
        other.laterHourCharge == laterHourCharge &&
        other.date == date &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.description == description &&
        other.status == status &&
        other.price == price &&
        other.payment == payment &&
        other.paymentId == paymentId &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.userId == userId &&
        other.userName == userName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        workerId.hashCode ^
        serviceName.hashCode ^
        serviceImg.hashCode ^
        firstHourCharge.hashCode ^
        laterHourCharge.hashCode ^
        date.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        description.hashCode ^
        status.hashCode ^
        price.hashCode ^
        payment.hashCode ^
        paymentId.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        userId.hashCode ^
        userName.hashCode;
  }
}
