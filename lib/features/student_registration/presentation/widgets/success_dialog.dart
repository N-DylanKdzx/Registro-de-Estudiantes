import 'package:flutter/material.dart';
import 'package:student_registration/core/theme/app_theme.dart';
import 'package:student_registration/features/student_registration/domain/entities/student.dart';

/// Diálogo de éxito después de registrar un estudiante
class SuccessDialog extends StatelessWidget {
  final Student student;
  final VoidCallback onClose;

  const SuccessDialog({
    super.key,
    required this.student,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icono de éxito
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_outline,
                size: 64,
                color: AppColors.success,
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Título
            const Text(
              '¡Registro Exitoso!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Información del estudiante
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(
                    icon: Icons.person,
                    label: 'Nombre',
                    value: student.fullName,
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    icon: Icons.badge,
                    label: 'Matrícula',
                    value: student.enrollmentNumber,
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    icon: Icons.email,
                    label: 'Email',
                    value: student.email,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Mensaje
            Text(
              'El estudiante ha sido registrado correctamente en el sistema.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Botón
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onClose,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.success,
                ),
                child: const Text('Continuar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: AppColors.accent,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
