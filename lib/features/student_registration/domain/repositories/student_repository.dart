import 'package:dartz/dartz.dart';
import 'package:student_registration/core/error/failures.dart';
import 'package:student_registration/features/student_registration/domain/entities/student.dart';

/// Repositorio abstracto - Define el contrato para las operaciones con estudiantes
abstract class StudentRepository {
  /// Registra un nuevo estudiante
  Future<Either<Failure, Student>> registerStudent(Student student);
  
  /// Obtiene todos los estudiantes registrados
  Future<Either<Failure, List<Student>>> getAllStudents();
  
  /// Obtiene un estudiante por ID
  Future<Either<Failure, Student>> getStudentById(String id);
  
  /// Actualiza un estudiante existente
  Future<Either<Failure, Student>> updateStudent(Student student);
  
  /// Elimina un estudiante
  Future<Either<Failure, void>> deleteStudent(String id);
}
