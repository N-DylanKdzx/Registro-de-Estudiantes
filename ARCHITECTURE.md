# Documentación de Clean Architecture

## 📐 Estructura de Capas

### 1. CAPA DE DOMINIO (Domain Layer)
**Propósito**: Contiene la lógica de negocio pura e independiente de frameworks.

#### Entidades (`entities/`)
- **`Student`**: Clase inmutable que representa un estudiante
  - Campos: id, firstName, lastName, email, phoneNumber, dateOfBirth, address, enrollmentNumber
  - Extiende `Equatable` para comparación por valor
  - Método computed: `fullName`

#### Repositorios (`repositories/`)
- **`StudentRepository`**: Interfaz abstracta que define el contrato
  - `registerStudent()`
  - `getAllStudents()`
  - `getStudentById()`
  - `updateStudent()`
  - `deleteStudent()`

#### Casos de Uso (`usecases/`)
- **`RegisterStudent`**: Registra un nuevo estudiante
  - Valida reglas de negocio
  - Genera ID único
  - Retorna `Either<Failure, Student>`
  
- **`GetAllStudents`**: Obtiene todos los estudiantes
  - Sin parámetros (usa `NoParams`)
  - Retorna `Either<Failure, List<Student>>`

### 2. CAPA DE DATOS (Data Layer)
**Propósito**: Implementa las interfaces definidas en el dominio.

#### Modelos (`models/`)
- **`StudentModel`**: Extiende `Student` y añade serialización
  - `toJson()`: Convierte a Map
  - `fromJson()`: Crea desde Map
  - `fromEntity()`: Convierte desde entidad
  - `copyWith()`: Copia con modificaciones

#### Fuentes de Datos (`datasources/`)
- **`StudentLocalDataSource`**: Interfaz abstracta
- **`StudentLocalDataSourceImpl`**: Implementación con almacenamiento en memoria
  - En producción: usar SharedPreferences, SQLite, Hive, etc.

#### Repositorios (`repositories/`)
- **`StudentRepositoryImpl`**: Implementación concreta del repositorio
  - Maneja errores y los convierte a `Failure`
  - Coordina entre diferentes data sources

### 3. CAPA DE PRESENTACIÓN (Presentation Layer)
**Propósito**: UI y gestión de estado.

#### Providers (`providers/`)
- **`StudentRegistrationProvider`**: Gestión de estado con ChangeNotifier
  - Estados: initial, loading, success, error
  - Métodos: registerStudent(), loadStudents(), resetForm()
  - Notifica cambios a los listeners

#### Páginas (`pages/`)
- **`StudentRegistrationScreen`**: Pantalla principal
  - Formulario reactivo
  - Validaciones en tiempo real
  - Diálogos de éxito/error

#### Widgets (`widgets/`)
- **`CustomTextField`**: Campo de texto reutilizable
- **`SuccessDialog`**: Diálogo de confirmación

## 🔄 Flujo de Datos Detallado

### Registro de Estudiante

```
1. Usuario completa formulario
   ↓
2. Presiona "Registrar Estudiante"
   ↓
3. StudentRegistrationScreen valida formulario
   ↓
4. Llama a provider.registerStudent()
   ↓
5. Provider cambia estado a 'loading'
   ↓
6. Provider llama a RegisterStudent UseCase
   ↓
7. UseCase valida reglas de negocio:
   - Campos obligatorios
   - Formato de email
   - Longitud de teléfono
   - Edad mínima (16 años)
   ↓
8. UseCase crea entidad Student
   ↓
9. UseCase llama a StudentRepository.registerStudent()
   ↓
10. Repository convierte Student a StudentModel
   ↓
11. Repository llama a LocalDataSource.saveStudent()
   ↓
12. DataSource guarda en memoria (o BD)
   ↓
13. Resultado viaja de vuelta:
    DataSource → Repository → UseCase → Provider
   ↓
14. Provider actualiza estado:
    - Success: muestra diálogo
    - Error: muestra SnackBar
   ↓
15. UI se actualiza automáticamente (Consumer)
```

## 🎯 Principios Aplicados

### Dependency Inversion
```dart
// ✅ CORRECTO: Dependemos de abstracciones
class StudentRepositoryImpl implements StudentRepository {
  final StudentLocalDataSource localDataSource;
  // ...
}

// ❌ INCORRECTO: Dependemos de implementaciones
class StudentRepositoryImpl {
  final StudentLocalDataSourceImpl localDataSource;
  // ...
}
```

