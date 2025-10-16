# 📚 Sistema de Registro de Estudiantes

Una aplicación Flutter moderna y minimalista para el registro de estudiantes, construida con **Clean Architecture** y las mejores prácticas de desarrollo.

## ✨ Características

- ✅ **Clean Architecture** - Separación clara de responsabilidades
- ✅ **Provider** - Gestión de estado reactiva y eficiente
- ✅ **Validaciones Robustas** - Validaciones en múltiples capas
- ✅ **Diseño Minimalista** - Interfaz limpia y moderna
- ✅ **Código Escalable** - Estructura modular y mantenible
- ✅ **Inyección de Dependencias** - GetIt para un código desacoplado
- ✅ **Programación Funcional** - Manejo de errores con Either (dartz)

## 🏗️ Arquitectura del Proyecto

```
lib/
├── core/
│   ├── di/
│   │   └── injection_container.dart      # Configuración de dependencias
│   ├── error/
│   │   └── failures.dart                 # Definición de errores
│   ├── theme/
│   │   └── app_theme.dart               # Tema minimalista
│   └── usecases/
│       └── usecase.dart                  # Caso de uso base
│
└── features/
    └── student_registration/
        ├── domain/                        # 🎯 CAPA DE DOMINIO
        │   ├── entities/
        │   │   └── student.dart          # Entidad Student
        │   ├── repositories/
        │   │   └── student_repository.dart  # Contrato del repositorio
        │   └── usecases/
        │       ├── register_student.dart    # Caso de uso: registrar
        │       └── get_all_students.dart    # Caso de uso: obtener todos
        │
        ├── data/                          # 💾 CAPA DE DATOS
        │   ├── models/
        │   │   └── student_model.dart       # Modelo de datos
        │   ├── datasources/
        │   │   ├── student_local_data_source.dart
        │   │   └── student_local_data_source_impl.dart
        │   └── repositories/
        │       └── student_repository_impl.dart  # Implementación del repositorio
        │
        └── presentation/                  # 🎨 CAPA DE PRESENTACIÓN
            ├── providers/
            │   └── student_registration_provider.dart  # Estado con Provider
            ├── pages/
            │   └── student_registration_screen.dart    # Pantalla principal
            └── widgets/
                ├── custom_text_field.dart              # Campo de texto personalizado
                └── success_dialog.dart                 # Diálogo de éxito
```

## 🔄 Flujo de Datos

```
UI (Screen) 
    ↓
Provider (State Management)
    ↓
UseCase (Business Logic)
    ↓
Repository (Abstract)
    ↓
Repository Implementation
    ↓
DataSource (Data Layer)
    ↓
Local Storage / API
```

## 📦 Dependencias

```yaml
dependencies:
  # State Management
  provider: ^6.1.1
  
  # Dependency Injection
  get_it: ^8.0.2
  
  # Functional Programming
  dartz: ^0.10.1
  
  # Utilities
  equatable: ^2.0.7
```

## 🚀 Instalación y Configuración

### 1. Instalar dependencias

```bash
flutter pub get
```

### 2. Ejecutar la aplicación

```bash
flutter run
```

## 💡 Uso de la Aplicación

### Registrar un Estudiante

1. Completa todos los campos del formulario:
   - **Información Personal**: Nombre, Apellidos, Fecha de Nacimiento
   - **Información de Contacto**: Email, Teléfono, Dirección
   - **Información Académica**: Número de Matrícula

2. Presiona el botón **"Registrar Estudiante"**

3. El sistema validará:
   - Campos obligatorios
   - Formato de email válido
   - Teléfono con mínimo 10 dígitos
   - Edad mínima de 16 años

4. Si el registro es exitoso, se mostrará un diálogo con la confirmación

## 🎯 Reglas de Negocio

Las validaciones están implementadas en la **capa de dominio** (UseCase):

- ✅ Nombre y apellidos obligatorios
- ✅ Email con formato válido
- ✅ Teléfono mínimo 10 dígitos
- ✅ Número de matrícula obligatorio
- ✅ Edad mínima: 16 años
- ✅ Todos los campos son obligatorios

## 🏛️ Principios SOLID Aplicados

### Single Responsibility Principle (SRP)
Cada clase tiene una única responsabilidad:
- `Student`: Representa la entidad
- `RegisterStudent`: Caso de uso de registro
- `StudentRepository`: Operaciones de datos

### Open/Closed Principle (OCP)
- Abstracciones (`StudentRepository`) abiertas a extensión
- Implementaciones cerradas a modificación

### Liskov Substitution Principle (LSP)
- `StudentModel` extiende `Student` sin romper el contrato

### Interface Segregation Principle (ISP)
- Interfaces específicas y cohesivas

### Dependency Inversion Principle (DIP)
- Capas superiores dependen de abstracciones
- Inyección de dependencias con GetIt

## 🎨 Diseño Minimalista

### Paleta de Colores

- **Primary**: #2C3E50 (Azul Oscuro)
- **Accent**: #3498DB (Azul Brillante)
- **Background**: #F8F9FA (Gris Muy Claro)
- **Success**: #27AE60 (Verde)
- **Error**: #E74C3C (Rojo)

### Características del Diseño

- ✨ Espaciado generoso
- 📐 Bordes redondeados (12-16px)
- 🎯 Sin elevaciones innecesarias
- 🔤 Tipografía clara y legible
- 🎨 Colores neutros con acentos sutiles

## 🧪 Testing (Próximas Mejoras)

```dart
// Ejemplo de test unitario para UseCase
test('should register student when data is valid', () async {
  // Arrange
  final student = RegisterStudentParams(...);
  
  // Act
  final result = await registerStudent(student);
  
  // Assert
  expect(result, isA<Right>());
});
```

## 🔧 Próximas Mejoras

- [ ] Persistencia con SQLite/Hive
- [ ] Lista de estudiantes registrados
- [ ] Búsqueda y filtrado
- [ ] Edición de estudiantes
- [ ] Exportar a PDF/Excel
- [ ] Modo oscuro
- [ ] Tests unitarios y de integración
- [ ] Internacionalización (i18n)

## 📝 Licencia

Este proyecto es de código abierto y está disponible bajo la licencia MIT.

## 👨‍💻 Autor

Desarrollado con ❤️ siguiendo las mejores prácticas de Flutter y Clean Architecture.

---

**¿Preguntas o sugerencias?** No dudes en abrir un issue o contribuir al proyecto.
