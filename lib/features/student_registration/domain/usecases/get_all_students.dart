import 'package:dartz/dartz.dart';
import 'package:student_registration/core/error/failures.dart';
import 'package:student_registration/core/usecases/usecase.dart';
import 'package:student_registration/features/student_registration/domain/entities/student.dart';
import 'package:student_registration/features/student_registration/domain/repositories/student_repository.dart';

/// UseCase para obtener todos los estudiantes
class GetAllStudents implements UseCase<List<Student>, NoParams> {
  final StudentRepository repository;

  GetAllStudents(this.repository);

  @override
  Future<Either<Failure, List<Student>>> call(NoParams params) async {
    return await repository.getAllStudents();
  }
}
