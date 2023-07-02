import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:trip_life/entity/models/address.dart';

class Activity extends Equatable {
  final String activityId;
  final String label;
  final String? description;
  final DateTime startDate;
  final DateTime endDate;
  final double? estimatedPrice;
  final Address address;

  const Activity(this.activityId, this.label, this.description, this.startDate,
      this.endDate, this.estimatedPrice, this.address);

  @override
  List<Object?> get props => [activityId, label, startDate, endDate];

  static fromJson(Map<String, dynamic> json) {
    return Activity(
        json['id'],
        json['label'],
        json['description'],
        json['startDate'],
        json['endDate'],
        json['estimatedPrice'],
        Address.fromJson(jsonDecode(json['address'])));
  }
}
