import 'package:equatable/equatable.dart';

class Address extends Equatable {
  const Address(this.street, this.city, this.state, this.country, this.zipCode);

  final String city;
  final String country;
  final String state;
  final String street;
  final String zipCode;

  @override
  List<Object?> get props => [street, city, state, country, zipCode];

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'city': city,
      'state': state,
      'country': country,
      'zipCode': zipCode,
    };
  }
}
