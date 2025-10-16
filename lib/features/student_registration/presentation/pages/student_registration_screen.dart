import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_registration/core/theme/app_theme.dart';
import 'package:student_registration/features/student_registration/presentation/providers/student_registration_provider.dart';
import 'package:student_registration/features/student_registration/presentation/widgets/custom_text_field.dart';
import 'package:student_registration/features/student_registration/presentation/widgets/success_dialog.dart';

/// Pantalla principal de registro de estudiantes
class StudentRegistrationScreen extends StatefulWidget {
  const StudentRegistrationScreen({super.key});

  @override
  State<StudentRegistrationScreen> createState() => _StudentRegistrationScreenState();
}

class _StudentRegistrationScreenState extends State<StudentRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _enrollmentController = TextEditingController();
  
  DateTime? _selectedDate;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _enrollmentController.dispose();
    super.dispose();
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2005, 1, 1),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.accent,
              onPrimary: Colors.white,
              surface: AppColors.surface,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Por favor selecciona la fecha de nacimiento'),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }

      final provider = context.read<StudentRegistrationProvider>();
      
      provider.registerStudent(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        phoneNumber: _phoneController.text,
        dateOfBirth: _selectedDate!,
        address: _addressController.text,
        enrollmentNumber: _enrollmentController.text,
      );
    }
  }

  void _clearForm() {
    _formKey.currentState?.reset();
    _firstNameController.clear();
    _lastNameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _addressController.clear();
    _enrollmentController.clear();
    setState(() {
      _selectedDate = null;
    });
    context.read<StudentRegistrationProvider>().resetForm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Estudiantes'),
      ),
      body: Consumer<StudentRegistrationProvider>(
        builder: (context, provider, child) {
          // Mostrar diálogo de éxito
          if (provider.isSuccess && provider.lastRegisteredStudent != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => SuccessDialog(
                  student: provider.lastRegisteredStudent!,
                  onClose: () {
                    Navigator.of(context).pop();
                    _clearForm();
                  },
                ),
              );
            });
          }

          // Mostrar mensaje de error
          if (provider.isError && provider.errorMessage != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(provider.errorMessage!),
                  backgroundColor: AppColors.error,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
              provider.clearError();
            });
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Encabezado
                    _buildHeader(),
                    
                    const SizedBox(height: 32),
                    
                    // Formulario
                    _buildFormCard(provider),
                    
                    const SizedBox(height: 24),
                    
                    // Botones
                    _buildButtons(provider),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.accent.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.school_rounded,
            size: 48,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Nuevo Estudiante',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Complete el formulario con la información del estudiante',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
      ],
    );
  }

  Widget _buildFormCard(StudentRegistrationProvider provider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Información Personal
            _buildSectionTitle('Información Personal'),
            const SizedBox(height: 16),
            
            CustomTextField(
              controller: _firstNameController,
              label: 'Nombre',
              icon: Icons.person_outline,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El nombre es obligatorio';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            CustomTextField(
              controller: _lastNameController,
              label: 'Apellidos',
              icon: Icons.person_outline,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Los apellidos son obligatorios';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // Fecha de Nacimiento
            InkWell(
              onTap: () => _selectDate(context),
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Fecha de Nacimiento',
                  prefixIcon: const Icon(Icons.calendar_today_outlined),
                  suffixIcon: _selectedDate != null
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _selectedDate = null;
                            });
                          },
                        )
                      : null,
                ),
                child: Text(
                  _selectedDate != null
                      ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                      : 'Selecciona una fecha',
                  style: TextStyle(
                    color: _selectedDate != null
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Información de Contacto
            _buildSectionTitle('Información de Contacto'),
            const SizedBox(height: 16),
            
            CustomTextField(
              controller: _emailController,
              label: 'Email',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El email es obligatorio';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                  return 'Email no válido';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            CustomTextField(
              controller: _phoneController,
              label: 'Teléfono (ej: +51 918 006013)',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El teléfono es obligatorio';
                }
                // Validación básica en UI - la validación completa está en el UseCase
                final cleanPhone = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');
                if (!RegExp(r'^\+?\d{9,15}$').hasMatch(cleanPhone)) {
                  return 'Formato inválido (ej: +51 918 006013)';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            CustomTextField(
              controller: _addressController,
              label: 'Dirección',
              icon: Icons.location_on_outlined,
              maxLines: 2,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'La dirección es obligatoria';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 24),
            
            // Información Académica
            _buildSectionTitle('Información Académica'),
            const SizedBox(height: 16),
            
            CustomTextField(
              controller: _enrollmentController,
              label: 'Número de Matrícula',
              icon: Icons.badge_outlined,
              textCapitalization: TextCapitalization.characters,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El número de matrícula es obligatorio';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildButtons(StudentRegistrationProvider provider) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: provider.isLoading ? null : _clearForm,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: const BorderSide(color: AppColors.border),
            ),
            child: const Text(
              'Limpiar',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: provider.isLoading ? null : _submitForm,
            child: provider.isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Text('Registrar Estudiante'),
          ),
        ),
      ],
    );
  }
}
