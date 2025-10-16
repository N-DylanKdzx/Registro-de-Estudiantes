import 'package:equatable/equatable.dart';

/// Entidad Student - Representa un estudiante en el dominio
class Student extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final DateTime dateOfBirth;
  final String address;
  final String enrollmentNumber;

  const Student({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.address,
    required this.enrollmentNumber,
  });

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        phoneNumber,
        dateOfBirth,
        address,
        enrollmentNumber,
      ];

  String get fullName => '$firstName $lastName';
}
