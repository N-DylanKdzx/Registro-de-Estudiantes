import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_registration/core/di/injection_container.dart';
import 'package:student_registration/core/theme/app_theme.dart';
import 'package:student_registration/features/student_registration/presentation/pages/student_registration_screen.dart';
import 'package:student_registration/features/student_registration/presentation/providers/student_registration_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializar dependencias
  await initializeDependencies();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => sl<StudentRegistrationProvider>(),
        ),
      ],
      child: MaterialApp(
        title: 'Registro de Estudiantes',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const StudentRegistrationScreen(),
      ),
    );
  }
}
