import 'package:student_registration/features/student_registration/data/datasources/student_local_data_source.dart';
import 'package:student_registration/features/student_registration/data/models/student_model.dart';

/// Implementación del DataSource local usando almacenamiento en memoria
/// En una aplicación real, se usaría SharedPreferences, SQLite, Hive, etc.
class StudentLocalDataSourceImpl implements StudentLocalDataSource {
  // Simulación de base de datos en memoria
  final List<StudentModel> _students = [];

  @override
  Future<StudentModel> saveStudent(StudentModel student) async {
    // Simular delay de red/IO
    await Future.delayed(const Duration(milliseconds: 500));
    
    _students.add(student);
    return student;
  }

  @override
  Future<List<StudentModel>> getAllStudents() async {
    // Simular delay de red/IO
    await Future.delayed(const Duration(milliseconds: 300));
    
    return List.from(_students);
  }

  @override
  Future<StudentModel> getStudentById(String id) async {
    // Simular delay de red/IO
    await Future.delayed(const Duration(milliseconds: 300));
    
    try {
      return _students.firstWhere((student) => student.id == id);
    } catch (e) {
      throw Exception('Estudiante no encontrado');
    }
  }

  @override
  Future<StudentModel> updateStudent(StudentModel student) async {
    // Simular delay de red/IO
    await Future.delayed(const Duration(milliseconds: 500));
    
    final index = _students.indexWhere((s) => s.id == student.id);
    if (index == -1) {
      throw Exception('Estudiante no encontrado');
    }
    
    _students[index] = student;
    return student;
  }

  @override
  Future<void> deleteStudent(String id) async {
    // Simular delay de red/IO
    await Future.delayed(const Duration(milliseconds: 300));
    
    _students.removeWhere((student) => student.id == id);
  }
}
