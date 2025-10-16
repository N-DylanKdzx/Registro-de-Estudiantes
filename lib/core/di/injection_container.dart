import 'package:get_it/get_it.dart';
import 'package:student_registration/features/student_registration/data/datasources/student_local_data_source.dart';
import 'package:student_registration/features/student_registration/data/datasources/student_local_data_source_impl.dart';
import 'package:student_registration/features/student_registration/data/repositories/student_repository_impl.dart';
import 'package:student_registration/features/student_registration/domain/repositories/student_repository.dart';
import 'package:student_registration/features/student_registration/domain/usecases/get_all_students.dart';
import 'package:student_registration/features/student_registration/domain/usecases/register_student.dart';
import 'package:student_registration/features/student_registration/presentation/providers/student_registration_provider.dart';

/// Instancia global del service locator
final sl = GetIt.instance;

/// Inicializa todas las dependencias de la aplicación
Future<void> initializeDependencies() async {
  // ============ Features - Student Registration ============
  
  // Providers
  sl.registerFactory(
    () => StudentRegistrationProvider(
      registerStudentUseCase: sl(),
      getAllStudentsUseCase: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => RegisterStudent(sl()));
  sl.registerLazySingleton(() => GetAllStudents(sl()));

  // Repository
  sl.registerLazySingleton<StudentRepository>(
    () => StudentRepositoryImpl(
      localDataSource: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<StudentLocalDataSource>(
    () => StudentLocalDataSourceImpl(),
  );

  // ============ Core ============
  // Aquí se pueden agregar dependencias core como HTTP client, SharedPreferences, etc.
}
