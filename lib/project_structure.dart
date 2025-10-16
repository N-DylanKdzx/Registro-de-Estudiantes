/*
 * PROYECTO: Sistema de Registro de Estudiantes
 * ARQUITECTURA: Clean Architecture
 * ESTADO: Provider
 * DISEÑO: Minimalista
 * 
 * ============================================
 * ESTRUCTURA DEL PROYECTO
 * ============================================
 * 
 * lib/
 * │
 * ├── main.dart                           # Punto de entrada
 * │
 * ├── core/                               # ⚙️ NÚCLEO DE LA APLICACIÓN
 * │   ├── di/
 * │   │   └── injection_container.dart    # Inyección de dependencias (GetIt)
 * │   ├── error/
 * │   │   └── failures.dart               # Tipos de errores (Failure)
 * │   ├── theme/
 * │   │   └── app_theme.dart             # Tema minimalista
 * │   └── usecases/
 * │       └── usecase.dart                # Clase base para UseCases
 * │
 * └── features/
 *     └── student_registration/          # 🎓 FEATURE: REGISTRO DE ESTUDIANTES
 *         │
 *         ├── domain/                     # 🎯 CAPA DE DOMINIO (Reglas de Negocio)
 *         │   ├── entities/
 *         │   │   └── student.dart        # Entidad Student (inmutable)
 *         │   ├── repositories/
 *         │   │   └── student_repository.dart  # Contrato del repositorio
 *         │   └── usecases/
 *         │       ├── register_student.dart    # UC: Registrar estudiante
 *         │       └── get_all_students.dart    # UC: Obtener todos
 *         │
 *         ├── data/                       # 💾 CAPA DE DATOS (Implementación)
 *         │   ├── models/
 *         │   │   └── student_model.dart  # Modelo con serialización JSON
 *         │   ├── datasources/
 *         │   │   ├── student_local_data_source.dart      # Contrato
 *         │   │   └── student_local_data_source_impl.dart # Implementación
 *         │   └── repositories/
 *         │       └── student_repository_impl.dart # Implementación del repo
 *         │
 *         └── presentation/               # 🎨 CAPA DE PRESENTACIÓN (UI + Estado)
 *             ├── providers/
 *             │   └── student_registration_provider.dart  # Estado (Provider)
 *             ├── pages/
 *             │   └── student_registration_screen.dart    # Pantalla principal
 *             └── widgets/
 *                 ├── custom_text_field.dart              # Campo de texto
 *                 └── success_dialog.dart                 # Diálogo de éxito
 * 
 * ============================================
 * FLUJO DE DATOS
 * ============================================
 * 
 * UI (Screen)
 *    ↓
 * Provider (State Management)
 *    ↓
 * UseCase (Business Logic)
 *    ↓
 * Repository Interface (Contract)
 *    ↓
 * Repository Implementation
 *    ↓
 * DataSource
 *    ↓
 * Local Storage / API
 * 
 * ============================================
 * DEPENDENCIAS PRINCIPALES
 * ============================================
 * 
 * - provider: ^6.1.1          # Estado
 * - get_it: ^8.0.2            # Inyección de dependencias
 * - dartz: ^0.10.1            # Programación funcional (Either)
 * - equatable: ^2.0.7         # Comparación por valor
 * 
 * ============================================
 * CARACTERÍSTICAS
 * ============================================
 * 
 * ✅ Clean Architecture (3 capas)
 * ✅ SOLID Principles
 * ✅ Dependency Injection
 * ✅ State Management (Provider)
 * ✅ Error Handling (Either)
 * ✅ Form Validation (Multi-layer)
 * ✅ Minimalist UI Design
 * ✅ Modular & Scalable
 * 
 * ============================================
 * REGLAS DE NEGOCIO
 * ============================================
 * 
 * - Nombre y apellidos obligatorios
 * - Email válido (formato estándar)
 * - Teléfono mínimo 10 dígitos
 * - Edad mínima: 16 años
 * - Número de matrícula único
 * 
 * ============================================
 * COMANDOS ÚTILES
 * ============================================
 * 
 * flutter pub get        # Instalar dependencias
 * flutter run            # Ejecutar aplicación
 * flutter analyze        # Analizar código
 * flutter format .       # Formatear código
 * flutter test           # Ejecutar tests (próximamente)
 * 
 * ============================================
 */
