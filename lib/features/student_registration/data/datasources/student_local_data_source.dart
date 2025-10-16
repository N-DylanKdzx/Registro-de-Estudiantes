import 'package:student_registration/features/student_registration/data/models/student_model.dart';

/// DataSource abstracto - Define el contrato para las operaciones de datos
abstract class StudentLocalDataSource {
  /// Guarda un estudiante localmente
  Future<StudentModel> saveStudent(StudentModel student);
  
  /// Obtiene todos los estudiantes guardados localmente
  Future<List<StudentModel>> getAllStudents();
  
  /// Obtiene un estudiante por ID
  Future<StudentModel> getStudentById(String id);
  
  /// Actualiza un estudiante
  Future<StudentModel> updateStudent(StudentModel student);
  
  /// Elimina un estudiante
  Future<void> deleteStudent(String id);
}
