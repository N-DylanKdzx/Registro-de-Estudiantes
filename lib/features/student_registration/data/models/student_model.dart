import 'package:student_registration/features/student_registration/domain/entities/student.dart';

/// Modelo de datos que extiende la entidad Student
class StudentModel extends Student {
  const StudentModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.phoneNumber,
    required super.dateOfBirth,
    required super.address,
    required super.enrollmentNumber,
  });

  /// Convierte el modelo a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'address': address,
      'enrollmentNumber': enrollmentNumber,
    };
  }

  /// Crea un modelo desde JSON
  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
      address: json['address'] as String,
      enrollmentNumber: json['enrollmentNumber'] as String,
    );
  }

  /// Convierte una entidad Student a StudentModel
  factory StudentModel.fromEntity(Student student) {
    return StudentModel(
      id: student.id,
      firstName: student.firstName,
      lastName: student.lastName,
      email: student.email,
      phoneNumber: student.phoneNumber,
      dateOfBirth: student.dateOfBirth,
      address: student.address,
      enrollmentNumber: student.enrollmentNumber,
    );
  }

  /// Copia el modelo con valores actualizados
  StudentModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? address,
    String? enrollmentNumber,
  }) {
    return StudentModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      address: address ?? this.address,
      enrollmentNumber: enrollmentNumber ?? this.enrollmentNumber,
    );
  }
}
