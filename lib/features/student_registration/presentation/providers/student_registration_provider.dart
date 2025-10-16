import 'package:flutter/foundation.dart';
import 'package:student_registration/core/usecases/usecase.dart';
import 'package:student_registration/features/student_registration/domain/entities/student.dart';
import 'package:student_registration/features/student_registration/domain/usecases/get_all_students.dart';
import 'package:student_registration/features/student_registration/domain/usecases/register_student.dart';

/// Estados posibles del formulario
enum StudentFormStatus {
  initial,
  loading,
  success,
  error,
}

/// Provider para manejar el estado del registro de estudiantes
class StudentRegistrationProvider extends ChangeNotifier {
  final RegisterStudent registerStudentUseCase;
  final GetAllStudents getAllStudentsUseCase;

  StudentRegistrationProvider({
    required this.registerStudentUseCase,
    required this.getAllStudentsUseCase,
  });

  // Estado del formulario
  StudentFormStatus _status = StudentFormStatus.initial;
  String? _errorMessage;
  List<Student> _students = [];
  Student? _lastRegisteredStudent;

  // Getters
  StudentFormStatus get status => _status;
  String? get errorMessage => _errorMessage;
  List<Student> get students => _students;
  Student? get lastRegisteredStudent => _lastRegisteredStudent;
  bool get isLoading => _status == StudentFormStatus.loading;
  bool get isSuccess => _status == StudentFormStatus.success;
  bool get isError => _status == StudentFormStatus.error;

  /// Registra un nuevo estudiante
  Future<void> registerStudent({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required DateTime dateOfBirth,
    required String address,
    required String enrollmentNumber,
  }) async {
    _status = StudentFormStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final params = RegisterStudentParams(
      firstName: firstName.trim(),
      lastName: lastName.trim(),
      email: email.trim().toLowerCase(),
      phoneNumber: phoneNumber.trim(),
      dateOfBirth: dateOfBirth,
      address: address.trim(),
      enrollmentNumber: enrollmentNumber.trim().toUpperCase(),
    );

    final result = await registerStudentUseCase(params);

    result.fold(
      (failure) {
        _status = StudentFormStatus.error;
        _errorMessage = failure.message;
        _lastRegisteredStudent = null;
      },
      (student) {
        _status = StudentFormStatus.success;
        _errorMessage = null;
        _lastRegisteredStudent = student;
        _students.add(student);
      },
    );

    notifyListeners();
  }

  /// Obtiene todos los estudiantes
  Future<void> loadStudents() async {
    _status = StudentFormStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await getAllStudentsUseCase(NoParams());

    result.fold(
      (failure) {
        _status = StudentFormStatus.error;
        _errorMessage = failure.message;
      },
      (studentsList) {
        _status = StudentFormStatus.success;
        _students = studentsList;
      },
    );

    notifyListeners();
  }

  /// Reinicia el estado del formulario
  void resetForm() {
    _status = StudentFormStatus.initial;
    _errorMessage = null;
    _lastRegisteredStudent = null;
    notifyListeners();
  }

  /// Limpia el mensaje de error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
