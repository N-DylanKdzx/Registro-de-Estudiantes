import 'package:dartz/dartz.dart';
import 'package:student_registration/core/error/failures.dart';

/// Clase base abstracta para todos los casos de uso
abstract class UseCase<ResultType, Params> {
  Future<Either<Failure, ResultType>> call(Params params);
}

/// Clase para casos de uso sin parámetros
class NoParams {}
