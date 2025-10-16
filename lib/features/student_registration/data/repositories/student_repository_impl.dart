import 'package:dartz/dartz.dart';
import 'package:student_registration/core/error/failures.dart';
import 'package:student_registration/features/student_registration/data/datasources/student_local_data_source.dart';
import 'package:student_registration/features/student_registration/data/models/student_model.dart';
import 'package:student_registration/features/student_registration/domain/entities/student.dart';
import 'package:student_registration/features/student_registration/domain/repositories/student_repository.dart';

/// Implementación concreta del StudentRepository
class StudentRepositoryImpl implements StudentRepository {
  final StudentLocalDataSource localDataSource;

  StudentRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, Student>> registerStudent(Student student) async {
    try {
      final studentModel = StudentModel.fromEntity(student);
      final result = await localDataSource.saveStudent(studentModel);
      return Right(result);
    } catch (e) {
      return Left(CacheFailure('Error al registrar el estudiante: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Student>>> getAllStudents() async {
    try {
      final students = await localDataSource.getAllStudents();
      return Right(students);
    } catch (e) {
      return Left(CacheFailure('Error al obtener los estudiantes: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Student>> getStudentById(String id) async {
    try {
      final student = await localDataSource.getStudentById(id);
      return Right(student);
    } catch (e) {
      return Left(CacheFailure('Error al obtener el estudiante: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Student>> updateStudent(Student student) async {
    try {
      final studentModel = StudentModel.fromEntity(student);
      final result = await localDataSource.updateStudent(studentModel);
      return Right(result);
    } catch (e) {
      return Left(CacheFailure('Error al actualizar el estudiante: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteStudent(String id) async {
    try {
      await localDataSource.deleteStudent(id);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Error al eliminar el estudiante: ${e.toString()}'));
    }
  }
}
