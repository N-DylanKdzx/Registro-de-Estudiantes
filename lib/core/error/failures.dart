import 'package:equatable/equatable.dart';

/// Clase base abstracta para todos los errores de la aplicación
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

/// Error de validación de formulario
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

/// Error del servidor o de datos
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Error de caché o almacenamiento local
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}