### Single Responsibility
```dart
// ✅ Cada clase tiene una única razón para cambiar
- Student: Cambios en la estructura de datos
- RegisterStudent: Cambios en reglas de negocio
- StudentRepository: Cambios en fuentes de datos
- StudentRegistrationProvider: Cambios en lógica de UI
```

### Separation of Concerns
```dart
// Domain: ¿QUÉ hace el sistema?
class RegisterStudent {
  Future<Either<Failure, Student>> call(params) { }
}

// Data: ¿CÓMO obtiene/guarda datos?
class StudentRepositoryImpl implements StudentRepository {
  Future<Either<Failure, Student>> registerStudent(student) { }
}

// Presentation: ¿CÓMO se muestra al usuario?
class StudentRegistrationProvider extends ChangeNotifier {
  Future<void> registerStudent(...) { }
}
```

## 🧩 Inyección de Dependencias

### GetIt Configuration
```dart
// Registro en injection_container.dart
sl.registerFactory(() => StudentRegistrationProvider(
  registerStudentUseCase: sl(),  // ← Resuelto automáticamente
  getAllStudentsUseCase: sl(),
));

sl.registerLazySingleton(() => RegisterStudent(sl()));
```

### Ventajas
1. **Testabilidad**: Fácil mockear dependencias
2. **Desacoplamiento**: Sin referencias directas
3. **Flexibilidad**: Cambiar implementaciones sin tocar código
4. **Mantenibilidad**: Configuración centralizada

## 📊 Manejo de Errores

### Either<Failure, Success>
```dart
// ✅ Manejo funcional de errores
final result = await registerStudent(params);

result.fold(
  (failure) => handleError(failure.message),
  (student) => showSuccess(student),
);
```

### Tipos de Failures
- **ValidationFailure**: Errores de validación
- **ServerFailure**: Errores de servidor/API
- **CacheFailure**: Errores de almacenamiento local

## 🧪 Testing Strategy

### Unit Tests
```dart
// Test del UseCase
test('should return Student when data is valid', () async {
  // Arrange
  when(mockRepository.registerStudent(any))
    .thenAnswer((_) async => Right(tStudent));
  
  // Act
  final result = await usecase(tParams);
  
  // Assert
  expect(result, Right(tStudent));
  verify(mockRepository.registerStudent(any));
});
```

### Widget Tests
```dart
testWidgets('should show success dialog when registration succeeds', 
  (tester) async {
  // Arrange
  when(mockProvider.registerStudent(...))
    .thenAnswer((_) async => /* success */);
  
  // Act
  await tester.tap(find.text('Registrar'));
  await tester.pumpAndSettle();
  
  // Assert
  expect(find.byType(SuccessDialog), findsOneWidget);
});
```

## 🔐 Validaciones en Múltiples Capas

### 1. Validaciones de UI (Presentación)
```dart
// En el formulario
validator: (value) {
  if (value == null || value.isEmpty) {
    return 'Campo obligatorio';
  }
  return null;
}
```

### 2. Validaciones de Negocio (Dominio)
```dart
// En el UseCase
String? _validateStudent(params) {
  final age = DateTime.now().difference(params.dateOfBirth).inDays ~/ 365;
  if (age < 16) {
    return 'El estudiante debe tener al menos 16 años';
  }
  return null;
}
```

### 3. Validaciones de Datos (Data)
```dart
// En el DataSource/Repository
if (!_isValidId(student.id)) {
  throw Exception('ID inválido');
}
```

## 📱 Ventajas de esta Arquitectura

### ✅ Escalabilidad
- Fácil agregar nuevas features sin afectar código existente
- Cada capa puede crecer independientemente

### ✅ Mantenibilidad
- Código organizado y fácil de entender
- Separación clara de responsabilidades

### ✅ Testabilidad
- Fácil crear tests para cada capa
- Mockear dependencias es simple

### ✅ Reutilización
- Casos de uso pueden usarse en múltiples UIs
- Repositorios pueden cambiar implementación

### ✅ Flexibilidad
- Cambiar de Provider a Bloc sin tocar dominio
- Cambiar de memoria a SQLite sin tocar UI

## 🚀 Próximos Pasos

1. **Agregar persistencia real**: SQLite, Hive, o SharedPreferences
2. **Implementar tests**: Unit, Widget, Integration
3. **Agregar más features**: Lista, edición, eliminación
4. **Mejorar UX**: Animaciones, loading states
5. **Internacionalización**: Soporte multi-idioma
6. **Tema oscuro**: Modo claro/oscuro
