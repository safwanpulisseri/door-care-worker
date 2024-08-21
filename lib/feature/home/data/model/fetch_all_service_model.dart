// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

class FetchAllServiceModel {
  String id;
  String serviceName;
  String description;
  num firstHourCharge;
  num laterHourCharge;
  String serviceImg;
  DateTime createdAt;

  FetchAllServiceModel({
    required this.id,
    required this.serviceName,
    required this.description,
    required this.firstHourCharge,
    required this.laterHourCharge,
    required this.serviceImg,
    required this.createdAt,
  });

  FetchAllServiceModel copyWith({
    String? id,
    String? serviceName,
    String? description,
    num? firstHourCharge,
    num? laterHourCharge,
    String? serviceImg,
    DateTime? createdAt,
  }) {
    return FetchAllServiceModel(
      id: id ?? this.id,
      serviceName: serviceName ?? this.serviceName,
      description: description ?? this.description,
      firstHourCharge: firstHourCharge ?? this.firstHourCharge,
      laterHourCharge: laterHourCharge ?? this.laterHourCharge,
      serviceImg: serviceImg ?? this.serviceImg,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'service': serviceName,
      'description': description,
      'firstHourCharge': firstHourCharge,
      'laterHourCharge': laterHourCharge,
      'serviceImg': serviceImg,
      'createdAt': createdAt.toIso8601String,
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
      serviceName: map['service'] as String,
      description: map['description'] as String,
      firstHourCharge: map['firstHourCharge'] as num,
      laterHourCharge: map['laterHourCharge'] as num,
      serviceImg: map['serviceImg'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory FetchAllServiceModel.fromJson(String source) =>
      FetchAllServiceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FetchAllServiceModel(id: $id, serviceName: $serviceName, description: $description, firstHourCharge: $firstHourCharge, laterHourCharge: $laterHourCharge, serviceImg: $serviceImg, createdAt: $createdAt,)';
  }

  @override
  bool operator ==(covariant FetchAllServiceModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.serviceName == serviceName &&
        other.description == description &&
        other.firstHourCharge == firstHourCharge &&
        other.laterHourCharge == laterHourCharge &&
        other.serviceImg == serviceImg &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        serviceName.hashCode ^
        description.hashCode ^
        firstHourCharge.hashCode ^
        laterHourCharge.hashCode ^
        serviceImg.hashCode ^
        createdAt.hashCode;
  }
}
