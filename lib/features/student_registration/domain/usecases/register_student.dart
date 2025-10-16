import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:student_registration/core/error/failures.dart';
import 'package:student_registration/core/usecases/usecase.dart';
import 'package:student_registration/features/student_registration/domain/entities/student.dart';
import 'package:student_registration/features/student_registration/domain/repositories/student_repository.dart';

/// UseCase para registrar un estudiante
class RegisterStudent implements UseCase<Student, RegisterStudentParams> {
  final StudentRepository repository;

  RegisterStudent(this.repository);

  @override
  Future<Either<Failure, Student>> call(RegisterStudentParams params) async {
    // Validaciones de negocio
    final validationResult = _validateStudent(params);
    if (validationResult != null) {
      return Left(ValidationFailure(validationResult));
    }

    // Crear entidad Student
    final student = Student(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      firstName: params.firstName,
      lastName: params.lastName,
      email: params.email,
      phoneNumber: params.phoneNumber,
      dateOfBirth: params.dateOfBirth,
      address: params.address,
      enrollmentNumber: params.enrollmentNumber,
    );

    // Delegar al repositorio
    return await repository.registerStudent(student);
  }

  /// Validaciones de reglas de negocio
  String? _validateStudent(RegisterStudentParams params) {
    if (params.firstName.isEmpty) {
      return 'El nombre es obligatorio';
    }
    if (params.lastName.isEmpty) {
      return 'El apellido es obligatorio';
    }
    if (params.email.isEmpty || !_isValidEmail(params.email)) {
      return 'El email no es válido';
    }
    if (params.phoneNumber.isEmpty || !_isValidPhoneNumber(params.phoneNumber)) {
      return 'El teléfono no es válido (ej: +51 918 006013 o 918006013)';
    }
    if (params.enrollmentNumber.isEmpty) {
      return 'El número de matrícula es obligatorio';
    }
    
    // Validar que el estudiante sea mayor de edad (ejemplo de regla de negocio)
    final age = DateTime.now().difference(params.dateOfBirth).inDays ~/ 365;
    if (age < 16) {
      return 'El estudiante debe tener al menos 16 años';
    }
    
    return null;
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  /// Valida número de teléfono con formato internacional
  /// Acepta: +51 918 006013, +51918006013, 918006013, 918 006 013, etc.
  bool _isValidPhoneNumber(String phone) {
    // Remover espacios y caracteres comunes
    final cleanPhone = phone.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    
    // Validar formato: opcional +, seguido de dígitos (mínimo 9)
    // Acepta: +51918006013, 918006013, etc.
    return RegExp(r'^\+?\d{9,15}$').hasMatch(cleanPhone);
  }
}

/// Parámetros para el caso de uso RegisterStudent
class RegisterStudentParams extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final DateTime dateOfBirth;
  final String address;
  final String enrollmentNumber;

  const RegisterStudentParams({
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
        firstName,
        lastName,
        email,
        phoneNumber,
        dateOfBirth,
        address,
        enrollmentNumber,
      ];
}
